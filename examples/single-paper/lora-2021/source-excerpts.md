# Source excerpts for LoRA

## Title and abstract

**Title:** LoRA: Low-Rank Adaptation of Large Language Models

**Abstract excerpt (p1):**
- The paper proposes Low-Rank Adaptation (LoRA), which freezes pretrained model weights and injects trainable rank-decomposition matrices into Transformer layers.
- Using GPT-3 175B as the main example, the paper claims LoRA reduces trainable parameters by 10,000x and GPU memory requirement by 3x relative to full fine-tuning.
- The abstract states LoRA matches or exceeds fine-tuning quality on RoBERTa, DeBERTa, GPT-2, and GPT-3 while using fewer trainable parameters.
- The abstract also claims that unlike adapters, LoRA introduces no additional inference latency.

## Introduction and setup

**p1-p2, Introduction:**
- Full fine-tuning becomes impractical as pretrained models grow because each downstream task requires storing and deploying a full parameter copy.
- Existing parameter-efficient methods such as adapters and prompt/prefix tuning either introduce inference latency, reduce usable sequence length, or fail to match fine-tuning consistently.
- The core hypothesis is that task-specific weight updates have low intrinsic rank, motivating a low-rank parameterization of the update.
- The paper highlights practical advantages: frozen shared backbone, reduced storage and switching overhead, lower training hardware barrier, mergeability into pretrained weights, and compatibility with other methods.

## Problem statement and method

**p2-p4, Problem Statement / Our Method:**
- The adaptation problem is framed as learning task-specific parameter increments for a pretrained autoregressive language model.
- Instead of optimizing the full update matrix \u0394\u03a6, LoRA encodes the update with a smaller parameter set \u0398.
- For a pretrained weight matrix W0 \u2208 R^(d x k), the update is parameterized as W0 + \u0394W = W0 + BA, where B \u2208 R^(d x r), A \u2208 R^(r x k), and r is much smaller than min(d, k).
- During training W0 is frozen, and only A and B are trained.
- For Transformer experiments, the paper applies LoRA mainly to attention projection matrices and, in most experiments, specifically to Wq and Wv.
- The paper states LoRA can be merged into the base weights at deployment, which yields no additional inference latency by construction.

## Prior-method critique

**p3-p4, Aren't Existing Solutions Good Enough?:**
- Adapter layers add inference latency because they extend depth and cannot be bypassed directly.
- Prompt/prefix methods can be harder to optimize and may reduce sequence length available to downstream tasks.
- Table 1 on GPT-2 medium shows adapter variants increase latency over fine-tune/LoRA, especially at short sequence lengths and batch size 1.

## Practical benefits and limitations visible in the method section

**p5, Applying LoRA to Transformer:**
- For GPT-3 175B, the paper reports reducing VRAM during training from 1.2TB to 350GB when adapting only q and v with r = 4.
- The checkpoint size is said to be reduced by roughly 10,000x, from 350GB to 35MB for task-specific weights.
- The paper reports about 25% higher training throughput than full fine-tuning on GPT-3 175B.
- The paper notes that adapting to different tasks in one forward pass is not straightforward if one wants to batch different LoRA modules together without absorbing A and B into W.

## Experiments and tasks

**p5-p8, Empirical Experiments:**
- Evaluations cover GLUE on RoBERTa and DeBERTa, E2E NLG on GPT-2 medium/large, and WikiSQL, MNLI-m, and SAMSum on GPT-3 175B.
- Baselines include full fine-tuning, bias-only/BitFit, prefix/prompt methods, and several adapter variants.
- Table 2 reports LoRA is competitive with or slightly above full fine-tuning on RoBERTa-large and DeBERTa-XXL with far fewer trainable parameters.
- Table 3 reports GPT-2 medium/large LoRA variants outperform or match other adaptation baselines on E2E NLG with small trainable parameter counts.
- Table 4 reports GPT-3 LoRA matches or exceeds full fine-tuning on WikiSQL, MNLI-m, and SAMSum while using 4.7M or 37.7M trainable parameters instead of 175,255.8M.
- Figure 2 plots validation accuracy against trainable parameter count for GPT-3 175B and is used to argue better scalability and performance than several adaptation alternatives.

## Review notes

This example uses page and table references as string locators, consistent with the repository's current Layer 1 convention.
