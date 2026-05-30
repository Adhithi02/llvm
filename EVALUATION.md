# Evaluation

This report summarizes the test environment, methodology, and validation
results for the Loop Unroll Advisor.

## Test environment

- OS: Ubuntu 22.04 (x86_64)
- LLVM: 18.x toolchain
- CMake: 3.16+
- Compiler: clang-18

## Build configuration

- CMake Release build
- Tests compiled at -O1 with debug info

## Test methodology

1. Build the plugin with build.sh.
2. Compile test sources to LLVM IR with scripts/generate_ir.sh.
3. Run the advisor on each IR file.
4. Validate expected recommendations using tests/verify_output.sh.

## Test categories

- Constant trip counts
- Runtime-variable trip counts
- Nested loops
- Early exits
- Pointer traversal
- Call-heavy loops
- Non-unit strides
- Reductions
- Conditional calls

## Representative test cases

| Test | Function | Expected outcome |
| --- | --- | --- |
| test_fixed | loop_tiny | Full unroll (TC=4) |
| test_fixed | loop_large | Do not unroll (TC=1000) |
| test_variable | loop_ptr | Do not unroll (unknown) |
| test_nested | unroll_candidate | Full unroll on inner loop |
| test_complex | loop_with_call | Do not unroll (call) |
| test_edge | loop_stride_const | Full unroll (TC=4) |
| test_edge | loop_pointer_chase | Do not unroll (unknown) |
| test_reduction | sum_fixed | Full unroll (TC=8) |
| test_reduction | dot_product | Unroll x4 (TC=32) |
| test_conditional | loop_call_on_error | Do not unroll (call) |
| test_conditional | loop_intrinsic_hint | Unroll x4 (TC=16) |

## Validation results

- All scripted checks passed with the current heuristics.
- The advisor is stable across repeated runs and IR regeneration.

## Recommendation accuracy discussion

The policy intentionally prefers conservative choices for unknown or symbolic
trip counts. This avoids code-size regressions and aligns with typical compiler
safety heuristics.

## Failure cases

- Data-dependent exits (break/return) often yield unknown trip counts.
- Pointer chasing loops are not modeled by ScalarEvolution.
- Non-linear induction can yield symbolic or unknown results.

## Edge cases

- Call-heavy loops always return "Do not unroll" despite small trip counts.
- Nested loops use the same thresholds but add a nested-loop rationale.

## Baseline comparison

- Compared to raw ScalarEvolution dumps, this advisor provides a consistent,
  user-facing summary with explicit recommendations and rationales.

## Output excerpts

See docs/sample_outputs/loop_unroll_advisor_sample.txt for a representative
report snippet.
