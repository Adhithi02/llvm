# Expected outputs

This directory documents the high-level expectations for each test suite.
The verification script asserts these categories in a stable way.

## test_fixed

- loop_tiny: Full unroll
- loop_small: Unroll x4
- loop_large: Do not unroll
- loop_boundary: Full unroll

## test_variable

- loop_array: Do not unroll
- loop_ptr: Do not unroll

## test_nested

- unroll_candidate (inner): Full unroll

## test_complex

- loop_with_call: Do not unroll
- loop_early_exit: Do not unroll
- small_loop_call: Do not unroll

## test_edge

- loop_stride_const: Full unroll
- loop_pointer_chase: Do not unroll
- loop_call_heavy: Do not unroll
