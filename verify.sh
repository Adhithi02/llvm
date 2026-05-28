#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"

LLVM_VERSION="${LLVM_VERSION:-18}"
OPT_BIN="${OPT:-opt-${LLVM_VERSION}}"
PLUGIN_PATH="${PLUGIN:-$ROOT_DIR/build/LoopUnrollAdvisor.so}"

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

OPT="$OPT_BIN" PLUGIN="$PLUGIN_PATH" "$ROOT_DIR/tests/verify_output.sh"
