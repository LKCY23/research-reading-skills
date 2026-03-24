# Comparison Matrix

## Goal
Produce a reviewable Layer 2 `comparison_matrix` artifact that records cross-paper comparisons without hiding missing evidence or uneven coverage.

## Instructions
- Work from the declared comparison scope, current `paper_set`, available Layer 1 artifacts, and any already-chosen comparison axes.
- Compare papers only along axes that are explicitly in scope.
- Keep the output structured and inspectable.
- Do NOT write freeform synthesis prose.
- Prefer explicit per-paper, per-axis entries over compressed narrative comparison.
- If a comparison cannot be grounded from available inputs, record that limit directly instead of inferring.

## Output requirements
Return JSON matching `schemas/comparison-matrix.schema.json`.

The output must contain exactly these fields:
- `comparison_axes`
- `paper_ids`
- `cells`
- `coverage_warnings`
- `comparison_limits`

Each cell must match the schema shape:
- `paper_id`
- `axis`
- `summary`
- `coverage_note`

## Coverage-tier rules
Treat paper coverage as an explicit constraint for every comparison.
Use the exact coverage tiers from `paper_set`:
- `seed_only`
- `partial_layer1`
- `full_layer1`

Apply them as follows:
- `seed_only`: only record coarse inclusion-level or metadata-level comparison notes; do not present method, result, or claim comparison as verified.
- `partial_layer1`: compare only the aspects directly supported by the available Layer 1 artifacts; make the missing parts explicit.
- `full_layer1`: use the available Layer 1 package as the preferred basis for grounded comparison.

Missing Layer 1 coverage is not evidence.
Do not treat absent artifacts as if they support a negative or neutral comparison conclusion.

## Comparison guidance
- Use `comparison_axes` as the declared cross-paper comparison surface.
- Use `paper_ids` to enumerate the papers represented in the matrix.
- For each represented paper and axis, keep `summary` concise and grounded in available evidence.
- Use `coverage_note` to state whether the comparison is based on `seed_only`, `partial_layer1`, or `full_layer1` coverage.
- If an axis is only weakly covered across the paper set, capture that in `coverage_warnings` or `comparison_limits`.
- Keep author-stated facts separate from cross-paper interpretation where possible.

## Missing-evidence rules
- If a paper lacks the coverage needed for an axis, say so explicitly in `coverage_note`.
- If a cross-paper conclusion would require unavailable Layer 1 reads, record the limitation in `comparison_limits`.
- Do not fill missing cells with invented summaries.
- Do not treat `seed_only` or incomplete `partial_layer1` coverage as evidence-backed comparison.
- Uneven coverage across papers should remain visible in `coverage_warnings`.

## Input context expectations
This prompt should work from structured Layer 2 and Layer 1 artifacts rather than an unbounded multi-paper text dump.
The expected input context may include:
- `topic_scope`
- `paper_set`
- available Layer 1 outputs for individual papers
- candidate or approved comparison axes
- coverage-state notes

The input may include a mix of `seed_only`, `partial_layer1`, and `full_layer1` papers.

## Important constraints
- Do not rewrite the `paper_set`; use its terminology and coverage states as given.
- Do not collapse missing Layer 1 coverage into confident comparison summaries.
- Do not claim comprehensive topic comparison if the represented paper set is incomplete.
- Keep the matrix grounded enough that later `synthesis` can reuse it without guessing.
