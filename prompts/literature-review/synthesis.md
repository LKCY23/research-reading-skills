# Synthesis

## Goal
Produce the synthesis portions of the aggregate Layer 2 `literature_review` object from the current topic scope, paper set, and comparison matrix.

## Instructions
- Work from structured Layer 2 artifacts first: `topic_scope`, `paper_set`, and `comparison_matrix`.
- Generate only the synthesis portions that belong inside the aggregate `literature_review` object.
- Keep the output scaffold-focused, reviewable, and structured-output-first.
- Do NOT write a generic survey essay.
- Derive higher-order organization from the available comparison evidence while keeping missing coverage visible.
- If the evidence is too thin for a strong synthesis claim, record a narrower pattern or a review limit instead.

## Output requirements
Return a JSON object whose fields fit the nested synthesis portions of the aggregate `literature_review` object defined by `schemas/literature-review.schema.json`.

The output must include:
- `taxonomy`
- `evidence_patterns`
- `gaps_and_disagreements`
- `recommended_reading_order`
- `review_limits`
- `next_actions`

Required nested shapes:
- `taxonomy`: array of objects with `name`, `grouping_rationale`, and `paper_ids`
- `evidence_patterns`: array of objects with `pattern`, `paper_ids`, and `coverage_note`
- `gaps_and_disagreements`: array of objects with `issue`, `paper_ids`, and `why_it_matters`
- `recommended_reading_order`: array of objects with `paper_id`, `order_rationale`, and `coverage_state`
- `review_limits`: array of strings
- `next_actions`: array of strings

This prompt defines JSON content for the `literature_review` object. It does not define persisted artifact naming such as `literature-review.json` or `literature-review.md`.

## Coverage-tier rules
Treat coverage tier as a first-class synthesis constraint.
Use the exact coverage-state terms from `paper_set`:
- `seed_only`
- `partial_layer1`
- `full_layer1`

Handle each tier as follows:
- `seed_only`: limit synthesis to coarse inclusion-level, metadata-level, or scoping-level observations.
- `partial_layer1`: synthesize only the aspects directly supported by the available Layer 1 artifacts, and keep missing evidence explicit.
- `full_layer1`: treat the available Layer 1 package as the preferred basis for grounded synthesis.

Missing Layer 1 coverage is not evidence.

## Taxonomy guidance
Use `taxonomy` to group papers into reviewable categories that help organize the topic.
Good groupings may reflect:
- method family
- task framing
- evidence maturity
- evaluation setting
- problem decomposition

Each taxonomy group should be justified by available structured evidence.
Do not create elaborate category systems that exceed the current paper coverage.

## Evidence-pattern guidance
Use `evidence_patterns` for recurring cross-paper observations supported by the current matrix.
Patterns should reflect what is actually visible across papers, such as:
- repeated methodological tradeoffs
- recurring benchmark choices
- common assumptions
- similar evidence strengths or weaknesses

Use `coverage_note` to state whether the pattern is broadly grounded, limited by `partial_layer1` coverage, or constrained by `seed_only` papers.
Do not overstate a pattern when the matrix mainly reflects uneven or shallow coverage.

## Gap/disagreement guidance
Use `gaps_and_disagreements` for:
- open questions across the paper set
- unresolved methodological disagreements
- missing evidence that blocks comparison
- places where the current review surface is too thin to judge an important issue

Prefer concrete issues tied to paper IDs over abstract complaints about the literature.

## Reading-order guidance
Use `recommended_reading_order` to suggest the most useful next reading sequence for a researcher.
The order should help the reader:
- orient quickly
- inspect the strongest-supported papers first when appropriate
- identify where deeper Layer 1 reading is still needed

Set each entry’s `coverage_state` using the exact values already used in `paper_set`.
Do not imply that a `seed_only` paper has been fully read.

## Review-limits guidance
Use `review_limits` to document constraints that materially affect the synthesis.
These should explicitly capture issues such as:
- dependence on `seed_only` papers
- uneven `partial_layer1` coverage
- unavailable Layer 1 artifacts
- incomplete paper-set coverage
- immature or provisional comparison axes

Keep limits explicit rather than burying them inside other sections.

## Input context expectations
This prompt should work from structured Layer 2 artifacts and available Layer 1 outputs, not from a raw multi-paper dump.
The expected input context may include:
- `topic_scope`
- `paper_set`
- `comparison_matrix`
- available Layer 1 artifacts for covered papers
- optional `project_context`

The synthesis should respect the actual paper coverage represented in the inputs.

## Important constraints
- Do not regenerate `topic_scope`, `paper_set`, or `comparison_matrix`.
- Do not treat missing Layer 1 coverage as if it were evidence-backed synthesis.
- Do not hide `review_limits` behind polished narrative language.
- Keep `next_actions` concrete, especially when deeper Layer 1 reads or axis refinement are needed.
- The output should be directly embeddable into the aggregate `literature_review` object without renaming fields.
