#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LIBRARY_DIR="$ROOT/library/single-paper"

required_root_files=(
  "README.md"
  "input-metadata.json"
  "source-excerpts.md"
  "saved-run.json"
)

required_artifact_files=(
  "quick-pass.json"
  "method-card.json"
  "experiment-card.json"
  "claim-evidence-table.json"
  "limitations-card.json"
  "repro-notes.json"
  "critical-read-notes.json"
  "project-relevance.json"
  "uncertainty-summary.json"
  "paper-card.json"
  "paper-card.md"
)

missing=0
for paper_dir in "$LIBRARY_DIR"/*; do
  if [[ ! -d "$paper_dir" ]]; then
    continue
  fi

  artifacts_dir="$paper_dir/artifacts"

  for file in "${required_root_files[@]}"; do
    if [[ ! -f "$paper_dir/$file" ]]; then
      echo "MISSING: $paper_dir/$file"
      missing=1
    fi
  done

  for file in "${required_artifact_files[@]}"; do
    if [[ ! -f "$artifacts_dir/$file" ]]; then
      echo "MISSING: $artifacts_dir/$file"
      missing=1
    fi
  done
done

if [[ $missing -ne 0 ]]; then
  echo "single-paper library completeness check FAILED"
  exit 1
fi

echo "single-paper library completeness check PASSED"
