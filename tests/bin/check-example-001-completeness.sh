#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
EXAMPLE_DIR="$ROOT/examples/single-paper/example-001"
ARTIFACTS_DIR="$EXAMPLE_DIR/artifacts"

required_files=(
  "$EXAMPLE_DIR/input-metadata.json"
  "$EXAMPLE_DIR/source-excerpts.md"
  "$EXAMPLE_DIR/README.md"
  "$ARTIFACTS_DIR/quick-pass.json"
  "$ARTIFACTS_DIR/method-card.json"
  "$ARTIFACTS_DIR/experiment-card.json"
  "$ARTIFACTS_DIR/claim-evidence-table.json"
  "$ARTIFACTS_DIR/limitations-card.json"
  "$ARTIFACTS_DIR/repro-notes.json"
  "$ARTIFACTS_DIR/critical-read-notes.json"
  "$ARTIFACTS_DIR/project-relevance.json"
  "$ARTIFACTS_DIR/uncertainty-summary.json"
  "$ARTIFACTS_DIR/paper-card.json"
  "$ARTIFACTS_DIR/paper-card.md"
)

missing=0
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "MISSING: $file"
    missing=1
  fi
done

if [[ $missing -ne 0 ]]; then
  echo "example-001 completeness check FAILED"
  exit 1
fi

echo "example-001 completeness check PASSED"
