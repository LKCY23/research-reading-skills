# Topic scoping

## Purpose

Topic scoping is the first Layer 2 stage.
It defines what review is being attempted before the workflow starts comparing papers or writing synthesis.

## Inputs

Topic scoping should primarily consume:
- `topic`
- `research_question`
- `seed_papers`
- optional project or topic context from the user

## Output

Primary output:
- `topic_scope`

The output should capture the scoped review boundary and align with the intended Layer 2 artifact contract.

## Responsibilities

### Define the topic boundary
Produce a stable scope summary that makes the intended review area explicit.

### Clarify the research question
Frame the question in a way that later aggregation and comparison can use directly.

### Record inclusion and exclusion criteria
Capture what kinds of papers belong in the current review and what should stay out of scope.

### Propose initial comparison axes
Identify the first comparison dimensions that later stages should use or refine.

### Flag scope risks early
Make ambiguity, narrow seed coverage, or likely blind spots explicit before downstream synthesis starts.

## Non-goals

Topic scoping should not:
- finalize the full paper set
- pretend that all relevant papers have already been deeply read
- write the cross-paper synthesis
- treat seed-paper availability as equivalent to full Layer 1 coverage

## Handoff to aggregation and comparison

Topic scoping should leave later stages with enough structure to:
- build `paper_set` around explicit inclusion logic rather than ad hoc accumulation
- select or refine `comparison_matrix` axes based on the scoped question
- keep visible where topic definition is still uncertain or coverage-limited

## Layer 1 boundary in v1

Topic scoping may identify papers that need deeper Layer 1 reads, but it does **not** perform those reads in v1.
It prepares the scope that later stages use to flag deeper-read candidates explicitly.
