# Single-paper pipeline overview

This directory defines the conceptual execution model for Layer 1 single-paper reading.

The goal of this pipeline is to turn one paper input into a structured, reviewable reading package that can later be consumed by:
- the `read-paper` skill
- rendering templates such as `templates/paper-card.md`
- Layer 2 literature-review workflows
- future tests and golden examples

## Pipeline stages

### Pass 0: Ingestion
Purpose:
- classify the source type
- capture the minimum stable metadata
- preserve section/chunk/figure/table structure when available
- establish the locator strategy used by later passes

Primary output:
- a normalized source representation suitable for later pass-specific extraction

### Pass 1: Quick pass
Purpose:
- determine what kind of paper this is
- identify the problem and claimed contributions
- decide whether the paper is worth deeper reading

Primary output:
- `quick_pass`

### Pass 2: Structured read
Purpose:
- extract the method structure
- extract experiments and results
- build the claim-evidence table
- capture limitations

Primary outputs:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card`

### Pass 3: Critical read
Purpose:
- identify reproduction risks, support gaps, confounds, and relevance
- turn the extracted structure into a critique-ready reading package

Primary outputs:
- `repro_notes`
- `critical_read_notes`
- `project_relevance`
- `uncertainty_summary`

## Interfaces between passes

- Pass 0 prepares source structure and locator conventions.
- Pass 1 uses orientation-friendly material such as title, abstract, introduction, conclusion, and section index.
- Pass 2 uses method/results/figure/table-centered context plus selected chunks.
- Pass 3 uses Pass 2 outputs plus selected evidence-relevant source chunks and optional project context.

## Output assembly

After the pass outputs are produced, they should be assembled into:
- `paper-card.json`
- `paper-card.md`

The JSON artifact is the durable structured record.
The markdown artifact is the human-readable rendering.

## Canonical persistence and reuse

For reusable execution state, the repository should persist canonical Layer 1 records under:
- `library/single-paper/<paper-slug>/`

That library layer is the repository-side persistence surface for future duplicate detection and reuse.

Before starting a new read, a future executor should:
- normalize the incoming paper identity
- search `library/single-paper/` for existing records
- classify matches as `exact`, `probable`, or `none`
- decide whether to reuse artifacts, rerun selected passes, or reread from scratch

The detailed matching and reuse contract is defined in:
- `pipelines/single-paper/library-identity-and-reuse.md`

`examples/single-paper/` remains useful for curated examples and review anchors, but it should not be treated as the canonical persistence layer for future `/read-paper` executions.

## Current scope

This pipeline directory is intentionally documentation-first in v1.
It defines:
- responsibilities
- inputs and outputs
- boundaries
- future implementation hooks

It does **not** claim that ingestion or orchestration is fully automated yet.
