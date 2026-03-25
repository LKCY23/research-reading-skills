# paper-read-skills

A skill-first, pipeline-backed toolkit for AI-assisted paper reading and literature review.

## Why this project exists

This project is built around a simple idea: the best AI workflow for reading papers is **not** "upload a PDF and ask for a summary." That approach is fast, but it is usually shallow, hard to verify, and easy to over-trust.

Instead, this repository is designed around a **layered reading workflow**:

1. **Build a map before deep reading** whenever possible.
2. **Read a single paper in passes**, not all at once.
3. **Extract claims with evidence**, not generic summaries.
4. **Turn the workflow into reusable skills and pipelines**, not ad-hoc prompts.

The goal is to combine classic paper-reading methods with modern AI assistance in a way that is:
- structured
- reviewable
- evidence-bound
- reusable
- extensible

## Core design philosophy

This repository does **not** try to make AI replace the human reader. It tries to make AI useful in the places where it is actually strong:
- structuring a long reading task
- extracting evidence from large documents
- comparing repeated patterns across papers
- generating consistent notes
- surfacing questions, assumptions, and gaps

The human remains responsible for judgment. The system should help the human:
- decide what is worth reading
- understand what the paper is claiming
- locate what evidence supports those claims
- identify what is weak, missing, or uncertain
- connect a paper back to an active research problem

## Methodological foundation

The design is grounded in several established ideas.

### 1. Three-pass reading for single papers
The project adopts the spirit of S. Keshav's well-known three-pass method:
- **Pass 1**: fast screening and orientation
- **Pass 2**: structure, method, figures, experiments, and major results
- **Pass 3**: assumptions, reproduction, critique, weak links, and transfer to your own work

This provides the conceptual backbone for the single-paper workflow.

### 2. AI as workflow support, not a one-shot summarizer
Modern long-context and long-document guidance consistently suggests that high-quality results come from:
- chunking
- staged extraction
- controlled synthesis
- explicit grounding constraints
- structured outputs

This project therefore prefers multi-step pipelines over one giant prompt.

### 3. Grounded extraction over generic summary
The most useful outputs are not broad prose summaries. They are structured artifacts such as:
- claim lists
- claim-evidence tables
- method cards
- experiment cards
- limitation notes
- reproduction notes
- comparison matrices

## Project scope

This repository is designed around **two layers**.

### Layer 1: Single-paper reading
Input:
- a local PDF
- an arXiv URL
- a local text/markdown extract
- later: source-first formats such as TeX where feasible

Output:
- a structured reading package for one paper
- evidence-aware notes
- reproducibility and critique support
- project relevance notes

### Layer 2: Topic-first literature review
Input:
- a research topic
- a research question
- a list of seed papers
- optional existing Layer 1 artifacts for those papers
- later: expanded candidate lists from retrieval tools

Output:
- a `topic_scope` artifact that defines review boundaries
- a `paper_set` artifact with explicit coverage states per paper
- a `comparison_matrix` artifact for cross-paper comparison
- a canonical aggregate `literature_review` artifact built from Layer 2 sections
- a human-readable `literature-review.md` rendering derived from the aggregate artifact
- synthesis of common patterns, disagreements, gaps, and reading order

Layer 2 is intentionally topic-first and builds on Layer 1 artifacts when they exist. In v1, Layer 2 may identify papers that need deeper Layer 1 reads, but it does not perform those missing Layer 1 reads automatically.

## What this project is not

The first version is explicitly **not** trying to be:
- a full systematic review platform
- a general-purpose academic search engine
- an automatic citation graph crawler for every publisher
- an end-to-end "literature review in one click" product
- a replacement for expert judgment

## First-version boundaries

### In scope
- skill-based entry points
- reusable pipeline design under the skill layer
- structured outputs for one paper
- structured outputs for multiple seed papers
- lightweight support for related-work expansion
- strong reviewability and evidence binding

### Out of scope for v1
- fully automated paper retrieval and ranking
- exhaustive source normalization across every publisher
- automatic claim verification against external datasets
- large-scale benchmark dashboards
- autonomous multi-agent review farms

## Architecture overview

The repository should be built as **skills on top of reusable pipelines**.

That means:
- the **skill** is the user-facing interface
- the **pipeline** is the internal reusable workflow
- the **schema** defines stable outputs
- the **templates** shape readable notes
- the **examples** serve testing and review
- the **library** serves canonical reusable paper records

### Recommended internal model

```text
User invokes skill
  -> skill validates and scopes input
  -> pipeline executes staged reading/extraction
  -> schema-constrained artifacts are produced
  -> templates render human-readable output
  -> examples/tests validate consistency
```

## Recommended repository structure

```text
paper-read-skills/
  README.md
  docs/
    development-plan.md
    methodology/
    review/
  skills/
    read-paper/
    literature-review/
  prompts/
    read-paper/
    literature-review/
  schemas/
  templates/
  pipelines/
    single-paper/
    literature-review/
  library/
    single-paper/
  examples/
  tests/
```

## Planned skill entry points

### `/read-paper`
Purpose:
- read and analyze one paper in staged passes

Expected responsibilities:
- classify input
- produce a quick-pass reading card
- extract method and experiment structure
- generate claim-evidence links
- produce critique and reproduction-oriented notes

### `/literature-review`
Purpose:
- analyze a topic or a seed-paper set using Layer 1 as the base unit

Expected responsibilities:
- scope the topic
- define comparison axes
- assemble a `paper_set` with explicit `seed_only`, `partial_layer1`, and `full_layer1` coverage states
- use Layer 1 artifacts for grounded comparison when available
- generate a `comparison_matrix`, aggregate `literature_review`, and `literature-review.md`
- identify open questions, review limits, and reading order

## Key output artifacts

### Single-paper artifacts
- `paper_card`
- `quick_pass`
- `claim_evidence_table`
- `method_card`
- `experiment_card`
- `limitations_card`
- `repro_notes`
- `critical_read_notes`
- `project_relevance`

Canonical reusable Layer 1 records should be stored under `library/single-paper/`.
Curated review and testing anchors can remain under `examples/single-paper/`.

### Literature-review artifacts
- `topic_scope` → persisted as `topic-scope.json`
- `paper_set` → persisted as `paper-set.json`
- `comparison_matrix` → persisted as `comparison-matrix.json`
- `literature_review` → persisted as `literature-review.json`
- `literature-review.md`

## Design rules that must stay true

1. **Separate author claims from model inference**
2. **Attach evidence locations whenever possible**
3. **Mark uncertainty explicitly**
4. **Prefer structured extraction over freeform prose**
5. **Treat single-paper outputs as reusable units**
6. **Keep the review layer dependent on the single-paper layer**
7. **Do not hide missing evidence behind fluent writing**

## Multi-agent stance

This project does support multi-agent patterns, but they are not the default everywhere.

### Recommended default
- single main agent for orchestration
- optional read-only subagents for focused extraction

### Good uses of subagents
- one agent for methods
- one agent for experiments
- one agent for limitations / critique
- one agent for comparison matrix generation across paper cards

### When not to start with worktrees
Worktrees are mainly valuable for **isolating code changes**, not for reading papers. They are most useful when:
- developing multiple implementations of the skill itself
- testing competing prompt/pipeline designs in parallel
- protecting an active working tree during larger code changes

They are usually **not** the right default for running the reading workflow itself.

## Development strategy

### Phase 1: Single-paper core
Build the atomic unit first.

Deliverables:
- input contract
- staged passes
- structured output schema
- example paper runs
- review checklist

### Phase 2: Multi-paper synthesis
Build topic review on top of single-paper outputs.

Deliverables:
- topic scoping
- comparison matrix
- synthesis pipeline
- seed-paper workflow
- examples across 3-5 papers

### Phase 3: Retrieval-adjacent expansion
Add light retrieval support without turning v1 into a search platform.

Deliverables:
- seed input expansion hooks
- related-work suggestion hooks
- ranking or inclusion heuristics

## Review standards

A contribution is not good because the prose sounds polished. It is good if it improves:
- grounding
- repeatability
- output structure
- interpretability
- reviewability

When reviewing, ask:
- Does this preserve evidence binding?
- Does it reduce hallucination risk?
- Does it keep author claims separate from inferred interpretation?
- Does it make outputs easier to compare across papers?
- Does it improve the layered architecture rather than bypass it?

## How to use this repository later

This repository should eventually support two common modes.

### Mode A: Deep read one paper
Use when:
- a paper looks central
- you need to reproduce or critique it
- you want project-specific relevance notes

### Mode B: Build a topic overview
Use when:
- entering a new area
- preparing a reading list
- comparing methods
- writing a review memo or early survey draft

## Quality bar for the final system

The system succeeds if it helps a researcher answer questions like:
- What is this paper really claiming?
- Where is the strongest evidence for that claim?
- What assumptions does the method depend on?
- What would I need to verify to reproduce it?
- How does it differ from nearby papers?
- What does this change in my own research plan?

## Next step

The detailed implementation plan for the project lives in `docs/development-plan.md`.
That document should be treated as the source of truth for development sequencing, architecture, schemas, testing, and review standards.
