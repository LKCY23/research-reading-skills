# Validation and test layer overview

This directory tree defines the minimal validation surface for the repository.

The immediate goal is not to build a full automated test suite yet. The goal is to make validation expectations explicit and to give future implementation work stable places to add checks.

## Current scope

This first validation layer covers:
- schema validation expectations
- prompt contract checks
- golden-example review expectations
- directory structure for future executable tests
- minimal executable checks for JSON validity and example completeness

It does **not** yet include full schema-conformance validation or a complete automated runner.

## Current quasi-golden baseline

`examples/single-paper/example-001/` is the current Layer 1 quasi-golden baseline.

For now, it is the main reference example for checking:
- schema shape consistency
- field naming consistency
- artifact completeness
- claim/evidence review quality
- markdown rendering quality

Future examples can be added later, but `example-001` is the current anchor.

## Validation layers

### `tests/schema/`
Purpose:
- validate JSON syntax
- later validate schema adherence for example artifacts

### `tests/prompt/`
Purpose:
- check that prompts still align with schema field names and pipeline responsibilities
- later track regressions in prompt contract quality

### `tests/golden/`
Purpose:
- define what counts as a stable expected output shape for important examples
- start with `example-001` as the baseline Layer 1 reference

### `tests/bin/`
Purpose:
- hold minimal executable validation scripts
- keep first-pass repository checks easy to run manually

## Current executable checks

Run:
```bash
bash tests/bin/validate-json.sh
bash tests/bin/check-example-001-completeness.sh
```

## Review priority

The highest-value early checks remain:
- `claim-evidence-table.json`
- `limitations-card.json`
- `repro-notes.json`
- `critical-read-notes.json`

These files are the best early indicators that the repository is producing structured, grounded reading outputs rather than fluent but weak summaries.
