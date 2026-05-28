# Contributing

Thanks for your interest in improving the Loop Unroll Advisor. This repository
is intentionally small and focused. Please keep contributions aligned with the
LLVM pass behavior and the engineering goals of the project.

## Development workflow

1. Create a feature branch.
2. Run the full workflow locally:

   ```bash
   ./build.sh
   ./scripts/generate_ir.sh
   ./run.sh
   ./verify.sh
   ```

3. Update or add tests when behavior changes.
4. Keep documentation in sync with implementation changes.

## Coding guidelines

- Prefer small, isolated changes and clear commit messages.
- Avoid changing the pass semantics unless the behavior is explicitly approved.
- Keep scripts portable and deterministic.

## Reporting issues

Please include:
- LLVM version
- OS and compiler version
- Steps to reproduce
- Relevant log snippets from outputs/logs
