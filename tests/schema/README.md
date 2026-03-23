# Schema validation notes

This directory is reserved for schema-level validation.

## Current expectations

At minimum, schema validation should check:
- every schema file is valid JSON
- `paper-card.schema.json` references valid local schema files
- example artifacts can be checked against their intended schema later

## Current baseline target

The first concrete validation target is `examples/single-paper/example-001/`.

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

## Executable checks

Current executable check:
- `tests/bin/validate-json.sh`

Run:
```bash
bash tests/bin/validate-json.sh
```

This validates JSON syntax for the current Layer 1 schemas and the `example-001` JSON artifacts.

## Future direction

A later step can add full schema-conformance checks, but the repository now has a minimal executable JSON validation layer in place.
