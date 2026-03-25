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

## Current quasi-golden baselines

`examples/single-paper/example-001/` is the current Layer 1 quasi-golden baseline.

Canonical reusable Layer 1 paper records now live under `library/single-paper/`.
Those library records are distinct from the example baseline used for validation.

`examples/literature-review/example-001/` is the current Layer 2 quasi-golden baseline.

For now, these are the main reference examples for checking:
- schema shape consistency
- field naming consistency
- artifact completeness
- review quality
- markdown rendering quality

Future examples can be added later, but the current `example-001` directories are the main anchors.

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
- start with `example-001` as the baseline Layer 1 and Layer 2 references

### `tests/bin/`
Purpose:
- hold minimal executable validation scripts
- keep first-pass repository checks easy to run manually

## Current executable checks

Run:
```bash
bash tests/bin/validate-json.sh
bash tests/bin/check-example-001-completeness.sh
bash tests/bin/check-literature-review-example-001-completeness.sh
bash tests/bin/check-single-paper-library-completeness.sh
```

## Review priority

The highest-value early checks remain:
- Layer 1 claim/evidence quality and critique outputs
- Layer 2 scope clarity
- Layer 2 coverage-state honesty
- Layer 2 comparison usefulness
- visible missing evidence in scaffold reviews
