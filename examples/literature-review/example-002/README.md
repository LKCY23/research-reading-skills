# Example 002: Heterogeneous three-paper Layer 2 example

This directory is a semi-real Layer 2 literature-review example built from three heterogeneous seed papers.

It is intentionally **not** a head-to-head benchmark comparison.
Its purpose is to test whether the Layer 2 scaffold can support a wide-topic, uneven seed set while keeping scope boundaries, coverage states, and review limits explicit.

## Topic

Adaptation, training, and scaling choices relevant to agent systems.

## Research question

How do papers relevant to agent-oriented AI systems intervene at different levels of the stack—model adaptation, policy learning from interaction, and system-level scaling—and what does each level make visible or leave unresolved?

## Seed papers

- `lora-2021` — *LoRA: Low-Rank Adaptation of Large Language Models*
- `openclaw-rl-2026` — *OpenClaw-RL: Train Any Agent Simply by Talking*
- `scaling-agent-systems-2025` — *Towards a Science of Scaling Agent Systems*

## Why this example exists

This example is meant to pressure-test the Layer 2 scaffold on a **heterogeneous seed set**.
The three papers are related, but not same-task comparators.

They operate at different layers:
- model adaptation
- agent learning from interaction
- system-level scaling and evaluation

That means the output should emphasize:
- topic scoping
- coverage-state honesty
- comparison axes that tolerate asymmetry
- visible review limits

## Required files

- `README.md`
- `topic-scope.json`
- `paper-set.json`
- `comparison-matrix.json`
- `literature-review.json`
- `literature-review.md`

## Interpretation rule

Do not read this example as a leaderboard or direct benchmark comparison.
It is a topic-first synthesis across different intervention levels, not a claim that the papers solve the same problem in the same way.
