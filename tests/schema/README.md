# Schema validation notes

This directory is reserved for schema-level validation.

## Current expectations

At minimum, schema validation should check:
- every schema file is valid JSON
- `paper-card.schema.json` references valid local schema files
- example artifacts can be checked against their intended schema later

## Current baseline target

The first concrete validation target should be `examples/single-paper/example-001/`.

Priority files:
- `artifacts/quick-pass.json`
- `artifacts/method-card.json`
- `artifacts/experiment-card.json`
- `artifacts/claim-evidence-table.json`
- `artifacts/limitations-card.json`
- `artifacts/repro-notes.json`
- `artifacts/critical-read-notes.json`
- `artifacts/project-relevance.json`
- `artifacts/paper-card.json`

## Future direction

A later step can add executable schema checks, but the repository now has the directory and contract in place.
