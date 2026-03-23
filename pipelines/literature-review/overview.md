# Literature-review pipeline overview

This directory defines the conceptual execution model for Layer 2 topic-first literature review.

The goal of this pipeline is to turn topic-scoped multi-paper input into a structured, reviewable literature-review package that can later be consumed by:
- the `literature-review` skill
- rendering templates such as `templates/literature-review.md`
- future examples, review checklists, and tests

## Pipeline stages

### Topic scoping
Purpose:
- define the review boundary before cross-paper synthesis starts
- clarify the research question and what counts as in scope
- establish initial comparison axes and visible scope risks

Primary output:
- `topic_scope`

### Aggregation
Purpose:
- define the current paper set for the topic
- record per-paper coverage state and available Layer 1 artifacts
- make missing Layer 1 coverage explicit before comparison

Primary output:
- `paper_set`

### Comparison
Purpose:
- compare papers using explicit axes
- keep missing evidence and uneven coverage visible
- produce a durable comparison surface for later synthesis

Primary output:
- `comparison_matrix`

### Synthesis
Purpose:
- derive a reviewable cross-paper synthesis from the scoped topic, paper set, and comparison matrix
- organize taxonomy, evidence patterns, gaps, disagreements, and reading order
- keep review limits and next actions explicit

Primary output:
- `literature_review`

## Interfaces between stages

- Topic scoping starts from `topic`, `research_question`, and `seed_papers`.
- Aggregation turns the scoped topic into `paper_set`, including explicit `seed_only`, `partial_layer1`, and `full_layer1` coverage states.
- Comparison uses `topic_scope` and `paper_set` to build `comparison_matrix` without hiding missing evidence.
- Synthesis uses `topic_scope`, `paper_set`, and `comparison_matrix` to assemble the aggregate `literature_review`.

## Output assembly

After the staged outputs are produced, they should be assembled into:
- `literature-review.json`
- `literature-review.md`

The JSON artifact is the durable structured record.
The markdown artifact is the human-readable rendering.

## End-to-end flow

```text
topic + research_question + seed_papers
  -> topic_scope
  -> paper_set
  -> comparison_matrix
  -> literature_review
  -> literature-review.md
```

## Layer 1 boundary in v1

Layer 2 consumes Layer 1 artifacts when they are available.
It may flag papers that need deeper Layer 1 reads, but it does **not** perform those reads in v1.

That means this pipeline can:
- use existing Layer 1 artifacts for grounded comparison
- mark missing or partial Layer 1 coverage explicitly
- recommend which papers should receive deeper Layer 1 treatment next

It does **not** claim that missing single-paper reads are automatically backfilled during Layer 2 execution.

## Current scope

This pipeline directory is intentionally documentation-first in v1.
It defines:
- responsibilities
- inputs and outputs
- boundaries
- future implementation hooks

It does **not** claim that multi-paper retrieval, ingestion, or orchestration is fully automated yet.
