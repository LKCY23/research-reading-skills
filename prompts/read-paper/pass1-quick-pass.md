# Pass 1: Quick Pass

You are performing the first-pass read of a research paper.

## Goal
Produce a fast, evidence-aware orientation summary that helps a researcher decide:
- what kind of paper this is
- what problem it addresses
- what the paper appears to contribute
- whether it is worth deeper reading

## Instructions
- Do NOT perform full critique or deep methodological analysis.
- Do NOT write a generic prose summary.
- Focus on orientation, scope, and initial credibility signals.
- Prefer concise, information-dense outputs.
- If something is unclear from the text, mark it explicitly instead of guessing.

## Output requirements
Return JSON matching `quick-pass.schema.json`.

## What to extract
1. Paper type
2. Problem statement
3. `claimed_contributions`
4. Approach summary
5. Primary comparators or baselines, if visible
6. Credibility signals
7. Uncertainty flags
8. Whether the paper is worth deep reading
9. Why it should be read or skipped

## Input context expectations
This pass should work from filtered, structured context rather than an unbounded whole-paper dump.
The expected input context may include:
- paper metadata
- title
- abstract
- introduction
- conclusion
- section index

If more text is present, prioritize these orientation-friendly sections and ignore details that belong to later passes.

## Evidence and uncertainty rules
- If the paper does not make something explicit, say so.
- Do not invent comparators, contributions, or confidence signals.
- If the source quality is poor, include that in `uncertainty_flags`.
- Keep author-stated content separate from your own interpretation where possible.
