# Loop Trip-Count Estimator and Unroll Advisor
## Design, Implementation, and Analysis Discussion

---

## Repository File Guide

This section explains what each file in the project does and how the pieces fit
together during build, test generation, pass execution, and regression checks.

### Core project files

| File | What it does |
|------|--------------|
| `LoopUnrollAdvisor.cpp` | Main LLVM New-PM plugin implementation. Defines the pass registration entry point, loop traversal, trip-count classification (`Exact`, `Bounded`, `Unknown`), recommendation policy (`Full unroll`, `Unroll ×4`, `Do not unroll`), and formatted reporting output. |
| `Makefile` | Primary developer workflow entrypoint. Builds the shared object plugin, compiles C tests to LLVM IR, runs the pass across test IR files, and executes regression verification with `make verify`. |
| `CMakeLists.txt` | CMake-based build configuration for environments that prefer CMake over Make. Provides an alternate way to compile the plugin against LLVM 18 toolchain settings. |
| `readme.md` | Project documentation (this file): architecture, analysis rationale, observed results, limitations, build/run commands, and verification behavior. |

### Test source files (C)

| File | Purpose |
|------|---------|
| `tests/test_fixed.c` | Constant-bound loop scenarios used to validate threshold behavior at tiny, moderate, large, and boundary trip counts. |
| `tests/test_variable.c` | Runtime-variable and pointer-driven loops used to validate conservative handling of symbolic/unknown trip counts. |
| `tests/test_nested.c` | Nested-loop workloads used to validate loop-depth reporting and inner-vs-outer recommendation behavior. |
| `tests/test_complex.c` | Realistic edge cases (calls in loop body, early exits, mixed control flow) used to validate safety-first heuristics. |

### Generated LLVM IR test files

These files are generated from the C test sources by `make tests` and consumed by
`make run` / `make verify`.

| File | Produced from | Purpose |
|------|---------------|---------|
| `tests/test_fixed.ll` | `tests/test_fixed.c` | IR input for constant-trip-count behavior checks. |
| `tests/test_variable.ll` | `tests/test_variable.c` | IR input for symbolic/unknown trip-count behavior checks. |
| `tests/test_nested.ll` | `tests/test_nested.c` | IR input for nested-loop analysis checks. |
| `tests/test_complex.ll` | `tests/test_complex.c` | IR input for call/early-exit and mixed-pattern checks. |

### Verification utility

| File | What it does |
|------|--------------|
| `tests/verify_output.sh` | Function-aware regression checker used by `make verify`. Runs `opt-18` with the plugin on each IR test file and confirms expected recommendation categories inside each target function block. |

### Build artifact

| Artifact | How it is used |
|----------|----------------|
| `LoopUnrollAdvisor.so` | Shared library plugin produced by `make build`. Loaded by `opt-18` via `-load-pass-plugin` when running the advisor pass. |

### Typical workflow across files

1. Implement or adjust advisor logic in `LoopUnrollAdvisor.cpp`.
2. Build plugin (`LoopUnrollAdvisor.so`) using rules in `Makefile` or `CMakeLists.txt`.
3. Generate `tests/*.ll` from `tests/*.c` via `make tests`.
4. Run advisor output inspection with `make run`.
5. Run stable recommendation checks with `make verify` (`tests/verify_output.sh`).

---

## 1. Architecture Overview

The pass is implemented as a **New Pass Manager `FunctionPass`** that walks every
loop tree in a function using `LoopInfo`, queries `ScalarEvolution` for trip-count
information, and emits a structured recommendation table to `errs()`.

```
FunctionPass::run(F, FAM)
  └─ for each top-level Loop in LoopInfo
       └─ analyseLoop(L, SE)           ← recursive (handles nesting)
            ├─ classifyTripCount()     ← queries ScalarEvolution
            ├─ loopHasCall()           ← blocks unroll if real call present
            └─ advise()                ← applies decision thresholds
```

### Key LLVM APIs used

| API | Purpose |
|-----|---------|
| `LoopAnalysis` (LoopInfo) | Enumerate loops; determine depth and nesting |
| `ScalarEvolutionAnalysis` | Query back-edge taken count, SCEV expressions |
| `SE.getSmallConstantTripCount(L)` | Returns constant TC or 0 |
| `SE.getBackedgeTakenCount(L)` | Returns symbolic SCEV or `SCEVCouldNotCompute` |
| `SE.getSmallConstantMaxTripCount(L)` | Returns conservative upper bound |
| `DILocation` | Extract source file/line for human-readable output |

---

## 2. Trip-Count Classification

Trip counts fall into three tiers:

```
TCKind::Exact    →  SE.getSmallConstantTripCount() > 0
TCKind::Bounded  →  backedge count is symbolic SCEV (not CouldNotCompute)
                    OR SE.getSmallConstantMaxTripCount() > 0
TCKind::Unknown  →  SE.getBackedgeTakenCount() == SCEVCouldNotCompute
```

`getSmallConstantTripCount` returns 0 unless the trip count is a **compile-time
integer constant** derivable purely from SCEV arithmetic — it does not return
large constants to avoid overflow. This means even `for (int i=0; i<1000; i++)`
returns a constant because 1000 fits in an unsigned.

---

## 3. Recommendation Logic

```
hasCall?     → Do not unroll  (code growth never justified beside a call)
TC == 0      → Do not unroll  (dead loop)
TC ≤  8      → Full unroll    (eliminate branch entirely; tiny code delta)
TC ≤ 128     → Unroll ×4      (reduce branch frequency; expose ILP)
TC >  128    → Do not unroll  (branch cost amortised; I-cache dominates)
Bounded/sym  → Do not unroll  (speculative unrolling risks bloat)
Unknown      → Do not unroll  (SE gave up; trust nothing)
```

**Why ×4 specifically?** Modern superscalar pipelines execute 4–8 instructions per
cycle. A ×4 unrolled body lets the compiler schedule 4 independent iterations to
fill execution units. Beyond ×8, register pressure tends to dominate.

**Why the call heuristic overrides everything?**  Inlining is a prerequisite to
useful unrolling. A non-inline call in the loop body:
1. Forces a save/restore of caller-saved registers every iteration.
2. Prevents the compiler from reordering across the call site.
3. Multiplied by N (the unroll factor) dramatically inflates code size.

LLVM's own `LoopUnrollPass` applies the same guard.

---

## 4. Observed Results — Test Suite

### test_fixed.c — constant bounds

| Function | Trip count | Recommendation | Notes |
|----------|-----------|---------------|-------|
| loop_tiny | 4 | **Full unroll** | TC ≤ 8 threshold |
| loop_small | 16 | **Unroll ×4** | TC ≤ 128 threshold |
| loop_large | 1000 | **Do not unroll** | TC > 128 |
| loop_boundary | 8 | **Full unroll** | TC == threshold (≤ 8) |

### test_variable.c — runtime bounds

| Function | Trip count | Recommendation | Notes |
|----------|-----------|---------------|-------|
| loop_param(n) | symbolic | **Do not unroll** | SE builds `{0,+,1}<n>` but TC is not constant |
| loop_array(arr, len) | ≤ INT_MAX | **Do not unroll** | SE gives INT_MAX as conservative max |
| loop_ptr (while) | unknown | **Do not unroll** | SE cannot model pointer-chasing |

### test_nested.c — nesting

| Function | Loop depth | TC | Recommendation |
|----------|-----------|-----|---------------|
| matrix_mul (outer i) | 1 | ≤ INT_MAX | Do not unroll |
| matrix_mul (middle j) | 2 | ≤ INT_MAX | Do not unroll |
| matrix_mul (inner k) | 3 | ≤ INT_MAX | Do not unroll |
| unroll_candidate (outer) | 1 | ≤ INT_MAX | Do not unroll |
| unroll_candidate (inner) | 2 | **4** | **Full unroll** |

The advisor correctly differentiates: the inner loop of `unroll_candidate` has a
fixed TC of 4 and is recommended for full unrolling, while the outer variable-bound
loop is left alone.

### test_complex.c — calls and unusual patterns

| Function | TC | hasCall | Recommendation |
|----------|-----|---------|---------------|
| loop_with_call | ≤ INT_MAX | yes (sqrt) | **Do not unroll** |
| loop_early_exit | unknown | no | **Do not unroll** (SE gives up on conditional break) |
| small_loop_call | 4 | yes (printf) | **Do not unroll** (call overrides tiny TC) |
| loop_exp_stride | 10 | no | SE reports exact count after strength reduction |

---

## 5. Cases Where Trip Count Cannot Be Determined Statically

This is the most important conceptual section of the assignment.

### 5.1 Runtime-Variable Bounds

```c
void f(int n) {
    for (int i = 0; i < n; i++) { ... }
}
```

SE produces a symbolic SCEV `{0,+,1}<%loop>` with backedge-taken count `(n - 1)`.
This is a valid symbolic expression, but **not a compile-time constant**. The pass
classifies this as `TCKind::Bounded` when SE can produce a max (e.g. INT_MAX for a
signed `int` bound), and recommends against unrolling since static unrolling by
factor F would require the compiler to insert a prologue of `n % F` iterations —
profitable only if the compiler knows F divides N.

### 5.2 Pointer Arithmetic and Linked-Structure Traversal

```c
while (*s++) len++;         // string length
Node *p = head;
while (p) p = p->next;     // linked list
```

SE returns `SCEVCouldNotCompute` for both. The iteration count depends on data
values unknown at compile time, and there is no closed-form recurrence SE can
express. This is classified `TCKind::Unknown`.

### 5.3 Conditional Exits (Break Statements)

```c
for (int i = 0; i < n; i++) {
    if (arr[i] == sentinel) break;
    ...
}
```

The early exit introduces a second exiting block. SE models the loop-latch
back-edge count but cannot statically determine which exit will be taken. Result:
`getBackedgeTakenCount` may return `CouldNotCompute` or a symbolic max.

### 5.4 Non-Unit Strides with Non-Power-of-Two Bounds

```c
for (int i = 0; i < n; i += 3) { ... }
```

SE can often compute `ceil(n / 3)` symbolically, but if `n` is a runtime variable,
this remains symbolic. If `n` is a constant but `n % 3 != 0`, SCEV may still give
the exact count; if `n` is large, `getSmallConstantTripCount` returns 0.

### 5.5 Exponential / Multiplicative Induction

```c
for (int i = 1; i < 1024; i *= 2) { ... }
```

SE classifies the induction variable as a `{1,*,2}` geometric recurrence. The
backedge-taken count is mathematically `log2(1024) = 10`, but SCEV's arithmetic
is based on polynomial (AddRecExpr) recurrences, not logarithmic ones. Therefore
`getBackedgeTakenCount` may return `CouldNotCompute` even though a human can see
the loop runs exactly 10 times.

### 5.6 Floating-Point Induction Variables

```c
for (double x = 0.0; x < 1.0; x += 0.1) { ... }
```

SCEV does not model floating-point. This always gives `CouldNotCompute`.
Additionally, floating-point rounding means the loop may execute 9 or 10 times
depending on the platform — a genuine runtime indeterminacy.

### 5.7 Wrap-Around and Overflow

```c
for (unsigned i = 0; i != 0xFFFFFFFF; i++) { ... }
```

SCEV may conservatively refuse to compute the TC to avoid incorrect
wrap-around arithmetic. Similarly, a signed loop where the compiler cannot prove
the induction variable doesn't overflow will yield `CouldNotCompute`.

---

## 6. Building and Running

### Requirements

Use the following baseline environment:

| Component | Required version | Notes |
|----------|-------------------|-------|
| LLVM tools | 18.x | Needs `opt-18` and LLVM headers for plugin loading/build |
| Clang | 18.x | Used to compile test C files into LLVM IR (`.ll`) |
| C++ compiler | g++ with C++17 support | Builds `LoopUnrollAdvisor.so` |
| Build tool | make | Runs build, test, run, and verify targets |
| Shell | bash | Required by `tests/verify_output.sh` |

Check your toolchain:

```bash
llvm-config-18 --version
opt-18 --version
clang-18 --version
g++ --version
make --version
bash --version
```

Install requirements on Ubuntu/Debian:

```bash
sudo apt-get update
sudo apt-get install -y llvm-18 llvm-18-dev clang-18 build-essential make
```

### Terminal commands (build and run)

From the repository root, run:

```bash
make build
make tests
make run
make verify
```

One-command workflow:

```bash
make all
```

Clean generated artifacts:

```bash
make clean
```

```bash
# Prerequisites: LLVM 18 + Clang 18
# Ubuntu: apt-get install llvm-18 llvm-18-dev clang-18

make all        # build plugin + compile tests + run advisor

# Or step by step:
make build      # produces LoopUnrollAdvisor.so
make tests      # compiles tests/*.c → tests/*.ll
make run        # runs opt-18 with the plugin over every .ll
make verify     # checks key recommendation expectations automatically

# Manual invocation on any IR file:
opt-18 -load-pass-plugin ./LoopUnrollAdvisor.so \
       -passes="loop-unroll-advisor" \
       -disable-output your_program.ll
```

### Automated regression checks

`make verify` runs a lightweight consistency suite over the generated `tests/*.ll`
files and confirms key recommendation categories remain stable by matching
function names and recommendation text (for example: tiny constant loops stay
"Full unroll", loops with calls stay "Do not unroll"). This keeps checks
stable even when debug line numbers change.

### Compiler flags matter

| Flag | Effect on SE |
|------|-------------|
| `-O0` | Allocas not promoted; SE cannot see induction variables |
| `-O1` | mem2reg runs; SE finds canonical induction; trip counts visible |
| `-O2 -funroll-loops` | Loops may already be unrolled; pass sees trivial residues |
| `-fno-vectorize -fno-unroll-loops` | Prevents prior passes from consuming the loops |

The recommended analysis pipeline is `-O1 -fno-vectorize -fno-unroll-loops`
for preserving loop structure while enabling SE.