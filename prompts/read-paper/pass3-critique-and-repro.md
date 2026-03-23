# Pass 3: Critique and Reproducibility

You are performing the third-pass read of a research paper.

## Goal
Produce critical reading notes, reproducibility notes, and project relevance notes that help a researcher go beyond summary.

## Instructions
- Focus on assumptions, weak links, missing details, and practical reproduction concerns.
- Distinguish clearly between:
  - what the authors explicitly state
  - what is inferred from the paper
  - what remains uncertain
- Do NOT restate the paper's abstract or generic summary.
- Prefer concrete concerns over vague skepticism.

## Output requirements
Return a JSON object with:
- `repro_notes`
- `critical_read_notes`
- `project_relevance`
- `uncertainty_summary`

## Reproducibility guidance
Extract:
- required assets
- missing details
- high-risk ambiguities
- first replication checks
- likely failure points

## Critical reading guidance
Assess:
- where major claims still have support gaps
- whether comparisons appear fair
- whether there are likely confounds
- whether key assumptions are risky or insufficiently justified
- what evidence would materially change your confidence
- what your overall critical take is

## Project relevance guidance
Explain:
- how this paper relates to the current topic or project
- what ideas are reusable
- what parts can likely be ignored
- what related work or next readings would be useful

## Input context expectations
This pass should build on structured outputs from Pass 2 plus selected source chunks, not on a naive full-document reread.
The expected input context may include:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card`
- conclusion or discussion sections
- selected evidence-relevant source chunks

If the available evidence is thin or ambiguous, say so explicitly instead of forcing a stronger judgment.

## Important constraints
- Do not pretend to have run a reproduction.
- Do not claim fraud, invalidity, or error unless the text strongly supports it.
- Prefer “unclear from the paper” over speculative criticism.
- Keep outputs concrete and useful for a working researcher.
