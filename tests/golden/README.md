# Golden validation notes

This directory is reserved for golden-example validation.

## Current quasi-golden baselines

`examples/single-paper/example-001/` is the current Layer 1 quasi-golden baseline.

Canonical reusable Layer 1 paper records now live under `library/single-paper/` and should not be confused with the example baseline.

`examples/literature-review/example-001/` is the current Layer 2 quasi-golden baseline.

This means future checks should first ask:
- Are the expected files present?
- Are the JSON artifacts syntactically valid?
- Do aggregate artifacts stay consistent with their sub-artifacts?
- Do rendered markdown files still reflect the structured artifacts faithfully?

## Highest-priority artifact checks

Start with:
- Layer 1 `claim-evidence-table.json`
- Layer 1 `limitations-card.json`
- Layer 1 `repro-notes.json`
- Layer 1 `critical-read-notes.json`
- Layer 2 `topic-scope.json`
- Layer 2 `paper-set.json`
- Layer 2 `comparison-matrix.json`
- Layer 2 `literature-review.json`

These are the most valuable early outputs to stabilize.

## Executable checks

Current executable checks:
- `tests/bin/check-example-001-completeness.sh`
- `tests/bin/check-literature-review-example-001-completeness.sh`
- `tests/bin/check-single-paper-library-completeness.sh`

Run:
```bash
bash tests/bin/check-example-001-completeness.sh
bash tests/bin/check-literature-review-example-001-completeness.sh
bash tests/bin/check-single-paper-library-completeness.sh
```

These verify that the required quasi-golden example files exist.

## Expansion path

Later, this directory can hold:
- explicit golden checklists
- diff expectations
- artifact completeness matrices
- multi-example baselines
