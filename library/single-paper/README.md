# Single-paper library overview

This directory is the canonical persistence layer for reusable Layer 1 single-paper artifacts.

It is distinct from `examples/single-paper/`.

- `examples/single-paper/` holds curated examples, scaffolds, and review anchors.
- `library/single-paper/` holds canonical paper records that future `/read-paper` executions can look up and reuse.

## Purpose

The library exists so a future execution layer can answer these questions before starting a new read:

1. Does this paper already exist in the repository?
2. If it exists, which Layer 1 artifacts are already present?
3. Should the workflow reuse the existing artifacts, rerun selected passes, or reread from scratch?

## Canonical layout

Each paper should live in its own slugged directory:

```text
library/single-paper/<paper-slug>/
  README.md
  input-metadata.json
  source-excerpts.md
  identity.json
  artifacts/
    quick-pass.json
    method-card.json
    experiment-card.json
    claim-evidence-table.json
    limitations-card.json
    repro-notes.json
    critical-read-notes.json
    project-relevance.json
    uncertainty-summary.json
    paper-card.json
    paper-card.md
  saved-run.json
```

## Required repository-side conventions

### 1. Library records are the canonical reusable store

If a paper has both an example copy and a library copy, the library copy is the canonical record for future reuse decisions.

Examples may duplicate or snapshot outputs for testing and review, but future execution should not treat examples as the primary persistence surface.

### 2. `input-metadata.json` keeps the source-facing metadata

This should remain aligned with the existing Layer 1 metadata shape already used by examples and `paper-card.metadata`.

### 3. `identity.json` is the repository-side matching contract

This file records the normalized identifiers and matching evidence used for duplicate detection.
Its exact schema is documented in `pipelines/single-paper/library-identity-and-reuse.md`.

### 4. `artifacts/` keeps pass outputs

Artifact filenames should stay aligned with the existing repository naming conventions so current schemas, templates, and review docs remain valid.

### 5. `saved-run.json` records persistence metadata

This file records when a completed artifact set was saved into the library and where it came from.
It is the minimal repository-side manifest for future refresh and deduplication flows.

## Current library contents

The repository currently includes canonical library records for:
- `lora-2021`
- `openclaw-rl-2026`
- `scaling-agent-systems-2025`

## Current scope

This directory is documentation-first in the current repository state.

It defines:
- where canonical persistent paper artifacts should live
- how future execution should distinguish examples from reusable records
- where duplicate detection should look first

It does **not** claim that automatic migration or orchestration is fully implemented yet.
