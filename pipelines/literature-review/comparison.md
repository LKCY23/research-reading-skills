# Comparison

## Purpose

Comparison is the Layer 2 stage that turns scoped topic intent and paper coverage into a durable cross-paper comparison surface.

## Comparison-axis selection

Comparison should use explicit axes rather than free-form survey prose.
Axes may come from `topic_scope` and may be refined during comparison when the scoped question requires it.

Good comparison axes are:
- relevant to the `research_question`
- applicable across multiple papers in the current `paper_set`
- concrete enough that missing evidence can be recorded per paper

## Keeping missing evidence visible

Comparison must not silently fill unknown cells.
If a paper lacks the Layer 1 coverage needed for an axis, the comparison output should say so directly.

Missing evidence should remain visible through:
- per-cell `coverage_note`
- `coverage_warnings`
- `comparison_limits`

## Preventing false equivalence across coverage tiers

Comparison must explicitly distinguish `seed_only`, `partial_layer1`, and `full_layer1` papers.

It should not:
- treat seed metadata as if it supports claim-level comparison
- treat partial Layer 1 coverage as equivalent to a fully grounded read
- imply that all papers are comparable at the same evidence depth when they are not

If an axis is only well supported for part of the paper set, the matrix should preserve that asymmetry instead of smoothing it away.

## Output expectations

Primary output:
- `comparison_matrix`

The output should provide:
- explicit `comparison_axes`
- the set of compared `paper_ids`
- `cells` that summarize each paper-axis pairing
- `coverage_warnings` that call out uneven evidence support
- `comparison_limits` that record where the comparison remains constrained by missing coverage or weak evidence

A good `comparison_matrix` should make later synthesis inspectable rather than forcing reviewers to trust a prose summary alone.

## Layer 1 boundary in v1

Comparison may identify papers that need deeper Layer 1 reads, but it does **not** perform those reads in v1.
It keeps missing evidence visible so synthesis can recommend deeper reads without pretending the missing Layer 1 work already happened.
