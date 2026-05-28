#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

LLVM_VERSION="${LLVM_VERSION:-18}"
CLANG_BIN="${CLANG:-clang-${LLVM_VERSION}}"

if ! command -v "$CLANG_BIN" >/dev/null 2>&1; then
  CLANG_BIN="clang"
fi

if ! command -v "$CLANG_BIN" >/dev/null 2>&1; then
  echo "[fail] clang not found. Set CLANG or install LLVM." >&2
  exit 1
fi

STD_FLAGS="-O1 -g -S -emit-llvm"
FIXED_FLAGS="-O1 -g -S -emit-llvm -fno-vectorize -fno-unroll-loops"

echo "[info] Using clang: $CLANG_BIN"

for c_file in "$ROOT_DIR"/tests/*.c; do
  base_name="$(basename "$c_file" .c)"
  ll_file="$ROOT_DIR/tests/${base_name}.ll"
  flags="$STD_FLAGS"
  if [[ "$base_name" == "test_fixed" || "$base_name" == "test_edge" ]]; then
    flags="$FIXED_FLAGS"
  fi
  "$CLANG_BIN" $flags -o "$ll_file" "$c_file"
  echo "[ok] IR: $ll_file"
done
