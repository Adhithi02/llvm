#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"

LLVM_VERSION="${LLVM_VERSION:-18}"
LLVM_CONFIG="${LLVM_CONFIG:-llvm-config-${LLVM_VERSION}}"

if ! command -v "$LLVM_CONFIG" >/dev/null 2>&1; then
  LLVM_CONFIG="llvm-config"
fi

if ! command -v "$LLVM_CONFIG" >/dev/null 2>&1; then
  echo "[fail] llvm-config not found. Set LLVM_CONFIG or install LLVM." >&2
  exit 1
fi

LLVM_DIR="$($LLVM_CONFIG --cmakedir)"
if [[ ! -d "$LLVM_DIR" ]]; then
  echo "[fail] LLVM cmake dir not found: $LLVM_DIR" >&2
  exit 1
fi

echo "[info] Using LLVM cmake dir: $LLVM_DIR"
cmake -S "$ROOT_DIR" -B "$ROOT_DIR/build" -DLLVM_DIR="$LLVM_DIR" -DCMAKE_BUILD_TYPE=Release
cmake --build "$ROOT_DIR/build"

echo "[ok] Built build/LoopUnrollAdvisor.so"
