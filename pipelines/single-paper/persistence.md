# Read-paper persistence and library layout

This document defines the minimal repository-side persistence contract for `/read-paper` outputs.

## Goal

When a single-paper read completes, the resulting artifact set should be persisted under:

```text
library/single-paper/<paper-id>/
```

This keeps Layer 1 outputs reusable for later literature-review work without relying on transient chat output.

## Current scope

This repository does **not** yet implement a fully automated orchestration runner.
That is intentional.

For the current repository state, the persistence layer is defined as:
- a canonical on-disk directory contract
- required file names for a saved single-paper read
- a manifest that records what was saved
- a lightweight helper script that can scaffold a destination directory from existing artifacts

A later execution layer can call this contract directly.

## Canonical destination

Each completed single-paper read should be saved to:

```text
library/single-paper/<paper-id>/
```

Where `<paper-id>` is a stable slug such as:
- `lora-2021`
- `openclaw-rl-2026`
- `scaling-agent-systems-2025`

## Required directory shape

```text
library/
  single-paper/
    <paper-id>/
      README.md
      input-metadata.json
      source-excerpts.md
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

## Artifact rules

### Required files

A persisted Layer 1 read should include the full current artifact set:
- `input-metadata.json`
- `source-excerpts.md`
- `artifacts/quick-pass.json`
- `artifacts/method-card.json`
- `artifacts/experiment-card.json`
- `artifacts/claim-evidence-table.json`
- `artifacts/limitations-card.json`
- `artifacts/repro-notes.json`
- `artifacts/critical-read-notes.json`
- `artifacts/project-relevance.json`
- `artifacts/uncertainty-summary.json`
- `artifacts/paper-card.json`
- `artifacts/paper-card.md`

### Aggregate artifact expectations

`paper-card.json` remains the durable aggregate record.

It should embed:
- metadata
- all structured pass artifacts
- `uncertainty_summary`

`paper-card.md` remains the human-readable rendering.

## Saved-run manifest

Each persisted read should also write `saved-run.json` at the paper root.

Purpose:
- record the persistence timestamp
- record the source of the saved artifact set
- record the target library path
- make later deduplication and refresh flows easier

Suggested shape:

```json
{
  "paper_id": "lora-2021",
  "saved_at": "2026-03-25T00:00:00Z",
  "saved_from": "examples/single-paper/lora-2021",
  "library_path": "library/single-paper/lora-2021",
  "artifact_files": [
    "input-metadata.json",
    "source-excerpts.md",
    "artifacts/quick-pass.json",
    "artifacts/method-card.json",
    "artifacts/experiment-card.json",
    "artifacts/claim-evidence-table.json",
    "artifacts/limitations-card.json",
    "artifacts/repro-notes.json",
    "artifacts/critical-read-notes.json",
    "artifacts/project-relevance.json",
    "artifacts/uncertainty-summary.json",
    "artifacts/paper-card.json",
    "artifacts/paper-card.md"
  ]
}
```

A future orchestration layer may extend this manifest with:
- source hash
- duplicate-of pointer
- run identifier
- save mode such as `new`, `refresh`, or `reuse`

## Minimal save flow for a future runner

A future `/read-paper` orchestration layer should:

1. Determine the target `paper_id`.
2. Produce the full Layer 1 artifact set.
3. Create `library/single-paper/<paper-id>/` if needed.
4. Write all required root files and `artifacts/` files.
5. Write `saved-run.json`.
6. Return the saved path to the user.

## Repository helper

This repository includes a lightweight helper script:

```bash
python3 scripts/save_single_paper_artifacts.py --source <dir> --paper-id <paper-id>
```

The script copies a completed artifact set into the canonical library destination and writes `saved-run.json`.

Current intent:
- scaffold persistence behavior now
- give a future orchestration layer a stable save target
- avoid pretending the full automated read runner already exists

## Existing library records

The repository already contains concrete library records under `library/single-paper/` for:
- `lora-2021`
- `openclaw-rl-2026`
- `scaling-agent-systems-2025`

Those directories follow the canonical save target and can be treated as persisted Layer 1 examples until a dedicated execution layer writes new records automatically.

## Relationship to examples

`examples/single-paper/` remains useful for:
- worked examples
- quasi-golden baselines
- review and testing

`library/single-paper/` is the canonical persistence target for saved reads.

Examples may later be copied into the library when they represent completed reusable reads.

## Current limitation

This contract defines **where** and **how** a single-paper read should be saved, but it does not yet implement end-to-end automatic paper ingestion and pass execution from raw user input.

That later orchestration layer should save into this exact structure rather than inventing a second storage format.
