# Adaptation, training, and scaling choices relevant to agent systems

## Topic at a glance

- **Created from:** three-paper Layer 1-backed set
- **Paper count:** 3
- **Coverage state:** all papers are currently `full_layer1`

## Research question

How do papers relevant to agent-oriented AI systems intervene at different levels of the stack—model adaptation, policy learning from interaction, and system-level scaling—and what does each level make visible or leave unresolved?

## Scope and boundaries

This example is intentionally topic-first and heterogeneous.
It compares intervention layers, evidence styles, and unresolved questions rather than ranking methods on a shared benchmark.

### Included papers
- `lora-2021` — model adaptation anchor
- `openclaw-rl-2026` — agent training anchor
- `scaling-agent-systems-2025` — system scaling and evaluation anchor

### Scope risks
- The seed set is heterogeneous and not a same-task benchmark family.
- LoRA is relevant indirectly through model adaptation, not because it is natively the same kind of agent-systems paper as the other two.

## Included papers and coverage state

### `lora-2021`
- Coverage: `full_layer1`
- Role: model adaptation layer
- Why included: anchors efficient model adaptation relevant to agent-oriented systems

### `openclaw-rl-2026`
- Coverage: `full_layer1`
- Role: agent learning from interaction
- Why included: anchors learning from next-state signals and RL for agents

### `scaling-agent-systems-2025`
- Coverage: `full_layer1`
- Role: system-level scaling and coordination evaluation
- Why included: anchors when multi-agent coordination helps or hurts

## Comparison matrix overview

### Level of intervention
- LoRA → model adaptation
- OpenClaw-RL → agent training from interaction
- Scaling Agent Systems → system-level scaling/evaluation

### Primary objective
- LoRA → efficient adaptation of large models
- OpenClaw-RL → improve deployed agents from next-state signals
- Scaling Agent Systems → derive predictive architecture-selection rules for agent systems

### Evidence type
- LoRA → adaptation benchmarking and efficiency evidence
- OpenClaw-RL → online agent-training framework with multi-setting experiments
- Scaling Agent Systems → controlled architecture and scaling study with predictive modeling

## Taxonomy

- **Model adaptation** → LoRA
- **Agent learning from interaction** → OpenClaw-RL
- **System scaling and coordination evaluation** → Towards a Science of Scaling Agent Systems

## Common evidence patterns

- Each paper supports a different layer of the stack with a different evidence style: adaptation benchmarking, online learning experiments, and controlled architecture evaluation.
- The strongest cross-paper synthesis is not about a single best method, but about what becomes visible when intervention shifts from model weights to live interaction learning to coordination structure.

## Gaps and disagreements

- The papers are complementary rather than interchangeable: efficient adaptation, online agent learning, and coordination science solve different bottlenecks.
- LoRA improves the model layer but does not answer whether agents can improve from interaction or whether coordination is worth its overhead.
- OpenClaw-RL shows next-state-driven learning can help agents, but the scaling paper shows that stronger agent loops do not imply that multi-agent coordination is beneficial on every task.

## Recommended reading order

1. **LoRA** — establish the model-adaptation layer
2. **OpenClaw-RL** — move to agent improvement from interaction signals
3. **Towards a Science of Scaling Agent Systems** — zoom out to architecture-level coordination and scaling behavior

## Review limits

- This is a heterogeneous three-paper set, not a same-task benchmark family.
- LoRA is included as a model-adaptation anchor relevant to agent systems, not as a direct online-agent or coordination paper.
- The synthesis is now grounded by full Layer 1 artifacts for all three papers, but cross-paper superiority claims still remain structurally limited.

## Next actions

- Add closer neighboring papers around each layer if you want denser within-layer comparison.
- Use this set as a worked example of stack-level intervention analysis rather than leaderboard comparison.
- Add a bridging paper if you want tighter linkage between model adaptation and online agent learning.
