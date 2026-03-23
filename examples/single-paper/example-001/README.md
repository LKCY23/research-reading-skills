# Example 001: Single-paper workflow skeleton

This directory is a semi-realistic skeleton for a Layer 1 single-paper example.

## Purpose

It shows how one worked example should be organized without requiring the repository to include a fully completed real-paper artifact set yet.

## Planned files

- `input-metadata.json` — source metadata for the example paper
- `source-excerpts.md` — selected sections, chunk excerpts, figure/table references, or notes used for the passes
- `quick-pass.json` — expected Pass 1 output
- `method-card.json` — expected method extraction output
- `experiment-card.json` — expected experiment extraction output
- `claim-evidence-table.json` — expected claim/evidence rows
- `limitations-card.json` — expected limitations output
- `repro-notes.json` — expected reproducibility notes
- `critical-read-notes.json` — expected critique output
- `project-relevance.json` — expected topic/project relevance output
- `paper-card.json` — aggregate Layer 1 artifact
- `paper-card.md` — rendered human-readable summary from the template layer

## Suggested workflow

1. Define the example input metadata.
2. Save the minimal source excerpts or chunk references needed to justify outputs.
3. Produce the pass artifacts in order.
4. Assemble `paper-card.json`.
5. Render the human-readable markdown output.
6. Review the result with the single-paper review checklist.

## Priority artifacts for early golden testing

The first golden tests for this example should focus on:
- `claim-evidence-table.json`
- `limitations-card.json`
- `repro-notes.json`
- `critical-read-notes.json`
