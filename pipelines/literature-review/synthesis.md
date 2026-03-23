# Synthesis

## Purpose

Synthesis is the Layer 2 stage that turns scoped topic and structured comparison into a reviewable aggregate `literature_review`.

## Taxonomy derivation

Synthesis should derive taxonomy from visible patterns in the scoped topic and `comparison_matrix`.
It should group papers for a stated reason rather than inventing categories with no traceable basis.

A useful taxonomy should:
- name the grouping clearly
- explain the grouping rationale
- identify which paper IDs belong in each group

## Evidence pattern derivation

Synthesis should derive evidence patterns from the comparison structure that is actually available.
It should summarize cross-paper regularities without hiding uneven coverage.

Each pattern should make clear:
- what the pattern is
- which papers support it
- what coverage note limits confidence in the pattern

## Gap and disagreement recording

Synthesis should record both missing evidence and substantive disagreement.
The goal is to make unresolved questions inspectable, not to force a clean consensus.

This stage should note:
- where the paper set lacks enough evidence for a confident conclusion
- where papers disagree in ways that matter to the review question
- why each gap or disagreement matters

## Reading order proposal

Synthesis should propose a reading order that helps the user decide what to read or deepen next.
That order should reflect both topic structure and coverage state.

A good reading-order proposal can prioritize:
- foundational or framing papers
- `full_layer1` papers that anchor comparison
- `partial_layer1` papers where additional Layer 1 work would unlock better comparison
- `seed_only` papers that need deeper Layer 1 reads to resolve important uncertainty

## Review limits and next actions

Review limits must remain explicit.
The final output should state where the review depends on `seed_only` papers, `partial_layer1` coverage, `full_layer1` anchors, or missing artifacts.

Next actions should remain explicit as well.
They may include:
- deeper Layer 1 reads for selected `seed_only` papers
- completing missing Layer 1 work for `partial_layer1` papers
- comparison-axis refinement
- additional paper collection

## Aggregate output

Primary output:
- `literature_review`

The aggregate review should preserve:
- `topic_scope`
- `paper_set`
- `comparison_matrix`
- `taxonomy`
- `evidence_patterns`
- `gaps_and_disagreements`
- `recommended_reading_order`
- `review_limits`
- `next_actions`

The goal is a structured review artifact first, with markdown rendering layered on top.
