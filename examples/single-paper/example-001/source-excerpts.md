# Source excerpts for Example 001

## Title and abstract

**Title:** Quantum Combinatorial Reasoning for Large Language Models

**Abstract excerpt (p1):**
- The paper presents QCR-LLM, a framework that reformulates reasoning aggregation as a higher-order unconstrained binary optimization (HUBO) problem.
- Reasoning fragments are represented as binary variables, with interactions encoding statistical relevance, logical coherence, and semantic redundancy.
- The framework uses both classical and quantum solvers, with quantum solving instantiated via BF-DCQO on IBM quantum hardware.
- The authors report improved reasoning accuracy on BIG-Bench Extra Hard (BBEH), surpassing reasoning-native systems such as o3-high and DeepSeek R1 by up to +9 pp.
- The abstract also claims a better energy profile than o3-high, approximately five times more energy-efficient.

## Introduction excerpts

**p1, Introduction:**
- Chain-of-Thought prompting improves reasoning but is not free from limitations.
- Individual reasoning traces can be redundant or contradictory, producing unstable or hallucinatory premises.
- Voting-based and self-consistency approaches still rely on heuristic aggregation and do not explicitly model underlying dependencies among reasoning fragments.
- The paper positions its contribution as extending prior combinatorial-reasoning approaches from QUBO to HUBO so that higher-order interactions among reasoning fragments can be modeled directly.

## Method excerpts

**p2, Section II:**
- For each query, the framework generates N zero-shot completions from one or more LLMs.
- Each completion is decomposed into short reasoning fragments (“reasons”), which are extracted, cleaned, and semantically normalized.
- Pairwise cosine similarities are used to merge fragments whose semantic distance falls below a threshold.
- Each remaining reasoning fragment is assigned a binary decision variable indicating whether it is included in the final aggregated reasoning sequence.
- The objective is to minimize an energy function representing global coherence, diversity, and statistical relevance.

**p2-p3, Coefficient design:**
- 1-body terms encode fragment popularity and stability.
- 2-body terms encode co-occurrence and semantic similarity penalties.
- 3-body and higher-order terms are introduced to capture collective dependencies across multiple fragments.
- Coefficients are normalized by interaction order to preserve contrast and numerical stability.

**p5, Algorithm 1 / Section IV:**
- Pipeline steps: generate multiple zero-shot CoT completions, extract atomic reasons, compute coefficients, build HUBO Hamiltonian, solve with SA/BF-DCQO, collect low-energy configurations, select stable fragments, form final prompt, query the LLM again for the final answer.

## Figures and tables

**Figure 1 (p4):**
- Shows the BF-DCQO optimization process for a single question.
- Panel (a) visualizes energy distributions across iterations and highlights the minimum-energy and 25th-percentile thresholds.
- Panel (b) shows expected inclusion frequencies of reasoning fragments and the use of a 50% threshold to select stable reasons.
- The caption frames the output as an interpretable energy landscape used to rank and select coherent reasoning fragments.

**Figure 2 (p6):**
- Gives an overview of the QCR-LLM pipeline.
- Multiple zero-shot CoT completions are sampled, reasons are extracted, mapped into a HUBO model, optimized, and then the selected subset is reintroduced into the final prompt for the LLM.

**Table I (p7):**
- Compares baseline LLMs and QCR-LLM variants on BBEH tasks Causal Understanding, DisambiguationQA, and NYCC.
- QCR-LLM (GPT-4o) improves over GPT-4o by +5.5 pp (Causal), +8.3 pp (Disambiguation), and +1.5 pp (NYCC).
- QCR-LLM (DeepSeek V1) outperforms its base model by +8.0 pp, +9.0 pp, and +4.5 pp respectively.
- Combined multi-model aggregation yields balanced improvements but not the best result on every task.

**Table II (p7):**
- Compares classical SA and quantum BF-DCQO for QCR-LLM (GPT-4o).
- BF-DCQO slightly improves over SA on Causal Understanding and NYCC, while matching on DisambiguationQA.

**Table III (p9):**
- Reports estimated per-token energy consumption across major LLMs.
- GPT-4o is estimated at 3.0 × 10^-4 Wh/token, while o3-high is estimated at 3.3 × 10^-2 Wh/token.
- The paper uses these estimates to argue QCR-LLM remains substantially more energy-efficient than reasoning-extended models like o3-high.

## Results and discussion excerpts

**p6-p7, Section V:**
- Across tested backbones, QCR-LLM improves over corresponding base models in every case reported.
- Against reasoning-native baselines, QCR-LLM (GPT-4o) exceeds o3-high by +5.5 pp on Causal but trails by -1.7 pp on Disambiguation and +8.5 pp on NYCC.
- QCR-LLM (DeepSeek V1) outperforms DeepSeek R1 by +0.5 pp, +2.5 pp, and -2.5 pp respectively, indicating competitive rather than uniformly superior performance.
- The paper argues these results support the idea that HUBO-based aggregation can distill coherent reasoning fragments better than single-sample generation.

## Limitations and caveats visible in the paper

**p7-p8:**
- The authors note that due to runtime and hardware access constraints, quantum experiments were restricted to the best-performing QCR-LLM (GPT-4o) configuration.
- They also note that current quantum hardware limits the number of qubits and circuit depth available.
- The reported positive quantum improvements are described as limited and tied to currently moderate-sized HUBO instances.

**p8, Conclusion:**
- The paper presents itself as a first experimental indication rather than a definitive demonstration of quantum advantage.
- The authors frame the work as opening the path toward regimes where harder prompts may better expose quantum advantage.

## Review notes

This example uses page-based evidence references because the current repository intentionally allows string locators in v1.
