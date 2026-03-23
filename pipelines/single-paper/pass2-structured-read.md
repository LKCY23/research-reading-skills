# Pass 2: Structured read

## Purpose

Pass 2 performs the main extraction pass for a paper.
It should convert the source into structured artifacts that capture the method, experiments, key claims, and limitations.

## Inputs

Pass 2 should primarily consume:
- method or approach sections
- experiment or results sections
- figure captions
- table captions
- selected evidence-oriented chunks
- relevant metadata from Pass 0
- orientation signals from Pass 1

## Outputs

Primary outputs:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card`

These should align with:
- `schemas/method-card.schema.json`
- `schemas/experiment-card.schema.json`
- `schemas/claim-evidence.schema.json`
- `schemas/limitations-card.schema.json`

## Responsibilities

### Method extraction
Produce a stable account of:
- task definition
- input/output form
- core components
- optimization or training setup
- assumptions
- novel elements

### Experiment extraction
Capture:
- datasets or benchmarks
- evaluation metrics
- baselines
- main results
- ablations
- sensitivity studies
- concise interpretation

### Claim-evidence linking
For major claims, build reviewable rows that include:
- claim text
- claim type
- whether the claim is author-stated
- evidence type
- evidence location
- evidence summary
- support strength
- support strength rationale
- reviewer note

### Limitation extraction
Separate:
- author-stated limitations
- inferred limitations
- threats to validity

## Quality bar

A good Pass 2 output should:
- be specific
- be evidence-oriented
- avoid broad unstructured summary prose
- make it possible for a reviewer to disagree with individual claims rather than the entire summary at once

## Non-goals

Pass 2 should not:
- make a final judgment about the whole paper’s merit
- claim reproduction success
- overreach beyond the evidence that is actually visible in the source

## Handoff to Pass 3

Pass 2 should leave Pass 3 with enough structure to critique the paper without rereading everything blindly.
Pass 3 should be able to start from:
- the extracted claim-evidence table
- the method card
- the experiment card
- the limitations card
- selected source chunks tied to important claims
