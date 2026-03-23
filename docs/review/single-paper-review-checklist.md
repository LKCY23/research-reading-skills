# Single-paper review checklist

Use this checklist when reviewing outputs from the Layer 1 `read-paper` workflow.

## Quick pass
- Does `quick_pass` identify the real problem the paper addresses?
- Are the claimed contributions specific rather than generic?
- Is the decision about worth-deep-reading justified?
- Are uncertainty flags explicit when the source is incomplete or ambiguous?

## Method and experiments
- Is `method_card` faithful to the paper’s actual structure?
- Are core components broken out clearly?
- Is `experiment_card` specific about datasets, metrics, baselines, and main results?
- Are ablations and sensitivity studies captured when present?

## Claims and evidence
- Are claims split into reviewable units rather than merged into broad prose?
- Is each claim tied to an evidence location?
- Is `support_strength` reasonable?
- Does `support_strength_reason` explain the rating in a reviewable way?
- Are unsupported or weakly supported claims marked honestly?

## Limitations and critique
- Are author-stated limitations separated from inferred limitations?
- Do `critical_read_notes` identify actual support gaps or confounds?
- Are fairness-of-comparison concerns concrete rather than vague?
- Is the overall critical take cautious when evidence is limited?

## Reproducibility
- Do `repro_notes` identify missing details and risky ambiguities?
- Are first replication checks practical and specific?
- Are expected failure points plausible and grounded in the paper?

## Project relevance
- Does `project_relevance` connect the paper to the stated topic or project?
- Are reusable ideas and ignorable parts actually useful?
- Are suggested next readings plausible follow-ups?

## Overall quality bar
- Does the output distinguish author claims from model interpretation?
- Is uncertainty visible instead of hidden?
- Is the result more useful than a generic summary?
- Could this output be reused later in Layer 2 without major cleanup?
