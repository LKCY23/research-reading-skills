# Schema validation notes

This directory is reserved for schema-level validation.

## Current expectations

At minimum, schema validation should check:
- every schema file is valid JSON
- aggregate schemas reference valid local schema files
- example artifacts can be checked against their intended schema later

## Current baseline targets

The first concrete validation targets are:
- `examples/single-paper/example-001/`
- `examples/literature-review/example-001/`

Canonical reusable paper records under `library/single-paper/` are a separate persistence surface and are not the current schema-validation baseline.

Priority files:
- Layer 1 aggregate and sub-artifacts under `examples/single-paper/example-001/artifacts/`
- Layer 2 `topic-scope.json`
- Layer 2 `paper-set.json`
- Layer 2 `comparison-matrix.json`
- Layer 2 `literature-review.json`

## Executable checks

Current executable check:
- `tests/bin/validate-json.sh`

Run:
```bash
bash tests/bin/validate-json.sh
```

This validates JSON syntax for the current Layer 1 and Layer 2 schemas plus the tracked example JSON artifacts.

## Future direction

A later step can add full schema-conformance checks, but the repository now has a minimal executable JSON validation layer in place.
