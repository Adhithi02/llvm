#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

OPT_BIN="${OPT:-opt-18}"
PLUGIN_PATH="${PLUGIN:-$ROOT_DIR/build/LoopUnrollAdvisor.so}"

if [[ ! -f "$PLUGIN_PATH" ]]; then
  echo "[fail] Missing plugin: $PLUGIN_PATH"
  echo "Run: make build"
  exit 1
fi

failures=0

extract_function_block() {
  local output="$1"
  local function_name="$2"

  awk -v fn="$function_name" '
    index($0, "function: " fn) {in_block=1}
    in_block {print}
    in_block && $0 ~ /^╚/ {exit}
  ' <<<"$output"
}

assert_function_has_text() {
  local output="$1"
  local function_name="$2"
  local expected_text="$3"
  local message="$4"

  local block
  block="$(extract_function_block "$output" "$function_name")"

  if [[ -z "$block" ]]; then
    echo "  [fail] $message (function '$function_name' not found)"
    ((failures+=1))
    return
  fi

  if grep -Fq "$expected_text" <<<"$block"; then
    echo "  [ok] $message"
  else
    echo "  [fail] $message"
    ((failures+=1))
  fi
}

run_and_check() {
  local ll_file="$1"
  shift

  if [[ ! -f "$ll_file" ]]; then
    echo "[fail] Missing IR file: $ll_file"
    ((failures+=1))
    return
  fi

  printf "\n>>> Verifying %s\n" "$ll_file"
  local output
  output="$($OPT_BIN -load-pass-plugin "$PLUGIN_PATH" -passes="loop-unroll-advisor" -disable-output "$ll_file" 2>&1 || true)"

  while (( "$#" )); do
    local function_name="$1"
    local expected_text="$2"
    local message="$3"
    assert_function_has_text "$output" "$function_name" "$expected_text" "$message"
    shift 3
  done
}

run_and_check "$ROOT_DIR/tests/test_fixed.ll" \
  'loop_tiny' 'Full unroll' 'fixed: loop_tiny is full unroll' \
  'loop_small' 'Unroll ×4' 'fixed: loop_small is unroll x4' \
  'loop_large' 'Do not unroll' 'fixed: loop_large is not unrolled' \
  'loop_boundary' 'Full unroll' 'fixed: loop_boundary is full unroll'

run_and_check "$ROOT_DIR/tests/test_variable.ll" \
  'loop_array' 'Do not unroll' 'variable: loop_array remains not unrolled' \
  'loop_ptr' 'Do not unroll' 'variable: loop_ptr remains not unrolled'

run_and_check "$ROOT_DIR/tests/test_nested.ll" \
  'unroll_candidate' 'Full unroll' 'nested: unroll_candidate inner loop is full unroll'

run_and_check "$ROOT_DIR/tests/test_complex.ll" \
  'loop_with_call' 'Do not unroll' 'complex: loop_with_call is not unrolled' \
  'loop_early_exit' 'Do not unroll' 'complex: loop_early_exit is not unrolled' \
  'small_loop_call' 'Do not unroll' 'complex: small_loop_call is not unrolled'

run_and_check "$ROOT_DIR/tests/test_edge.ll" \
  'loop_stride_const' 'Full unroll' 'edge: loop_stride_const is full unroll' \
  'loop_pointer_chase' 'Do not unroll' 'edge: loop_pointer_chase is not unrolled' \
  'loop_call_heavy' 'Do not unroll' 'edge: loop_call_heavy is not unrolled'

if (( failures > 0 )); then
  printf "\n[fail] Regression checks failed: %s\n" "$failures"
  exit 1
fi

printf "\n[ok] All regression checks passed\n"
