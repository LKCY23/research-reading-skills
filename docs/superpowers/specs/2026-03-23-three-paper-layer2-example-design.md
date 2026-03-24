# Three-Paper Heterogeneous Layer 2 Example Design

## Goal

Define a semi-real Layer 2 literature-review example built from three user-provided papers as a **wide-topic, heterogeneous seed set** rather than a narrow head-to-head method comparison.

The purpose of this step is to pressure-test the newly implemented Layer 2 scaffold against a realistic but structurally uneven paper set.

## Candidate papers

The intended seed papers are:
- `LORA- LOW-RANK ADAPTATION OF LARGE LANGUAGE MODEL.pdf`
- `OpenClaw-RL- Train Any Agent Simply by Talking.pdf`
- `Towards a Science of Scaling Agent Systems.pdf`

## Why this set is useful

These papers are related, but not tightly same-problem comparators.
That is a feature, not a bug, for this example.

They sit at different layers of the agent-system stack:
- model adaptation
- policy learning from interaction
- system-level scaling and coordination evaluation

This makes them a strong test for whether the Layer 2 scaffold can support:
- explicit topic scoping
- honest coverage-state reporting
- heterogeneous comparison axes
- visible review limits
- synthesis without pretending the papers are directly benchmark-comparable

## Design choice

This example should be treated as a **topic-first literature review scaffold for a heterogeneous seed set**.

It should **not** be framed as:
- a benchmark-style method comparison
- a same-task ablation family
- a direct empirical winner/loser ranking

The comparison should instead focus on:
- level of intervention
- objective of the work
- evidence type
- scope of the agent system being discussed
- limitations and open questions left by each layer

## Topic

**Adaptation, training, and scaling choices relevant to agent systems**

This wording is intentionally broader and more honest for the selected seed set.
It allows LoRA to function as a model-adaptation anchor that is relevant to agent systems without pretending that all three papers are natively the same kind of agent-systems paper.

## Research question

**How do current papers relevant to agent-oriented AI systems intervene at different levels of the stack—model adaptation, policy learning from interaction, and system-level scaling—and what does each level make visible or leave unresolved?**

This question is intentionally synthetic rather than benchmark-specific.
It is designed to compare conceptual roles, evidence styles, and scope boundaries across heterogeneous papers.

## Seed-paper roles

### Paper 1: LoRA
Role in the review:
- model adaptation layer

What it contributes to the topic:
- parameter-efficient model adaptation
- a mechanism for changing model behavior without full fine-tuning
- an efficiency-oriented intervention at the model-update level

What it does **not** cover directly:
- agent interaction learning
- online correction from deployment traces
- multi-agent scaling laws

### Paper 2: OpenClaw-RL
Role in the review:
- agent learning layer

What it contributes to the topic:
- learning from interaction traces and next-state signals
- online or near-online policy improvement framing for agents
- an intervention at the behavior-learning / agent-training level

What it does **not** fully answer:
- parameter-efficient adaptation in the LoRA sense
- principled system-level coordination scaling laws

### Paper 3: Towards a Science of Scaling Agent Systems
Role in the review:
- system scaling and evaluation layer

What it contributes to the topic:
- a framework for understanding when multi-agent systems help
- scaling behavior across architectures and task types
- an intervention at the system-design / evaluation-principles level

What it does **not** primarily focus on:
- model-update mechanisms like LoRA
- next-state RL training infrastructure like OpenClaw-RL

## Recommended comparison axes

Keep the first real example compact and high-value.
Use a small set of axes that work across heterogeneous papers.

### Axis 1: Level of intervention
Values should capture where the paper primarily acts:
- model adaptation
- agent policy learning
- system architecture / evaluation

### Axis 2: Primary objective
Examples:
- adaptation efficiency
- improvement from interaction
- scaling predictability / coordination choice

### Axis 3: Evidence type
Examples:
- algorithmic/architectural proposal
- empirical training results
- controlled benchmark scaling study

### Axis 4: Agent scope
Examples:
- base model / LLM adaptation
- single-agent or general-purpose agents
- multi-agent systems

### Axis 5: Major limitation or unresolved question
This axis is especially important because heterogeneous comparisons can drift into overclaiming unless limitations remain explicit.

## Review-limit rule

This example must explicitly document that the seed set is heterogeneous.

The resulting `review_limits` should say clearly that:
- the papers are not a same-task benchmark family
- cross-paper comparison is about **levels of intervention and evidence styles**, not direct empirical superiority
- conclusions should be interpreted as a map of the topic, not a leaderboard

## What this example should prove about Layer 2

A good semi-real example based on this design should demonstrate that the Layer 2 scaffold can:
- scope a broad but coherent topic
- represent papers with clearly different roles inside one `paper_set`
- build a `comparison_matrix` that remains honest across heterogeneous evidence types
- produce a `literature_review` that surfaces review limits instead of hiding them
- suggest what to read next or where deeper Layer 1 reads are needed

## What to avoid

Do not make this example pretend that:
- all three papers answer the same research question in the same way
- they are directly comparable on one benchmark axis
- the review can produce a single clean "best method" conclusion

Avoid forcing symmetry where the papers are genuinely different.
The value of this example is precisely that it tests a topic-first review on an uneven but meaningful paper set.

## Recommended next implementation target

The next implementation step after approving this design should be:
- replace the current Layer 2 placeholder `example-001` with a semi-real example based on these three papers, **or**
- create a new `example-002` if the current placeholder should remain as the minimal structural baseline

## Recommendation on example numbering

I recommend:
- keep the current scaffold placeholder as `example-001`
- add this three-paper semi-real example as `example-002`

Why:
- `example-001` currently serves as the minimal structural anchor
- replacing it would mix two purposes: scaffold baseline and content-bearing example
- keeping both gives the repository a cleaner progression from minimal placeholder to semi-real reference example
