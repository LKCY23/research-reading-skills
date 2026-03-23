# Golden validation notes

This directory is reserved for golden-example validation.

## Current quasi-golden baseline

`examples/single-paper/example-001/` is the current Layer 1 quasi-golden baseline.

This means future checks should first ask:
- Are the expected files present?
- Are the JSON artifacts syntactically valid?
- Does `paper-card.json` stay consistent with the sub-artifacts?
- Does `paper-card.md` still reflect the structured artifacts faithfully?

## Highest-priority artifact checks

Start with:
- `claim-evidence-table.json`
- `limitations-card.json`
- `repro-notes.json`
- `critical-read-notes.json`

These are the most valuable early outputs to stabilize.

## Expansion path

Later, this directory can hold:
- explicit golden checklists
- diff expectations
- artifact completeness matrices
- multi-example baselines
