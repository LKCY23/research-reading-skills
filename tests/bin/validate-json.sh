#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

json_files=(
  "$ROOT/schemas/quick-pass.schema.json"
  "$ROOT/schemas/method-card.schema.json"
  "$ROOT/schemas/experiment-card.schema.json"
  "$ROOT/schemas/claim-evidence.schema.json"
  "$ROOT/schemas/limitations-card.schema.json"
  "$ROOT/schemas/repro-notes.schema.json"
  "$ROOT/schemas/critical-read-notes.schema.json"
  "$ROOT/schemas/project-relevance.schema.json"
  "$ROOT/schemas/paper-card.schema.json"
  "$ROOT/schemas/topic-scope.schema.json"
  "$ROOT/schemas/paper-set.schema.json"
  "$ROOT/schemas/comparison-matrix.schema.json"
  "$ROOT/schemas/literature-review.schema.json"
  "$ROOT/examples/single-paper/example-001/input-metadata.json"
  "$ROOT/examples/single-paper/example-001/artifacts/quick-pass.json"
  "$ROOT/examples/single-paper/example-001/artifacts/method-card.json"
  "$ROOT/examples/single-paper/example-001/artifacts/experiment-card.json"
  "$ROOT/examples/single-paper/example-001/artifacts/claim-evidence-table.json"
  "$ROOT/examples/single-paper/example-001/artifacts/limitations-card.json"
  "$ROOT/examples/single-paper/example-001/artifacts/repro-notes.json"
  "$ROOT/examples/single-paper/example-001/artifacts/critical-read-notes.json"
  "$ROOT/examples/single-paper/example-001/artifacts/project-relevance.json"
  "$ROOT/examples/single-paper/example-001/artifacts/paper-card.json"
)

layer2_example_dir="$ROOT/examples/literature-review/example-001"
if [[ -d "$layer2_example_dir" ]]; then
  json_files+=(
    "$layer2_example_dir/topic-scope.json"
    "$layer2_example_dir/paper-set.json"
    "$layer2_example_dir/comparison-matrix.json"
    "$layer2_example_dir/literature-review.json"
  )
fi

for file in "${json_files[@]}"; do
  python -m json.tool "$file" > /dev/null
  echo "OK: $file"
done

echo "JSON validation PASSED"
