# Prompt validation notes

This directory is reserved for prompt-contract validation.

## Current expectations

Prompt validation should check:
- prompts reference the correct schema field names
- prompts match the intended pass or stage boundaries
- prompts do not collapse multiple stages into one summary task
- prompts preserve uncertainty and evidence-binding rules

## Current reference files

- `prompts/read-paper/pass1-quick-pass.md`
- `prompts/read-paper/pass2-method-and-results.md`
- `prompts/read-paper/pass3-critique-and-repro.md`
- `prompts/literature-review/topic-scope.md`
- `prompts/literature-review/comparison-matrix.md`
- `prompts/literature-review/synthesis.md`

## Specific checks worth preserving

- Layer 1 Pass 1 uses `claimed_contributions`
- Layer 1 Pass 2 uses `support_strength_reason`
- Layer 1 Pass 3 requires `critical_read_notes`
- Layer 1 Pass 3 is built on Pass 2 outputs plus selected chunks, not a naive full-document reread
- Layer 2 prompts keep `topic_scope`, `paper_set`, `comparison_matrix`, `review_limits`, and `next_actions` aligned with schema names
- Layer 2 prompts preserve the distinction between `seed_only`, `partial_layer1`, and `full_layer1`
