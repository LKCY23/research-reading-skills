# Pass 1: Quick pass

## Purpose

Pass 1 performs the first-pass read of a paper.
Its goal is orientation, not deep critique.

This pass should answer:
- What kind of paper is this?
- What problem does it address?
- What are the claimed contributions?
- Is it worth deeper reading?

## Inputs

Pass 1 should primarily consume:
- metadata from Pass 0
- title
- abstract
- introduction
- conclusion
- section index

If more source text is available, it should not dominate this pass unless needed to answer the orientation questions.

## Outputs

Primary output:
- `quick_pass`

The output should align with `schemas/quick-pass.schema.json`.

## Responsibilities

### Identify the paper type
Use a stable classification such as:
- empirical
- theoretical
- systems
- survey
- benchmark
- other

### Extract the problem statement
Summarize the actual problem the paper is trying to solve.

### Extract claimed contributions
List the contributions as concrete points rather than vague summary prose.

### Identify visible comparators
Capture baselines or comparison targets if they are already visible in the orientation-level sections.

### Flag uncertainty early
If the source is weak, incomplete, or rhetorically exaggerated, note that here instead of waiting for later passes.

### Decide whether deeper reading is justified
The result should help a user quickly decide whether the paper deserves more attention.

## Non-goals

Pass 1 should not:
- fully evaluate support strength for every claim
- reconstruct the complete method
- write reproduction notes
- produce a literature-review style synthesis

## Handoff to Pass 2

Pass 1 should make Pass 2 easier by identifying:
- the likely core method sections
- the likely experimental sections
- where the most important claims seem to appear
- what confidence or uncertainty signals deserve deeper checking
