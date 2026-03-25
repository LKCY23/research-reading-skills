# Single-paper identity and reuse contract

This file defines the minimal repository-side contract for duplicate detection and reuse in the Layer 1 `/read-paper` workflow.

It is intentionally execution-light.
The current repository does not yet contain a full orchestration module, so this document establishes the matching rules, file contract, and decision semantics that a later executor should follow.

## Goal

Before starting a new paper read, the execution layer should be able to:

1. normalize the incoming paper identity
2. search `library/single-paper/` for existing matches
3. determine whether the repository already contains reusable Layer 1 artifacts
4. support three user-visible actions:
   - use existing artifacts
   - rerun selected passes
   - reread from scratch

## Search scope

Duplicate detection should search:

1. `library/single-paper/` first
2. `examples/single-paper/` second, only as fallback discovery or migration aid

Why:
- `library/single-paper/` is the canonical reusable store
- `examples/single-paper/` remains review/test-oriented and should not become the primary persistence layer

## Canonical record layout

A reusable paper record lives at:

```text
library/single-paper/<paper-slug>/
  input-metadata.json
  identity.json
  artifacts/
```

`input-metadata.json` preserves the source-facing metadata already used in examples.

`identity.json` is the repository-side file used for duplicate detection.

## `identity.json` contract

The identity record should be a JSON object with this minimal shape:

```json
{
  "paper_slug": "lora-2021",
  "canonical_title": "LoRA: Low-Rank Adaptation of Large Language Models",
  "normalized_title": "lora low rank adaptation of large language models",
  "year": 2021,
  "authors": ["Edward Hu", "Yelong Shen"],
  "normalized_authors": ["edward hu", "yelong shen"],
  "arxiv_id": "2106.09685",
  "doi": null,
  "url": "https://arxiv.org/abs/2106.09685v2",
  "version": "v2",
  "source_fingerprints": [
    "local-pdf:/Users/liyao/Desktop/schedule/LORA- LOW-RANK ADAPTATION OF LARGE LANGUAGE MODEL.pdf"
  ],
  "match_keys": {
    "strong": [
      "arxiv:2106.09685",
      "title-year:lora low rank adaptation of large language models::2021"
    ],
    "weak": [
      "title:lora low rank adaptation of large language models"
    ]
  }
}
```

Notes:
- `paper_slug` is the directory name.
- `canonical_title` preserves human-readable title casing.
- `normalized_title` is lowercased, whitespace-normalized, and punctuation-light for matching.
- `normalized_authors` is optional but recommended when author overlap is used as a tie-breaker.
- `source_fingerprints` records known source locations or URLs previously used for ingestion.
- `match_keys` gives a future executor precomputed identity handles without changing the existing Layer 1 artifact schemas.

## Paper identity matching rules

The executor should classify matches as `exact`, `probable`, or `none`.

### Exact match

Treat as `exact` if any of the following holds:

1. same `arxiv_id`
2. same DOI
3. same normalized title and same year

### Probable match

Treat as `probable` if exact match fails but one of the following holds:

1. same normalized title with missing year on one side
2. same normalized title and overlapping author set
3. same URL after normalizing obvious arXiv version differences

### No match

Treat as `none` if neither exact nor probable conditions hold.

## Normalization rules

### Title normalization

For matching only:
- lowercase
- collapse repeated whitespace
- strip most punctuation
- preserve alphanumeric tokens
- do not try to infer abbreviations or semantic aliases

This keeps the contract simple and reviewable.

### URL normalization

For arXiv URLs:
- treat `https://arxiv.org/abs/<id>` and `https://arxiv.org/pdf/<id>.pdf` as the same base paper identity
- ignore the version suffix for `probable` matching
- preserve the version suffix in stored metadata for provenance

### Author normalization

For matching only:
- lowercase
- trim whitespace
- preserve ordering in storage, but compare as sets for overlap checks

## Reuse decision semantics

After lookup, the executor should compute an `artifact_state` from the matched record.

### Complete

`complete` means the record contains all expected Layer 1 artifacts:
- `quick-pass.json`
- `method-card.json`
- `experiment-card.json`
- `claim-evidence-table.json`
- `limitations-card.json`
- `repro-notes.json`
- `critical-read-notes.json`
- `project-relevance.json`
- `paper-card.json`
- `paper-card.md`

### Partial

`partial` means the paper record exists but one or more pass artifacts are missing.

### Metadata-only

`metadata_only` means the paper record exists with identity and input metadata but has no usable Layer 1 artifacts yet.

## User-visible actions

A future `/read-paper` executor should support these three actions when an existing match is found.

### 1. Use existing

Use when:
- match is `exact` or user-approved `probable`
- existing artifact state is `complete` or sufficiently complete for the user goal

Behavior:
- do not regenerate unchanged pass artifacts
- return the existing paper record as the working Layer 1 package
- report that the paper was already present and reused

### 2. Rerun selected passes

Use when:
- the paper already exists
- the user wants updated artifacts for only part of the pipeline
- or the record is partial and needs completion

Behavior:
- keep `input-metadata.json` and `identity.json`
- regenerate only the requested pass outputs and downstream aggregates
- rebuild `paper-card.json`
- rerender `paper-card.md`

Recommended pass dependency rules:
- rerunning Pass 1 regenerates `quick-pass.json`
- rerunning Pass 2 regenerates:
  - `method-card.json`
  - `experiment-card.json`
  - `claim-evidence-table.json`
  - `limitations-card.json`
- rerunning Pass 3 regenerates:
  - `repro-notes.json`
  - `critical-read-notes.json`
  - `project-relevance.json`
  - `uncertainty_summary` inside `paper-card.json`
- rerunning Pass 2 should normally invalidate and rerun Pass 3 as well, because Pass 3 depends on Pass 2 outputs

### 3. Reread from scratch

Use when:
- the user explicitly wants a fresh read
- the prior record is low-confidence or structurally stale
- the matched source is only `probable` and the user prefers not to reuse it

Behavior:
- keep the same paper directory only if the identity is confirmed to be the same paper
- otherwise create a new library record
- regenerate all pass artifacts and both aggregate outputs
- replace stale artifacts rather than mixing old and new pass outputs

## Minimal executor contract

If a later execution module is added, it should expose a pre-read lookup step with an interface equivalent to:

```text
lookup_existing_paper(input_metadata) -> {
  match_status: exact | probable | none,
  matched_record_path: string | null,
  artifact_state: complete | partial | metadata_only | none,
  available_artifacts: string[],
  recommended_actions: [use_existing, rerun_selected_passes, reread_from_scratch]
}
```

The repository does not need runnable code for this yet, but any future implementation should preserve these semantics.

## Relationship to existing schemas

This contract deliberately avoids changing the current Layer 1 artifact schemas.

Why:
- `paper-card.schema.json` already defines the durable analysis package
- the missing piece is repository-side persistence and lookup, not a new analysis artifact format
- `identity.json` adds duplicate-detection support without destabilizing current examples, templates, or tests

## Current limitations

This contract does **not** yet provide:
- executable lookup code
- automatic migration from `examples/single-paper/` into `library/single-paper/`
- content hashing or PDF byte-level fingerprinting
- conflict resolution across multiple probable matches
- version-history storage for repeated rereads of the same paper

Those can be added later if the repository evolves from documentation-first to executable orchestration.
