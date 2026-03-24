# Source excerpts for OpenClaw-RL

## Title and abstract-level framing

**Title:** OpenClaw-RL: Train Any Agent Simply by Talking

**p1 summary:**
- Every agent interaction produces a next-state signal such as a user reply, tool output, terminal state, or GUI state change.
- The paper claims existing agentic RL systems do not recover this live next-state signal as an online learning source.
- OpenClaw-RL is presented as a unified framework for personal and general agents, using the same idea across personal conversations, terminal, GUI, SWE, and tool-call settings.
- Two kinds of signal are identified: evaluative signals for scalar rewards and directive signals for token-level corrective supervision via Hindsight-Guided On-Policy Distillation (OPD).
- The infrastructure is fully decoupled and asynchronous so the model can keep serving while reward judging and training happen in parallel.

## Problem setting and infrastructure

**p3-p6:**
- The paper formalizes each interaction stream as an MDP where the reward depends on the next-state signal.
- The core system has four decoupled components: policy serving, environment hosting, reward judging, and policy training.
- For personal agents, the environment is the user's device and sessions are tracked so only main-line turns become training data.
- For general agents, the system supports terminal, GUI, SWE, and tool-call settings, each with different environment characteristics and next-state signals.
- Table 1 lists next-state signals by setting: user response/tool-call results for OpenClaw, stdout/stderr/exit code for terminal, visual state diff/task progress for GUI, test verdicts/diff/lint output for SWE, and return values/error traces for tool-call.
- Logs are written in real time to JSONL with prompt/response text, tool calls, next-state content, judge scores, and OPD hints.

## Learning methods

**p6-p9:**
- Binary RL converts evaluative next-state signals into scalar process rewards using a PRM judge and majority vote.
- The PPO-style objective uses direct advantage from the judged reward with asymmetric clipping.
- OPD handles directive signals by extracting a concise hindsight hint from the next state, appending it to the prompt, querying the same model as an enhanced teacher, and computing token-level advantage as log p_teacher minus log p_student.
- The paper emphasizes that OPD trades sample quantity for signal quality by dropping turns without a valid clear hint.
- Table 2 contrasts Binary RL, OPD, and Combined training: evaluative vs directive signals, sequence-level vs token-level advantage, and broad-vs-rich feedback.
- For general agent RL, the paper integrates outcome and process rewards step-wise and argues process rewards are vital for long-horizon tasks.

## Experiments

**p10-p12:**
- There are two tracks: personal agent optimization and general agent RL.
- Personal track uses simulated student and teacher settings on GSM8K-derived homework tasks and reports personalization score improvements.
- General-agent track uses terminal, GUI, SWE, and tool-call settings with models including Qwen3 variants and Qwen3-VL-8B-Thinking.
- Datasets include SETA RL data, OSWorld-Verified, SWE-Bench-Verified, and DAPO RL data.
- Hyperparameters include learning rate 1e-6, KL coefficient 0.01, clip ratios 0.2 / 0.28, and setting-specific batch sizes and interaction limits.
- Table 3 shows in the personal track that the combined method beats Binary RL and OPD individually after 8 and 16 update steps.
- Figure 4 and Table 4 show scalable RL across terminal, GUI, SWE, and tool-call settings, and that integrating outcome and process rewards outperforms outcome-only in tool-call and GUI settings.

## Conclusions and appendices

**p12-p24:**
- The conclusion restates the main claim: next-state signals are stream-agnostic and can drive a unified training loop across personal and general agents.
- The appendices provide algorithm pseudocode for Binary RL and OPD, worked optimization examples, judge prompt templates, and a complete hyperparameter table.
- Appendix pseudocode confirms the paper's claim that the trainer queue is fed asynchronously after next-state extraction and reward judging.
- The hyperparameter appendix gives concrete values for optimizer, rollout, and judge settings, improving reproducibility.

## Review notes

This example uses page, table, figure, and appendix references as string locators, consistent with the repository's current Layer 1 convention.
