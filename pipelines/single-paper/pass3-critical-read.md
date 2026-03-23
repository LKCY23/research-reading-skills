# Pass 3: Critical read

## Purpose

Pass 3 is the critical and reproducibility-oriented reading pass.
It should transform the outputs of Pass 2 into a critique-ready reading package.

## Inputs

Pass 3 should primarily consume:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card`
- discussion/conclusion sections
- selected evidence-relevant source chunks
- optional project or topic context from the user

## Outputs

Primary outputs:
- `repro_notes`
- `critical_read_notes`
- `project_relevance`
- `uncertainty_summary`

These should align with:
- `schemas/repro-notes.schema.json`
- `schemas/critical-read-notes.schema.json`
- `schemas/project-relevance.schema.json`

## Responsibilities

### Reproduction-oriented analysis
Identify:
- required assets
- missing details
- high-risk ambiguities
- first replication checks
- expected failure points

### Critical reading
Assess:
- support gaps
- fairness of comparisons
- likely confounds
- risky assumptions
- what evidence would change confidence
- an overall critical take

### Project relevance
Explain:
- why this paper matters for the current topic or project
- what ideas are reusable
- what parts can be ignored
- what to read next

### Uncertainty handling
Summarize where the analysis is limited by:
- missing source coverage
- ambiguous evidence
- narrow benchmarks
- incomplete implementation detail

## Quality bar

A good Pass 3 output should:
- avoid performative skepticism
- avoid pretending to have reproduced the system
- remain grounded in the extracted evidence
- distinguish clearly between author claims, reviewer interpretation, and unresolved uncertainty

## Non-goals

Pass 3 should not:
- rewrite the entire paper in prose
- inflate weak evidence into strong verdicts
- claim fraud, invalidity, or correctness beyond what the source justifies

## Final assembly role

Pass 3 completes the Layer 1 package.
After Pass 3, the repository should be able to assemble:
- `paper-card.json`
- `paper-card.md`

At that point, the example is ready for:
- human review
- later golden testing
- Layer 2 reuse
