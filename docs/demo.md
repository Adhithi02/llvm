# Demo

This demo produces advisor output and captures logs suitable for review.

## Quick demo

```bash
./build.sh
./scripts/generate_ir.sh
./run.sh
```

One-command demo:

```bash
./scripts/run_all.sh
```

Logs are written to outputs/logs.

## Capturing screenshots

1. Open an outputs/logs/*.log file in the editor.
2. Capture a screenshot of the table output.
3. Place images under docs/screenshots.

## Suggested demo flow

- Demonstrate a fixed-count loop recommendation (Full unroll).
- Demonstrate a symbolic trip count (Do not unroll).
- Demonstrate nested loop analysis.
- Demonstrate call-heavy loop blocking.
