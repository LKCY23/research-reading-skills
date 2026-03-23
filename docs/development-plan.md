# Development Plan for `paper-read-skills`

## 1. Purpose of this document

This document is the detailed engineering and review plan for the `paper-read-skills` repository.

It is intended to support:
- implementation planning
- prompt and skill design
- schema design
- output review
- test design
- architectural consistency as the project grows

This is not just a vision note. It is meant to function as a practical development reference for future implementation work.

---

## 2. Project objective

Build a repository that packages a scientifically grounded, AI-assisted paper-reading workflow into reusable Claude Code skills backed by reusable internal pipelines.

The system should support two connected layers:

1. **Layer 1: single-paper reading**
2. **Layer 2: topic review / literature review**

The key architectural decision is that **Layer 2 must build on Layer 1 outputs**, not bypass them.

That gives the system:
- a stable atomic unit (`paper_card` and related artifacts)
- more reviewable outputs
- easier debugging
- cleaner future extension into larger reading systems

---

## 3. Primary design goals

### 3.1 Grounded over fluent
Outputs should optimize for evidence and interpretability, not for polished prose alone.

### 3.2 Structured over ad-hoc
Important outputs should be schema-shaped and comparable across runs.

### 3.3 Layered over monolithic
Single-paper reading and literature review should be separate but composable capabilities.

### 3.4 Skill-first, pipeline-backed
The user experience should feel like invoking skills, but the implementation should not be trapped inside single prompts.

### 3.5 Reviewable over magical
Future reviewers should be able to inspect:
- what step produced an output
- what evidence supported it
- what assumptions were inferred
- where uncertainty remains

---

## 4. Non-goals for v1

The first version should explicitly avoid scope creep.

### Not goals for v1
- Full academic search engine behavior
- Publisher-agnostic scraping for every paper source
- Fully automated systematic review pipelines
- Citation graph completeness guarantees
- Automatic factual verification beyond the source paper(s)
- Multi-user collaboration platform features
- UI-heavy visualization systems

### Limited support allowed in v1
- Topic input
- Seed paper input
- Light related-work expansion hooks
- Recommendation of likely comparison axes

---

## 5. Methodological basis

The repository should explicitly encode reading method rather than vaguely mention it.

### 5.1 Three-pass reading
The single-paper layer should implement an AI-assisted version of the three-pass model.

#### Pass 1: Quick orientation
Goal:
- decide what the paper is
- what problem it addresses
- what the main contribution appears to be
- whether it is worth deep reading

Expected input emphasis:
- metadata
- title
- abstract
- introduction
- conclusion
- section index

#### Pass 2: Structured deep read
Goal:
- understand method structure
- identify major figures/tables/results
- understand experimental design
- capture reported limitations

Expected input emphasis:
- method or approach sections
- experiment or results sections
- figure/table captions
- selected evidence-oriented chunks

#### Pass 3: Critical and reproducibility-oriented reading
Goal:
- identify assumptions
- test claim/evidence alignment
- surface weak links
- identify what would matter for reproduction or extension

Expected input emphasis:
- Pass 2 structured outputs
- selected claim/evidence chunks
- discussion and conclusion sections
- limitations-relevant source chunks

### 5.2 Grounded extraction principles
At every stage, prefer artifacts such as:
- claims
- evidence links
- figure/table interpretations
- method assumptions
- limitations
- failure modes
- comparison axes

### 5.3 Literature review principles
For multi-paper synthesis, avoid summary concatenation.
Organize the review around:
- problem framing
- taxonomy
- comparison dimensions
- evidence quality
- disagreements
- open problems

---

## 6. System overview

## 6.1 Top-level architecture

```text
Skills
  -> Pipelines
    -> Prompts / extraction steps
    -> Schemas
    -> Templates
    -> Examples / tests
```

### Responsibilities by layer

#### Skills
- define user-facing invocation pattern
- gather required inputs
- choose which pipeline to run
- enforce output expectations

#### Pipelines
- coordinate staged execution
- keep implementation reusable
- separate orchestration from presentation

#### Prompts
- define role-specific extraction tasks
- remain narrow and testable
- avoid becoming the only form of logic

#### Schemas
- stabilize outputs
- enable testing and comparison
- force consistent structure across examples

#### Templates
- render human-readable notes from structured data
- support review without changing core extraction

#### Examples / tests
- verify stability and output quality
- catch regressions in structure and grounding

---

## 7. Recommended repository structure

```text
paper-read-skills/
  README.md
  docs/
    development-plan.md
    methodology/
      three-pass-reading.md
      grounded-extraction.md
      literature-review-principles.md
    review/
      single-paper-review-checklist.md
      literature-review-checklist.md
  skills/
    read-paper/
      SKILL.md
      examples/
    literature-review/
      SKILL.md
      examples/
  pipelines/
    single-paper/
      overview.md
      pass0-ingestion.md
      pass1-quick-pass.md
      pass2-structured-read.md
      pass3-critical-read.md
    literature-review/
      overview.md
      topic-scoping.md
      aggregation.md
      comparison.md
      synthesis.md
  prompts/
    read-paper/
      pass1-quick-pass.md
      pass2-method-and-results.md
      pass3-critique-and-repro.md
    literature-review/
      topic-scope.md
      comparison-matrix.md
      synthesis.md
  schemas/
    paper-card.schema.json
    quick-pass.schema.json
    claim-evidence.schema.json
    method-card.schema.json
    experiment-card.schema.json
    limitations-card.schema.json
    repro-notes.schema.json
    critical-read-notes.schema.json
    project-relevance.schema.json
    topic-scope.schema.json
    paper-set.schema.json
    comparison-matrix.schema.json
    literature-review.schema.json
  templates/
    paper-card.md
    literature-review.md
    comparison-matrix.md
  examples/
    single-paper/
    literature-review/
  tests/
    schema/
    prompt/
    golden/
```

This structure is intentionally modular so future contributors can change:
- prompt wording
- schemas
- rendering templates
- orchestration logic
without collapsing the whole system into one place.

---

## 8. Layer 1: Single-paper reading design

## 8.1 Purpose
Layer 1 is the atomic reading unit for the entire repository.

It should transform one paper input into a structured reading package that is:
- evidence-aware
- critique-ready
- reusable by higher-level workflows

## 8.2 Supported inputs for v1

### Required
- Local PDF file
- arXiv URL
- Local plain text or markdown extract

### Optional later
- TeX source directory
- HTML paper page with extractable text
- DOI resolution helpers

## 8.3 Layer 1 pipeline stages

### Pass 0: Ingestion and normalization
Purpose:
- classify input source
- extract available text and structure
- retain document metadata and boundaries

Required outputs:
- `source_type`
- `title` if recoverable
- `abstract` if recoverable
- `section_index`
- `figure_table_index` if recoverable
- `reference_index` if recoverable
- `citation_locator_strategy` (page / section / heading / chunk id)

Important rule:
Pass 0 should preserve location metadata wherever possible. Evidence binding later depends on this.

For the current Layer 1 scaffolding step, the repository intentionally does not yet define a standalone `normalized_document` schema or a shared structured locator object. This step only establishes the Layer 1 output schemas and pass prompts. String-based locator fields are therefore the current implementation baseline, with structured locator objects planned for a follow-up iteration.

### Pass 1: Quick pass
Purpose:
- generate a reading orientation card
- determine whether deeper reading is warranted
- capture the paper's visible shape

Suggested output fields:
- `paper_type`
- `problem_statement`
- `claimed_contributions`
- `approach_summary`
- `primary_comparators`
- `credibility_signals`
- `uncertainty_flags`
- `worth_deep_reading`
- `why_read_or_skip`

This stage should answer questions like:
- What kind of paper is this?
- What is it trying to solve?
- What is the main proposed idea?
- What evidence style does it appear to use?
- Does it look central, incremental, exploratory, or weakly supported?

### Pass 2: Structured deep read
Purpose:
- understand the core machinery of the paper
- extract method, data, experiments, and results

Sub-artifacts:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card` (author-stated)

Suggested `method_card` fields:
- `task_definition`
- `input_output_form`
- `core_components`
- `training_or_optimization_setup`
- `key_assumptions`
- `novel_elements`

Suggested `experiment_card` fields:
- `datasets_or_benchmarks`
- `evaluation_metrics`
- `baselines`
- `main_results`
- `ablations`
- `sensitivity_studies`
- `result_interpretation`

Suggested `claim_evidence_table` row fields:
- `claim_id`
- `claim_text`
- `claim_type` (performance / methodological / theoretical / empirical observation / limitation)
- `evidence_type`
- `evidence_location`
- `evidence_summary`
- `support_strength` (strong / moderate / weak / unclear)
- `support_strength_reason`
- `reviewer_note`

### Pass 3: Critical read and reproducibility view
Purpose:
- test whether the paper's logic holds together
- identify what matters for reproduction
- make the output useful to an active researcher

Sub-artifacts:
- `repro_notes`
- `critical_read_notes`
- `project_relevance`

Suggested `repro_notes` fields:
- `required_assets`
- `missing_details`
- `high_risk_ambiguities`
- `first_replication_checks`
- `expected_failure_points`

Suggested `critical_read_notes` fields:
- `major_support_gaps`
- `fairness_of_comparisons`
- `possible_confounds`
- `assumption_risks`
- `missing_evidence_that_would_change_confidence`
- `overall_critical_take`

Suggested `project_relevance` fields:
- `relevance_to_current_topic`
- `reusable_ideas`
- `parts_to_ignore`
- `what_to_read_next`

---

## 9. Layer 1 output contract

The most important stable artifact for Layer 1 should be `paper_card`.

## 9.1 `paper_card` should contain
- constrained metadata (`title`, `source_type`, `parsed_from`, `ingestion_timestamp`, with optional authors/venue/year/source identifiers)
- quick-pass summary
- method summary
- experiment summary
- claim-evidence table
- limitations
- reproduction notes
- critical read notes
- project relevance
- uncertainty markers

## 9.2 Output design rules

### Rule 1: Distinguish source claim from model inference
Every field that is interpretive should, where relevant, mark whether it is:
- directly stated by authors
- synthesized from multiple paper sections
- model inference / reviewer interpretation

### Rule 2: Preserve evidence locations
Every claim row and major conclusion should point to a location strategy:
- page number
- section title
- figure/table number
- chunk identifier

In v1, string-based locator fields are acceptable so long as they are precise and reviewable. In v1.1, migrate toward structured locator objects that can encode section, page range, figure/table IDs, chunk IDs, and optional quote spans for stronger review and merge behavior.

### Rule 3: Mark uncertainty
If an extraction is weakly supported because the source is ambiguous, missing, or low quality, the output must say so explicitly.

### Rule 4: Prefer tables or bullet structures over essays
Narrative prose is allowed as a rendering format, but the underlying data should remain structured.

---

## 10. Layer 2: Literature review design

## 10.1 Purpose
Layer 2 should help the user understand a topic, not just a single paper.

Its role is to:
- scope the problem area
- organize papers into a meaningful frame
- compare approaches systematically
- surface disagreements and gaps
- recommend reading order or next steps

## 10.2 Inputs for v1

### Required
- topic statement or research question
- seed papers (titles, local files, URLs, or pre-existing paper cards)

The topic-first Layer 2 scaffold assumes the user provides `topic + research_question + seed_papers`, with optional existing Layer 1 artifacts when available.

### Light retrieval support allowed
- manual related-paper lists
- optional prompts for likely neighboring work
- hooks for future expansion to external retrieval tools

### Not required for v1
- full autonomous search pipeline
- exhaustive inclusion/exclusion automation
- citation graph crawling guarantees

## 10.3 Layer 2 pipeline stages

### Stage A: Topic scoping
Purpose:
- define the review frame
- reduce ambiguity
- decide what counts as relevant

Suggested outputs:
- `topic_scope`
- `research_question`
- `inclusion_criteria`
- `exclusion_criteria`
- `candidate_comparison_axes`

### Stage B: Single-paper normalization
Purpose:
- represent the current paper set in a common structure
- reuse Layer 1 outputs whenever possible
- keep coverage-state boundaries explicit

Output:
- `paper_set`

Coverage states:
- `seed_only`
- `partial_layer1`
- `full_layer1`

Layer 2 may identify papers needing deeper Layer 1 reads, but it does not perform those reads in v1.

### Stage C: Comparison matrix generation
Purpose:
- compare papers along stable dimensions
- avoid prose-only synthesis

Suggested matrix dimensions:
- task/problem framing
- method family
- supervision assumptions
- dataset/benchmark choices
- baselines
- evaluation metrics
- evidence strength
- stated limitations
- reproducibility clarity

### Stage D: Topic synthesis
Purpose:
- summarize the field in structured form
- highlight common patterns, disagreements, and gaps

Suggested outputs:
- `taxonomy`
- `evidence_patterns`
- `gaps_and_disagreements`
- `recommended_reading_order`
- `review_limits`
- `next_actions`

---

## 11. Recommended prompt strategy

Prompt files should be narrowly scoped. Avoid giant prompts that mix every task.

## 11.1 Good prompt decomposition

### Single-paper prompts
- `pass1-quick-pass.md`
- `pass2-method-and-results.md`
- `pass3-critique-and-repro.md`

### Literature-review prompts
- `topic-scope.md`
- `comparison-matrix.md`
- `synthesis.md`

## 11.2 Prompt rules
Each prompt should define:
- role
- exact objective
- required output structure
- citation / evidence rules
- uncertainty behavior
- forbidden behavior (e.g. unsupported claims)

## 11.3 Prompt anti-patterns to avoid
- asking for a generic summary first
- asking a single prompt to do orientation, extraction, critique, and synthesis together
- allowing freeform answers with no schema or evidence expectations
- failing to distinguish author language from model interpretation

---

## 12. Schema strategy

Schemas are central to this project. They should not be treated as optional decoration.

## 12.1 Why schemas matter here
They allow us to:
- compare runs
- write golden examples
- validate prompt output quality
- make Layer 2 consume Layer 1 reliably
- support future UI/rendering changes without rewriting extraction

## 12.2 Minimum v1 schemas
- `paper-card.schema.json`
- `quick-pass.schema.json`
- `claim-evidence.schema.json`
- `method-card.schema.json`
- `experiment-card.schema.json`
- `limitations-card.schema.json`
- `repro-notes.schema.json`
- `critical-read-notes.schema.json`
- `project-relevance.schema.json`
- `topic-scope.schema.json`
- `paper-set.schema.json`
- `comparison-matrix.schema.json`
- `literature-review.schema.json`

## 12.3 Schema review questions
- Can the fields be filled from actual paper evidence?
- Does the schema separate extraction from inference?
- Does it support future comparison across papers?
- Is it minimal enough to keep outputs stable?

---

## 13. Template strategy

Templates should transform structured outputs into readable artifacts without becoming the source of truth.

### Templates to add early
- `paper-card.md`
- `comparison-matrix.md`
- `literature-review.md`

These templates should render structured fields in a way that helps humans review the output quickly.

---

## 14. Multi-agent strategy

## 14.1 Default execution model
The default should be:
- one main orchestrator
- optional read-only subagents for isolated extraction tasks

## 14.2 Good uses of subagents
### For Layer 1
- methods extractor
- experiments extractor
- critique extractor

### For Layer 2
- topic scoping helper
- paper-card normalizer
- comparison-matrix builder
- synthesis checker

## 14.3 Why not default to teams or worktrees here
This project's main job is reading and structured reasoning, not heavy concurrent file mutation.

### Teams become worthwhile when
- processing many papers at once
- running stable parallel workflows at scale
- splitting literature review across multiple independent dimensions

### Worktrees become worthwhile when
- developing multiple competing skill implementations
- protecting the current working tree during prompt/schema experiments
- comparing alternative architectures side by side

For actual paper-reading execution, worktrees are usually not the bottleneck solution.

---

## 15. Testing strategy

Testing should focus on output quality, structure, and grounding.

## 15.1 Test categories

### Schema validation tests
Ensure prompt outputs can be validated against required schemas.

Current executable validation surface:
- `bash tests/bin/validate-json.sh`
- `bash tests/bin/check-example-001-completeness.sh`
- `bash tests/bin/check-literature-review-example-001-completeness.sh`

### Golden example tests
Use a small fixed set of known papers and expected structured outputs.

Current scaffold anchors:
- `examples/single-paper/example-001/`
- `examples/literature-review/example-001/`

### Prompt regression tests
Check that prompt changes do not remove key output sections or degrade evidence behavior.

### Reviewability tests
Human review of whether outputs:
- separate claim and evidence cleanly
- mark uncertainty
- support comparison

## 15.2 Suggested golden-set composition
For v1, choose a small, diverse set:
- one empirical ML paper
- one theory-heavy or math-heavy paper
- one benchmark-heavy engineering paper
- one paper with obvious reporting weaknesses

The first golden-set evaluations should prioritize these artifacts:
- `claim_evidence_table`
- `limitations_card`
- `repro_notes`
- `critical_read_notes`

This keeps early testing focused on the outputs that best reflect grounding, reviewability, and real reading quality rather than prose fluency.

---

## 16. Review checklists

## 16.1 Single-paper review checklist
When reviewing Layer 1 behavior, ask:
- Does the quick pass identify the real problem and claimed contribution?
- Are claims tied to evidence locations?
- Is method extraction faithful and specific?
- Are results and ablations captured accurately?
- Are limitations author-stated vs inferred clearly separated?
- Are reproduction risks identified concretely?
- Is uncertainty visible rather than hidden?

## 16.2 Literature-review review checklist
When reviewing Layer 2 behavior, ask:
- Is the topic scope explicit?
- Are comparison axes meaningful rather than generic?
- Are papers represented consistently?
- Does the synthesis identify actual disagreements or only broad commonalities?
- Are gaps grounded in the compared papers rather than hallucinated?
- Does the review suggest a useful reading order or next-step plan?

---

## 17. MVP plan

## 17.1 MVP Phase 1: Single-paper core
Deliver:
- initial repository structure
- `read-paper` skill scaffold
- Pass 0/1/2/3 prompt set
- minimal schemas for paper card outputs
- 2-3 worked examples
- single-paper review checklist

Success criteria:
- one paper can produce a stable, reviewable `paper_card`
- claim/evidence output is present and useful
- critique/repro sections are non-generic

## 17.2 MVP Phase 2: Topic review on top of paper cards
Deliver:
- `literature-review` skill scaffold
- topic-scope prompt
- paper-set coverage-state scaffold
- comparison-matrix schema and template
- synthesis prompt
- examples using 3-5 seed papers

Success criteria:
- review layer consumes normalized single-paper artifacts
- output is a real comparison, not concatenated summaries
- `seed_only`, `partial_layer1`, and `full_layer1` stay explicit
- gaps and disagreements are specific enough to discuss

## 17.3 MVP Phase 3: Retrieval-adjacent extension
Deliver:
- hooks for optional seed expansion
- related-work suggestion patterns
- interfaces for future retrieval tooling

Success criteria:
- the system can expand beyond manually supplied papers without pretending to be a full search engine

---

## 18. Open design questions to resolve before coding

These questions should be answered explicitly during implementation planning.

1. What is the canonical intermediate representation for a paper?
2. How strict should schema validation be during prompt iteration?
3. What is the fallback strategy when a PDF is poorly extractable?
4. What location format is the minimum acceptable evidence locator?
5. Should examples be hand-curated markdown outputs, machine-generated outputs, or both?
6. How much project-specific relevance logic belongs in the generic single-paper layer?
7. At what point should the review layer start supporting user-defined comparison axes?

---

## 19. Recommended immediate next implementation steps

1. Create the repository skeleton from the structure in this document.
2. Define the `paper_card` family of schemas first.
3. Draft the three single-paper prompt files.
4. Create 2-3 concrete example papers and expected outputs.
5. Build the first `read-paper` skill around those outputs.
6. Only after Layer 1 stabilizes, define the review-layer matrix and synthesis schemas.
7. Then build the `literature-review` skill.

---

## 20. Final rule for contributors

If a change makes the output sound better but makes it harder to verify, compare, or review, it is probably the wrong change for this repository.

This project should optimize for:
- disciplined reading support
- stable structures
- evidence-aware outputs
- reusable artifacts
- scalable review quality

Not for:
- impressive but opaque summaries
- ungrounded synthesis
- prompt cleverness without maintainability
