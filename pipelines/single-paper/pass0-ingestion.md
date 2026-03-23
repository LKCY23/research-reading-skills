# Pass 0: Ingestion

## Purpose

Pass 0 is the input-normalization layer for single-paper reading.

Its job is not to interpret the paper deeply.
Its job is to make later reading passes possible and stable.

Specifically, it should:
- identify what kind of source the user has provided
- preserve as much useful structure as possible
- expose section, figure, table, and chunk boundaries when available
- establish a locator strategy for later evidence binding
- surface source-quality limitations early

## Inputs

Pass 0 should be designed to accept one of the following source forms:
- local PDF path
- arXiv URL
- local text file
- local markdown file
- direct paper excerpt pasted by the user

Optional contextual inputs:
- user-provided topic or project context
- user-provided notes about what they care about in the paper

## Expected outputs

Pass 0 does not yet require a finalized standalone schema in the repository, but it should conceptually produce a normalized source representation containing:
- source type
- title if recoverable
- abstract if recoverable
- section index if recoverable
- figure/table index if recoverable
- reference index if recoverable
- chunk list or chunk references if chunking is used
- locator strategy metadata
- source-quality warnings

## Locator strategy

For the current repository version:
- later Layer 1 artifacts are allowed to use string locators
- page/section/table references are acceptable if they are precise and reviewable

Future direction:
- migrate toward structured locator objects containing fields such as section, page range, figure IDs, table IDs, chunk IDs, and optional quote spans

## Responsibilities

### Source classification
Decide whether the source is best treated as:
- `pdf`
- `arxiv`
- `text`
- `markdown`
- `html`
- `other`

### Metadata capture
Extract or preserve the minimum stable metadata used by `paper_card.metadata`:
- `title`
- `source_type`
- `parsed_from`
- `ingestion_timestamp`

Optional metadata when available:
- authors
- venue
- year
- doi_or_url
- arxiv_id
- version

### Structural preservation
Where possible, preserve:
- section names
- page boundaries
- figure captions
- table captions
- equations or algorithm markers
- references

### Quality warnings
If the source is incomplete or low quality, Pass 0 should surface that before downstream passes proceed.
Examples:
- missing page structure
- bad OCR
- incomplete excerpts
- absent figures/tables
- malformed section boundaries

## Non-goals

Pass 0 should not:
- perform the full reading analysis
- generate a paper summary
- decide whether claims are well supported
- invent structure that is not recoverable from the source

## Downstream consumers

Pass 1 depends on Pass 0 for:
- metadata
- title/abstract availability
- introduction/conclusion routing
- section index

Pass 2 depends on Pass 0 for:
- locating method/results sections
- figure/table references
- chunk references

Pass 3 depends on Pass 0 for:
- precise evidence references when critique and reproduction notes are written

## Current implementation note

In the current repository state, Pass 0 is a documented contract rather than a completed automated module.
That is intentional.
The purpose of this file is to make the ingestion boundary explicit so later implementation does not collapse source normalization and reading into one opaque step.
