# Loop Trip-Count Estimator and Unroll Advisor

A production-focused LLVM New Pass Manager plugin that estimates loop trip
counts using ScalarEvolution and recommends unroll strategies based on stable,
conservative heuristics.

## Project overview

This tool surfaces loop trip-count information and unroll recommendations in a
human-readable table that is easy to audit during compiler optimization review.

## Problem statement

LLVM exposes powerful analysis infrastructure, but it can be difficult to see
why a loop is or is not a good unroll candidate without manual inspection of
ScalarEvolution and LoopInfo results. This project bridges that gap with a
lightweight, deterministic advisor pass.

## Features

- ScalarEvolution-backed trip-count classification (exact, bounded, unknown)
- Loop nesting awareness and call-site detection
- Conservative recommendation heuristics focused on code-size safety
- New Pass Manager plugin with opt loading support
- Scripted build, run, and verification workflows

## Architecture summary

- LoopInfo supplies loop structure and nesting depth.
- ScalarEvolution provides trip-count or symbolic bounds.
- A policy layer maps analysis output to a recommendation and rationale.

For a fuller design view, see docs/architecture.md and DESIGN.md.

## Repository structure

```
.
├── README.md
├── DESIGN.md
├── IMPLEMENTATION.md
├── EVALUATION.md
├── CONTRIBUTING.md
├── LICENSE
├── .gitignore
├── build.sh
├── run.sh
├── verify.sh
├── clean.sh
├── src/
│   └── LoopUnrollAdvisor.cpp
├── tests/
│   ├── test_fixed.c
│   ├── test_variable.c
│   ├── test_nested.c
│   ├── test_complex.c
│   ├── test_edge.c
│   ├── expected_outputs/
│   └── verify_output.sh
├── scripts/
│   ├── generate_ir.sh
│   └── run_all.sh
├── docs/
│   ├── screenshots/
│   ├── sample_outputs/
│   ├── architecture.md
│   └── demo.md
├── outputs/
│   └── logs/
└── .github/
    └── workflows/
        └── ci.yml
```

## Build instructions

```bash
./build.sh
```

Environment overrides:

- LLVM_VERSION (default: 18)
- LLVM_CONFIG (default: llvm-config-18)

## Run instructions

Generate IR for tests and run the advisor:

```bash
./scripts/generate_ir.sh
./run.sh
```

One-command workflow:

```bash
./scripts/run_all.sh
```

To run on specific IR files:

```bash
./run.sh tests/test_fixed.ll
```

## Verification instructions

```bash
./verify.sh
```

## Sample output

```
╔══ Loop Unroll Advisor — function: loop_tiny ══
║
║  Location                        Depth  Trip count       Recommendation   Rationale
║  -------------------------------------------------------------------------------
║  test_fixed.c:15                  1      4                Full unroll      Tiny static trip count (4); eliminating branch overhead entirely is worthwhile
║
╚===============================================================================
```

More examples are stored under docs/sample_outputs.

## Testing overview

- Scripted IR generation and verification are in scripts/generate_ir.sh and
  tests/verify_output.sh.
- Tests cover fixed bounds, variable bounds, nested loops, call-heavy loops, and
  pointer traversal edge cases.

## Limitations

- ScalarEvolution cannot model all control-flow patterns (e.g., data-dependent
  exits), so some loops remain unknown.
- Output relies on debug information for precise file:line locations.
- Recommendations are static heuristics and do not replace profile-guided data.

## Future improvements

- Add a JSON output mode for tooling integration.
- Expand heuristics with optional cost-model hooks.
- Integrate profile-guided thresholds when available.

## Dependencies

- LLVM tools and headers (18.x recommended)
- Clang (18.x recommended)
- CMake 3.16+
- C++17 compiler (g++ or clang++)
- Bash (for scripts)

## References

- LLVM LoopInfo and ScalarEvolution documentation
- LLVM New Pass Manager plugin interface
