# Prompt validation notes

This directory is reserved for prompt-contract validation.

## Current expectations

Prompt validation should check:
- prompts reference the correct schema field names
- prompts match the intended pass boundaries
- prompts do not collapse multiple passes into one summary task
- prompts preserve uncertainty and evidence-binding rules

## Current reference files

- `prompts/read-paper/pass1-quick-pass.md`
- `prompts/read-paper/pass2-method-and-results.md`
- `prompts/read-paper/pass3-critique-and-repro.md`

## Specific checks worth preserving

- Pass 1 uses `claimed_contributions`
- Pass 2 uses `support_strength_reason`
- Pass 3 requires `critical_read_notes`
- Pass 3 is built on Pass 2 outputs plus selected chunks, not a naive full-document reread
