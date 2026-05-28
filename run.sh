#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"

LLVM_VERSION="${LLVM_VERSION:-18}"
OPT_BIN="${OPT:-opt-${LLVM_VERSION}}"
PLUGIN_PATH="${PLUGIN:-$ROOT_DIR/build/LoopUnrollAdvisor.so}"

if ! command -v "$OPT_BIN" >/dev/null 2>&1; then
  echo "[fail] opt not found: $OPT_BIN" >&2
  exit 1
fi

if [[ ! -f "$PLUGIN_PATH" ]]; then
  echo "[fail] Missing plugin: $PLUGIN_PATH" >&2
  echo "Run: ./build.sh" >&2
  exit 1
fi

if ! ls "$ROOT_DIR"/tests/*.ll >/dev/null 2>&1; then
  echo "[fail] No IR files found under tests/." >&2
  echo "Run: ./scripts/generate_ir.sh" >&2
  exit 1
fi

mkdir -p "$ROOT_DIR/outputs/logs"

if (( "$#" )); then
  ll_files=("$@")
else
  ll_files=("$ROOT_DIR"/tests/*.ll)
fi

for ll_file in "${ll_files[@]}"; do
  if [[ ! -f "$ll_file" ]]; then
    echo "[fail] Missing IR file: $ll_file" >&2
    exit 1
  fi

  base_name="$(basename "$ll_file" .ll)"
  log_file="$ROOT_DIR/outputs/logs/${base_name}.log"

  echo ""
  echo "================================================================"
  echo ">>> $ll_file"
  echo "================================================================"
  "$OPT_BIN" -load-pass-plugin "$PLUGIN_PATH" \
    -passes="loop-unroll-advisor" \
    -disable-output "$ll_file" 2>&1 | tee "$log_file"
  echo "[ok] Wrote $log_file"
  echo ""
done

echo "[ok] All logs are under outputs/logs"
