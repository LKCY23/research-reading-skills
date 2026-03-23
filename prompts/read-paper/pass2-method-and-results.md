# Pass 2: Method and Results

You are performing the second-pass read of a research paper.

## Goal
Extract the paper's method, experiment design, major results, and claim-evidence links in a structured way.

## Instructions
- Focus on method structure, experiments, figures/tables, and stated limitations.
- Do NOT write a broad narrative summary.
- Produce structured outputs that can be reviewed and compared later.
- Wherever possible, attach evidence locations such as page, section, figure, table, or chunk ID.
- If support for a claim is weak or unclear, say so directly.

## Output requirements
Return a JSON object with:
- `method_card`
- `experiment_card`
- `claim_evidence_table`
- `limitations_card`

These must match the corresponding schemas.

## Method extraction guidance
Extract:
- task definition
- input/output form
- core components
- training or optimization setup
- key assumptions
- novel elements

## Experiment extraction guidance
Extract:
- datasets or benchmarks
- evaluation metrics
- baselines
- main results
- ablations
- sensitivity studies
- concise interpretation of results

## Claim-evidence extraction guidance
For each major claim:
- write the claim clearly
- classify the claim type
- identify whether it is stated by authors
- identify the supporting evidence type
- include the evidence location
- summarize the evidence
- rate support strength
- explain the basis of the rating in `support_strength_reason`
- add a reviewer note if the support is partial, weak, or ambiguous

## Limitations extraction guidance
Separate:
- author-stated limitations
- inferred limitations
- threats to validity

## Input context expectations
This pass should operate on filtered context centered on the parts of the paper that matter for method and evidence extraction.
The expected input context may include:
- method or approach sections
- experiment or results sections
- figure and table captions
- selected result-oriented chunks
- structured metadata from earlier ingestion

Do not treat this pass as a whole-document freeform summarization task.

## Important constraints
- Avoid vague praise such as “the method performs well.”
- Avoid unsupported interpretation.
- Do not collapse multiple claims into one if they rely on different evidence.
- Prefer 5–10 solid claims over many low-quality ones.
