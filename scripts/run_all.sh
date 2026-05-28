#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

"$ROOT_DIR/build.sh"
"$ROOT_DIR/scripts/generate_ir.sh"
"$ROOT_DIR/run.sh"
"$ROOT_DIR/verify.sh"
