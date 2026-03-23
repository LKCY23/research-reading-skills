#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
EXAMPLE_DIR="$ROOT/examples/literature-review/example-001"

required_files=(
  "$EXAMPLE_DIR/README.md"
  "$EXAMPLE_DIR/topic-scope.json"
  "$EXAMPLE_DIR/paper-set.json"
  "$EXAMPLE_DIR/comparison-matrix.json"
  "$EXAMPLE_DIR/literature-review.json"
  "$EXAMPLE_DIR/literature-review.md"
)

missing=0
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "MISSING: $file"
    missing=1
  fi
done

if [[ $missing -ne 0 ]]; then
  echo "literature-review example-001 completeness check FAILED"
  exit 1
fi

echo "literature-review example-001 completeness check PASSED"
