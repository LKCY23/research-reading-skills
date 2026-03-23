# Layer 2 Topic-First Literature Review Scaffold Design

## Goal

Add the first Layer 2 scaffold for `paper-read-skills` as a topic-first literature-review workflow built on top of Layer 1 `paper_card` outputs.

The purpose of this step is not to automate literature review end-to-end. It is to establish the stable contracts, file structure, and workflow boundaries that future implementation can rely on.

## Why this exists

Layer 1 already defines the repository’s atomic reading unit: a structured, reviewable `paper_card` plus related artifacts. Layer 2 should not bypass that work by jumping straight from topic input to prose synthesis.

Instead, Layer 2 should treat single-paper outputs as the durable base unit and define how a topic review is scoped, how a paper set is represented, how papers are compared, and how synthesis is assembled.

This keeps the repository aligned with its core philosophy:
- grounded over fluent
- structured over ad-hoc
- layered over monolithic
- reviewable over magical

## Scope for v1 scaffold

### In scope
- a `literature-review` skill scaffold
- a topic-first pipeline scaffold under `pipelines/literature-review/`
- prompt scaffolds for topic scoping, comparison, and synthesis
- schema scaffolds for Layer 2 artifacts
- a markdown template scaffold for readable review output
- example and review placeholders sufficient to anchor future work
- documentation updates so the repository reflects the Layer 2 structure actually present on disk

### Out of scope
- automated retrieval from academic search systems
- citation graph crawling
- duplicate detection across external databases
- ranking or recommender logic
- automatic paper ingestion beyond what Layer 1 already assumes
- executable multi-paper orchestration
- a polished systematic-review engine

## Confirmed input model

The first Layer 2 contract should assume the user provides:
- `topic`
- `research_question`
- `seed_papers`
- optional `project_context`
- optional existing Layer 1 `paper_card` artifacts when available

This keeps the workflow topic-first while still allowing seed papers to anchor the initial paper set.

## Recommended approach

Use a topic-first orchestrator model.

The main flow should be:
1. `topic_scope`
2. `paper_set`
3. `comparison_matrix`
4. `synthesis`

This is preferable to an artifact-first or skill-first starting point because it preserves workflow clarity while still leaving room for schema-driven validation and future skill behavior.

## Architecture

Layer 2 should be organized as a thin orchestration layer over Layer 1 artifacts.

Conceptually:

```text
topic + research_question + seed_papers
  -> topic scoping
  -> paper set definition
  -> per-paper Layer 1 artifacts (existing or future)
  -> comparison matrix
  -> synthesis artifacts
  -> literature-review markdown rendering
```

The key rule is:

**Layer 2 consumes Layer 1 paper-level structure rather than replacing it.**

That means the Layer 2 scaffold should talk in terms of:
- paper inclusion and coverage
- comparison axes
- cross-paper evidence patterns
- disagreements and gaps
- recommended reading order

rather than pretending that the first version can autonomously discover, parse, and judge the whole literature landscape.

## Main units and responsibilities

### 1. `skills/literature-review/SKILL.md`
Responsibility:
- define when the skill should be used
- define expected inputs
- define Layer 2 boundaries
- define the staged workflow
- explain how Layer 1 outputs fit into the process
- define what to say when coverage is partial or inputs are weak

This file should mirror the style of `skills/read-paper/SKILL.md`: explicit scope, explicit non-goals, explicit output contract, and explicit reviewability rules.

### 2. `pipelines/literature-review/overview.md`
Responsibility:
- define the end-to-end conceptual execution model for Layer 2
- explain how topic scoping, aggregation, comparison, and synthesis relate
- explain the interfaces between stages

This file is the Layer 2 counterpart to `pipelines/single-paper/overview.md`.

### 3. `pipelines/literature-review/topic-scoping.md`
Responsibility:
- define how a topic is bounded
- define research question handling
- define inclusion and exclusion criteria
- define initial comparison axes
- define uncertainty and coverage notes early

Primary output:
- `topic_scope`

### 4. `pipelines/literature-review/aggregation.md`
Responsibility:
- define how the paper set is represented
- define the relationship between seed papers and Layer 1 artifacts
- define coverage state per paper
- distinguish papers with structured reads from papers that are only known at the metadata/seed level

Primary output:
- `paper_set`

### 5. `pipelines/literature-review/comparison.md`
Responsibility:
- define how comparison axes are chosen and recorded
- define matrix row/column expectations
- define how missing evidence or uneven coverage is represented

Primary output:
- `comparison_matrix`

### 6. `pipelines/literature-review/synthesis.md`
Responsibility:
- define how to turn the comparison structure into higher-level synthesis
- organize taxonomy, evidence patterns, gaps, disagreements, and reading order
- preserve separation between grounded observations and inferred synthesis

Primary outputs:
- `taxonomy`
- `evidence_patterns`
- `gaps_and_disagreements`
- `recommended_reading_order`
- aggregate `literature_review`

## Layer 2 artifact model

The Layer 2 scaffold should formalize the following artifact set.

### `topic_scope`
Purpose:
- capture the user’s topic and research question in a reviewable form
- define scope boundaries before synthesis starts

Suggested fields:
- `topic`
- `research_question`
- `scope_summary`
- `inclusion_criteria`
- `exclusion_criteria`
- `initial_comparison_axes`
- `known_scope_risks`
- `seed_paper_rationale`

### `paper_set`
Purpose:
- represent the set of papers currently under review
- show per-paper coverage and processing status

Suggested fields:
- `papers`
- `coverage_summary`
- `missing_layer1_artifacts`
- `papers_needing_deeper_read`

Each paper row should distinguish:
- citation/identifier metadata
- why it is included
- whether a Layer 1 `paper_card` exists
- whether comparison coverage is partial or complete

### `comparison_matrix`
Purpose:
- provide the durable cross-paper comparison surface
- make synthesis inspectable rather than purely narrative

Suggested structure:
- explicit `comparison_axes`
- per-paper rows or axis-oriented cells
- evidence/coverage notes for missing or uncertain cells

Important design rule:
comparison should remain grounded in available paper-level artifacts and should not silently fill unknowns.

### `literature_review`
Purpose:
- serve as the aggregate Layer 2 structured artifact
- act as the source of truth for rendering and later testing

Suggested top-level sections:
- `metadata`
- `topic_scope`
- `paper_set`
- `comparison_matrix`
- `taxonomy`
- `evidence_patterns`
- `gaps_and_disagreements`
- `recommended_reading_order`
- `review_limits`
- `next_actions`

## Data flow

The intended data flow is:

1. User provides `topic`, `research_question`, and `seed_papers`
2. Topic-scoping pass defines boundaries and comparison intentions
3. Aggregation pass defines the current paper set and coverage state
4. Comparison pass records similarities, differences, and missing cells in structured form
5. Synthesis pass derives higher-order patterns from the matrix and coverage notes
6. Template renders a readable literature review markdown artifact

This structure preserves a clear contract at each boundary and avoids collapsing everything into one long prose summary.

## Handling partial coverage

Partial coverage is expected in v1 and should be explicit.

The Layer 2 scaffold should assume that some papers may have:
- full Layer 1 artifacts
- partial Layer 1 artifacts
- only metadata and a reason for inclusion

The design should therefore require explicit coverage notes rather than pretending every paper has been deeply read.

This is one of the most important reviewability rules in Layer 2.

## Prompt design rules

The prompt scaffolds under `prompts/literature-review/` should follow the same principles as Layer 1:
- narrow role per prompt
- structured outputs first
- no generic survey-style prose as the source of truth
- explicit uncertainty handling
- no invention of missing cross-paper evidence

### `topic-scope.md`
Should guide the model to:
- define scope
- clarify the research question
- identify candidate comparison axes
- note obvious scope risks

### `comparison-matrix.md`
Should guide the model to:
- compare papers using declared axes
- keep missing cells explicit
- prefer Layer 1 artifacts where available
- avoid over-claiming cross-paper conclusions

### `synthesis.md`
Should guide the model to:
- derive taxonomy and patterns from the matrix
- identify disagreements and evidence gaps
- propose a reading order
- keep review limits visible

## Template design

A new `templates/literature-review.md` should render the Layer 2 artifact in a human-oriented order.

Recommended sections:
- Topic at a glance
- Research question
- Scope and boundaries
- Included papers and coverage state
- Comparison matrix overview
- Taxonomy
- Common evidence patterns
- Gaps and disagreements
- Recommended reading order
- Review limits
- Next actions

This mirrors the role of `templates/paper-card.md` in Layer 1: human readability on top of structured truth.

## Example and review scaffolding

The first Layer 2 step should stay scaffold-first.

That means examples and review files should establish expected shape without pretending that a realistic multi-paper example is already complete.

Recommended additions:
- `examples/literature-review/README.md`
- an initial placeholder example directory such as `examples/literature-review/example-001/`
- `docs/review/literature-review-checklist.md`

The review checklist should focus on:
- scope clarity
- comparison-axis usefulness
- explicit missing coverage
- grounded synthesis versus freeform survey language

## Validation posture

The repository’s current tests are intentionally minimal. Layer 2 should follow the same philosophy for now.

Early validation should focus on:
- JSON validity of new Layer 2 schemas
- completeness expectations for a Layer 2 example scaffold
- contract consistency between prompts, schemas, pipelines, and templates

Do not overbuild a runner here. The point is to make the Layer 2 validation surface explicit.

## File structure to add

### Create
- `skills/literature-review/SKILL.md`
- `pipelines/literature-review/overview.md`
- `pipelines/literature-review/topic-scoping.md`
- `pipelines/literature-review/aggregation.md`
- `pipelines/literature-review/comparison.md`
- `pipelines/literature-review/synthesis.md`
- `prompts/literature-review/topic-scope.md`
- `prompts/literature-review/comparison-matrix.md`
- `prompts/literature-review/synthesis.md`
- `schemas/topic-scope.schema.json`
- `schemas/paper-set.schema.json`
- `schemas/comparison-matrix.schema.json`
- `schemas/literature-review.schema.json`
- `templates/literature-review.md`
- `examples/literature-review/README.md`
- `examples/literature-review/example-001/README.md`
- `docs/review/literature-review-checklist.md`
- minimal Layer 2 validation notes or scripts only if needed for consistency with the current tests layout

### Modify
- `README.md`
- `docs/development-plan.md`
- possibly `tests/README.md` and `tests/golden/README.md` if Layer 2 validation surface is documented now rather than later

## Recommended implementation order

1. Add Layer 2 schemas first so the artifact contract is concrete
2. Add Layer 2 prompts aligned to those schemas
3. Add pipeline docs defining the staged flow
4. Add the `literature-review` skill scaffold
5. Add template and example placeholders
6. Sync top-level docs and validation notes

This order keeps the structure coherent and reduces drift between the contracts and the user-facing workflow.

## Risks and mitigations

### Risk: Layer 2 becomes vague survey prose
Mitigation:
keep `comparison_matrix` and `paper_set` as explicit intermediate artifacts.

### Risk: Layer 2 silently bypasses Layer 1
Mitigation:
state clearly in skill, pipeline, and schema docs that `paper_card` is the preferred base unit.

### Risk: missing-paper coverage is hidden
Mitigation:
require explicit coverage notes in `paper_set`, `comparison_matrix`, and `review_limits`.

### Risk: too much automation is implied
Mitigation:
repeatedly document that this version is scaffold-first and not a full retrieval/review engine.

## Success criteria for this design step

This design is successful if the repository gains a Layer 2 scaffold that:
- is clearly topic-first
- takes `topic + research_question + seed_papers` as the primary contract
- builds on Layer 1 paper artifacts
- defines a stable Layer 2 artifact set
- makes missing coverage explicit
- remains documentation-first and reviewable
- avoids pretending the system is already a full literature-review engine
