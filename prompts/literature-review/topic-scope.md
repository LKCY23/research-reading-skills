# Topic Scope

## Goal
Produce a scoped, reviewable Layer 2 `topic_scope` artifact for a topic-first literature review.

## Instructions
- Work only from the provided `topic`, `research_question`, `seed_papers`, and optional `project_context`.
- Define the review scope before comparison or synthesis.
- Keep the output scaffold-focused and structured-output-first.
- Do NOT write a narrative literature review.
- Prefer concise, decision-useful strings over broad prose.
- If the topic boundary is unclear, make the uncertainty explicit in the structured fields instead of guessing.
- Treat `seed_papers` as anchoring context for scoping, not proof of full topic coverage.

## Output requirements
Return JSON matching `schemas/topic-scope.schema.json`.

The output must contain exactly these fields:
- `topic`
- `research_question`
- `scope_summary`
- `inclusion_criteria`
- `exclusion_criteria`
- `initial_comparison_axes`
- `known_scope_risks`
- `seed_paper_rationale`

Do not add extra keys beyond the schema fields.

## Scope-definition guidance
Define a scope that is specific enough to guide paper selection and later comparison.
Capture:
- what kinds of papers belong in scope
- what related but out-of-scope areas should be excluded
- whether the review is bounded by task, method family, domain, evidence type, or timeframe if that boundary is explicit in the input

Keep `scope_summary` short and reviewable.
Do not invent domain boundaries that are not supported by the input context.

## Comparison-axis guidance
Use `initial_comparison_axes` for the first cross-paper questions the review should track.
Choose axes that are likely to support later `comparison_matrix` construction, such as:
- task framing
- method family
- data or benchmark setting
- evaluation criteria
- assumptions or constraints
- evidence maturity

Do not claim that every axis can already be compared across all papers.
Axes are candidate comparison surfaces, not evidence-backed conclusions.

## Coverage and uncertainty rules
- Make uncertainty explicit in `known_scope_risks`.
- Do not treat `seed_papers` as a complete or representative paper set unless the input explicitly says so.
- If `project_context` narrows the review, reflect that narrowing in scope fields instead of writing generic criteria.
- If the topic is broad, say so through concrete scope risks rather than silently narrowing it.
- `seed_paper_rationale` should explain why the provided seed papers matter for defining the scope, not summarize their results as established evidence.

## Input context expectations
This prompt should work from structured topic-level context, not from an unbounded corpus dump.
The expected input context may include:
- `topic`
- `research_question`
- `seed_papers`
- optional `project_context`
- lightweight seed-paper metadata or brief notes

Do not assume full Layer 1 artifacts are available at this stage.
