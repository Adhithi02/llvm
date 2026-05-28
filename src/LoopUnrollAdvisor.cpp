/**
 * LoopUnrollAdvisor.cpp
 * =====================
 * LLVM New-PM FunctionPass: estimates static trip counts for every loop in a
 * function using ScalarEvolution + LoopInfo and emits an unroll recommendation.
 *
 * Build:  see CMakeLists.txt / Makefile
 * Run:    opt-18 -load-pass-plugin ./build/LoopUnrollAdvisor.so \
 *                -passes="loop-unroll-advisor" -disable-output <ir.ll>
 *
 * Output columns (printed to stderr / stdout):
 *   Location | Loop depth | Estimated trip count | Recommendation | Rationale
 */

#include "llvm/Analysis/LoopAnalysisManager.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/TargetLibraryInfo.h"

#include <iomanip>
#include <sstream>
#include <string>

using namespace llvm;

// ─────────────────────────────────────────────────────────────────────────────
// Thresholds (compile-time knobs)
// ─────────────────────────────────────────────────────────────────────────────
static constexpr uint64_t FULL_UNROLL_MAX   = 8;   // trip count ≤ 8  → full unroll
static constexpr uint64_t UNROLL_X4_MAX     = 128; // trip count ≤ 128 → ×4 unroll
static constexpr unsigned COL_LOC           = 32;
static constexpr unsigned COL_DEPTH         = 7;
static constexpr unsigned COL_TC            = 18;
static constexpr unsigned COL_REC           = 18;

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Return "file:line" for the loop header.
/// Strategy (in priority order):
///   1. LoopID metadata  – most reliable at -O1; survives inlining
///   2. Header terminator DebugLoc  – present when the branch wasn't stripped
///   3. First non-zero DebugLoc in any header instruction
///   4. Scan all loop blocks for any DebugLoc with a non-zero line
///   5. Fall back to function/block name (no debug info compiled in)
static std::string loopLocation(const Loop *L) {
  BasicBlock *H = L->getHeader();
  if (!H) return "<unknown>";

  auto fmtLoc = [](StringRef file, unsigned line) -> std::string {
    std::string S;
    raw_string_ostream OS(S);
    // Strip directory prefix — keep only the filename for readability
    OS << sys::path::filename(file) << ":" << line;
    return OS.str();
  };

  // ── Strategy 1: LoopID metadata ──────────────────────────────────────────
  // Clang emits llvm.loop metadata on the loop latch branch.
  // The first operand of the MDNode is a self-reference; subsequent operands
  // are attribute nodes.  The latch terminator carries the DebugLoc of the
  // closing brace / last statement of the loop, which is the most accurate
  // source location available after optimization.
  if (BasicBlock *Latch = L->getLoopLatch()) {
    if (const Instruction *Term = Latch->getTerminator()) {
      if (const DILocation *Loc = Term->getDebugLoc()) {
        if (Loc->getLine() != 0)
          return fmtLoc(Loc->getFilename(), Loc->getLine());
      }
    }
  }

  // ── Strategy 2: header terminator ────────────────────────────────────────
  if (const Instruction *Term = H->getTerminator()) {
    if (const DILocation *Loc = Term->getDebugLoc()) {
      if (Loc->getLine() != 0)
        return fmtLoc(Loc->getFilename(), Loc->getLine());
    }
  }

  // ── Strategy 3: first instruction in header with non-zero line ───────────
  for (const Instruction &I : *H) {
    if (const DILocation *Loc = I.getDebugLoc()) {
      if (Loc->getLine() != 0)
        return fmtLoc(Loc->getFilename(), Loc->getLine());
    }
  }

  // ── Strategy 4: scan all blocks in the loop ───────────────────────────────
  for (const BasicBlock *BB : L->blocks()) {
    for (const Instruction &I : *BB) {
      if (const DILocation *Loc = I.getDebugLoc()) {
        if (Loc->getLine() != 0)
          return fmtLoc(Loc->getFilename(), Loc->getLine());
      }
    }
  }

  // ── Strategy 5: no debug info — use IR names ──────────────────────────────
  std::string S;
  raw_string_ostream OS(S);
  OS << H->getParent()->getName() << "/" << H->getName();
  return OS.str();
}

/// Attempt to extract a constant trip count via ScalarEvolution.
/// Returns 0 when the trip count cannot be determined statically.
static uint64_t getStaticTripCount(Loop *L, ScalarEvolution &SE) {
  // getSmallConstantTripCount returns 0 if not a compile-time constant.
  unsigned TC = SE.getSmallConstantTripCount(L);
  return static_cast<uint64_t>(TC);
}

/// Classify whether SE can at least bound the trip count (even if not exact).
enum class TCKind {
  Exact,     // constant known exactly
  Bounded,   // runtime value but SE has a max
  Unknown    // SE gives up entirely
};

static TCKind classifyTripCount(Loop *L, ScalarEvolution &SE,
                                 uint64_t &BoundOut) {
  uint64_t exact = getStaticTripCount(L, SE);
  if (exact > 0) {
    BoundOut = exact;
    return TCKind::Exact;
  }

  // Try to get a symbolic expression for the backedge-taken count.
  const SCEV *BTC = SE.getBackedgeTakenCount(L);
  if (isa<SCEVCouldNotCompute>(BTC)) {
    BoundOut = 0;
    return TCKind::Unknown;
  }

  // Check if SE can give us a max trip count
  unsigned MaxTC = SE.getSmallConstantMaxTripCount(L);
  if (MaxTC > 0) {
    BoundOut = MaxTC;
    return TCKind::Bounded;
  }

  BoundOut = 0;
  return TCKind::Bounded; // symbolic but computable
}

struct Recommendation {
  std::string action;    // "Full unroll" / "Unroll ×4" / "Do not unroll"
  std::string rationale;
};

static Recommendation advise(TCKind kind, uint64_t tripCount,
                              unsigned loopDepth, bool hasCall,
                              bool isNested) {
  // Loops with calls are almost never profitable to unroll
  if (hasCall) {
    return {"Do not unroll",
            "Loop body contains a function call; code-size growth not justified"};
  }

  switch (kind) {
  case TCKind::Exact:
    if (tripCount == 0) {
      return {"Do not unroll", "Trip count is zero; loop never executes"};
    }
    if (tripCount <= FULL_UNROLL_MAX) {
      return {"Full unroll",
              "Tiny static trip count (" + std::to_string(tripCount) +
                  "); eliminating branch overhead entirely is worthwhile"};
    }
    if (tripCount <= UNROLL_X4_MAX) {
      if (isNested) {
        return {"Unroll ×4",
                "Moderate trip count (" + std::to_string(tripCount) +
                    ") in nested loop; ×4 reduces branch overhead without "
                    "excessive register pressure"};
      }
      return {"Unroll ×4",
              "Moderate static trip count (" + std::to_string(tripCount) +
                  "); ×4 factor balances ILP improvement vs. code-size growth"};
    }
    return {"Do not unroll",
            "Large trip count (" + std::to_string(tripCount) +
                "); branch overhead is negligible; I-cache pressure not worth it"};

  case TCKind::Bounded:
    if (tripCount > 0 && tripCount <= FULL_UNROLL_MAX) {
      return {"Full unroll",
              "SE upper-bound ≤ " + std::to_string(tripCount) +
                  "; safe to peel/unroll fully"};
    }
    return {"Do not unroll",
            "Trip count is runtime-variable; static unrolling risks code bloat"};

  case TCKind::Unknown:
    return {"Do not unroll",
            "ScalarEvolution cannot determine trip count; unrolling is speculative"};
  }
  return {"Do not unroll", "Unhandled case"};
}

// ─────────────────────────────────────────────────────────────────────────────
// Pass
// ─────────────────────────────────────────────────────────────────────────────

struct LoopUnrollAdvisorPass : public PassInfoMixin<LoopUnrollAdvisorPass> {

  // Helper: does the loop body contain any real (non-intrinsic) call?
  static bool loopHasCall(const Loop *L) {
    for (BasicBlock *BB : L->blocks())
      for (const Instruction &I : *BB)
        if (const auto *CB = dyn_cast<CallBase>(&I)) {
          if (CB->getCalledFunction() &&
              CB->getCalledFunction()->isIntrinsic())
            continue;
          return true;
        }
    return false;
  }

  // Recursively analyse a loop and all its sub-loops.
  void analyseLoop(Loop *L, ScalarEvolution &SE,
                   std::vector<std::tuple<std::string,unsigned,std::string,
                                          std::string,std::string>> &rows) {
    uint64_t bound = 0;
    TCKind kind    = classifyTripCount(L, SE, bound);
    bool hasCall   = loopHasCall(L);
    bool isNested  = L->getLoopDepth() > 1;

    Recommendation rec = advise(kind, bound, L->getLoopDepth(),
                                 hasCall, isNested);

    // Build the trip-count display string
    std::string tcStr;
    switch (kind) {
    case TCKind::Exact:
      tcStr = std::to_string(bound);
      break;
    case TCKind::Bounded:
      tcStr = (bound > 0) ? ("≤ " + std::to_string(bound)) : "symbolic";
      break;
    case TCKind::Unknown:
      tcStr = "unknown";
      break;
    }

    rows.emplace_back(loopLocation(L),
                      L->getLoopDepth(),
                      tcStr,
                      rec.action,
                      rec.rationale);

    // Recurse into sub-loops
    for (Loop *SubL : *L)
      analyseLoop(SubL, SE, rows);
  }

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    if (F.isDeclaration()) return PreservedAnalyses::all();

    auto &LI = FAM.getResult<LoopAnalysis>(F);
    auto &SE = FAM.getResult<ScalarEvolutionAnalysis>(F);

    using Row = std::tuple<std::string,unsigned,std::string,
                           std::string,std::string>;
    std::vector<Row> rows;

    for (Loop *L : LI) // top-level loops
      analyseLoop(L, SE, rows);

    if (rows.empty()) return PreservedAnalyses::all();

    // ── Print table ──────────────────────────────────────────────────────────
    errs() << "\n";
    errs() << "╔══ Loop Unroll Advisor — function: " << F.getName() << " ══\n";
    errs() << "║\n";

    // Header
    auto pad = [](const std::string &s, unsigned w) -> std::string {
      if (s.size() >= w) return s.substr(0, w - 1) + "…";
      return s + std::string(w - s.size(), ' ');
    };

    errs() << "║  "
           << pad("Location",       COL_LOC)
           << pad("Depth", COL_DEPTH)
           << pad("Trip count",     COL_TC)
           << pad("Recommendation", COL_REC)
           << "Rationale\n";
    errs() << "║  " << std::string(COL_LOC + COL_DEPTH + COL_TC + COL_REC + 40, '-') << "\n";

    for (auto &[loc, depth, tc, action, rationale] : rows) {
      errs() << "║  "
             << pad(loc,    COL_LOC)
             << pad(std::to_string(depth), COL_DEPTH)
             << pad(tc,     COL_TC)
             << pad(action, COL_REC)
             << rationale << "\n";
    }
    errs() << "║\n╚" << std::string(79, '=') << "\n\n";

    return PreservedAnalyses::all(); // analysis-only; nothing modified
  }
};

// ─────────────────────────────────────────────────────────────────────────────
// Plugin registration (New PM)
// ─────────────────────────────────────────────────────────────────────────────

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "LoopUnrollAdvisor", "v1.0",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "loop-unroll-advisor") {
                    FPM.addPass(LoopUnrollAdvisorPass{});
                    return true;
                  }
                  return false;
                });
          }};
}
