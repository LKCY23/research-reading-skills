# Source excerpts for Towards a Science of Scaling Agent Systems

## Title and abstract-level framing

**Title:** Towards a Science of Scaling Agent Systems

**p1 abstract excerpt:**
- The paper argues that principles determining agent-system performance remain underexplored despite widespread adoption.
- It formalizes agentic evaluation, characterizes scaling laws as the interplay among agent quantity, coordination structure, model capability, and task properties, and evaluates this across four benchmarks.
- The study spans Single-Agent System (SAS) and four Multi-Agent System (MAS) architectures across three LLM families and 180 configurations.
- The abstract claims a predictive model with cross-validated R^2 = 0.524 and highlights three dominant effects: a tool-coordination trade-off, a capability saturation effect, and topology-dependent error amplification.

## Introduction and framing

**p2-p4:**
- The paper pushes back against the heuristic belief that more agents always help.
- It distinguishes agentic tasks from static benchmarks using sustained multi-step environment interaction, partial observability, and adaptive strategy formation.
- It argues prior multi-agent evaluations are confounded by differing prompts, tools, and budgets and therefore do not isolate architectural effects cleanly.
- The study proposes a controlled evaluation that matches prompts, tools, and token budgets while varying only coordination structure and model capability.

## System and task definitions

**p6-p8:**
- An agent system S = (A, E, C, \u03a9) is defined using agent set, environment, communication topology, and orchestration policy.
- SAS is one reasoning locus; MAS has |A| > 1 with explicit communication topology.
- Four MAS topologies are defined: Independent, Centralized, Decentralized, and Hybrid.
- The paper distinguishes communication from coordination and emphasizes that performance gains may come from parallelism, specialization, or aggregation rather than simply adding agents.

## Benchmarks and evaluation design

**p9-p12:**
- Four benchmarks are used: BrowseComp-Plus, Finance-Agent, PlanCraft, and Workbench.
- Table 1 summarizes benchmark task types and evaluation design.
- Table 2 characterizes architecture complexity in terms of LLM calls, sequential depth, communication overhead, parallelization factor, memory complexity, and consensus structure.
- The paper uses matched total token budgets to isolate coordination effects.
- Figure 2 compares SAS and MAS performance across the four benchmarks and shows highly task-dependent outcomes.

## Main results and scaling principles

**p13-p20:**
- Finance-Agent benefits strongly from coordinated MAS variants, while PlanCraft degrades across all MAS variants.
- Domain complexity alone is not sufficient; task decomposability is highlighted as the critical determinant of whether coordination helps.
- The paper identifies vendor-specific architecture interactions across OpenAI, Google, and Anthropic model families.
- A mixed-effects model using task and coordination metrics reaches cross-validated R^2 = 0.524, compared with weaker simpler baselines in Table 3.
- Table 4 lists coefficients for intelligence, tool count, agent count, baseline difficulty, overhead, message density, redundancy, efficiency, error amplification, and interaction terms.
- Table 5 reports coordination metrics such as success rate, turns, overhead, message density, redundancy, efficiency, and error amplification by architecture.
- Later pages interpret dominant interactions, especially the efficiency-tools interaction, overhead scaling with task complexity, and limited but context-dependent redundancy benefits.

## Review notes

This example uses page, figure, and table references as string locators, consistent with the repository's current Layer 1 convention.
