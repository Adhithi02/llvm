# Implementation

This document captures the key implementation details and LLVM integration
points that make the advisor a stable New Pass Manager plugin.

## New Pass Manager integration

- The pass is a FunctionPass registered with the plugin entry point.
- Registration occurs via llvmGetPassPluginInfo and a pipeline callback.

```cpp
PB.registerPipelineParsingCallback(
  [](StringRef Name, FunctionPassManager &FPM, ... ) {
    if (Name == "loop-unroll-advisor") {
      FPM.addPass(LoopUnrollAdvisorPass{});
      return true;
    }
    return false;
  });
```

## Recursive loop traversal

- Top-level loops are pulled from LoopInfo.
- A recursive helper walks nested subloops.

## ScalarEvolution APIs used

- getSmallConstantTripCount: exact compile-time constants.
- getBackedgeTakenCount: symbolic or unknown backedge counts.
- getSmallConstantMaxTripCount: conservative upper bounds.

## Trip-count extraction logic

1. Try getSmallConstantTripCount.
2. If not constant, check getBackedgeTakenCount.
3. If symbolic, ask for a conservative maximum.

## Recommendation engine

- Combines trip-count classification, loop depth, and call detection.
- Produces a recommendation string and a rationale string.

## Debug metadata extraction

- Uses DILocation data from loop latch, header terminator, or fallback blocks.
- Falls back to IR names when no debug info exists.

## Nested loop analysis

- The loop depth from LoopInfo is used in the recommendation rationale.
- Nested loops are treated more conservatively for moderate trip counts.

## Handling symbolic trip counts

- Symbolic trip counts are labeled as bounded or symbolic.
- Recommendations default to no unroll to avoid speculative code growth.

## Handling unknown trip counts

- SCEVCouldNotCompute results are reported as unknown.
- Recommendations remain conservative.

## Call detection

- Any non-intrinsic CallBase within loop blocks blocks unrolling.

## Output formatting

- Results are emitted as a per-function table using raw_ostream.
- Column widths are fixed to keep logs readable.

## Build integration

- CMake builds a MODULE target for dynamic loading by opt.
- Scripts wrap CMake and opt to keep the workflow reproducible.

## Optimization-level considerations

- Tests are compiled at -O1 to keep loops intact while enabling SE analysis.
- Vectorization and loop unrolling are disabled for fixed-count tests.
