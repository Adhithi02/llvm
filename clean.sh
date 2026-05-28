#!/usr/bin/env bash
set -euo pipefail

rm -rf build outputs/logs
rm -f tests/*.ll

echo "[ok] Cleaned build, logs, and generated IR"
