# Aggregation

## Purpose

Aggregation defines the current paper set for a Layer 2 review.
It turns scoped topic input and available Layer 1 artifacts into a reviewable `paper_set` representation.

## Paper-set representation

The main output of this stage is `paper_set`.
It should represent:
- the papers currently under review
- why each paper is included
- what Layer 1 artifacts are available per paper
- whether each paper is ready for grounded comparison

Each paper row should make the following inspectable:
- `paper_id`
- `title`
- `authors`
- `coverage_state`
- `inclusion_reason`
- `layer1_artifacts_available`
- `comparison_readiness_note`

The paper set should also record:
- `coverage_summary`
- `missing_layer1_artifacts`
- `papers_needing_deeper_read`

## Coverage-state contract

Each paper in `paper_set` must declare exactly one coverage tier:
- `seed_only`
- `partial_layer1`
- `full_layer1`

These labels are part of the Layer 2 contract and should remain explicit in downstream comparison and synthesis.

## Missing Layer 1 artifact handling

Aggregation should make missing Layer 1 artifacts visible instead of treating them as silently available.

If a paper lacks expected Layer 1 artifacts, the paper set should:
- record that absence in `layer1_artifacts_available` and related summary fields
- keep the paper's `coverage_state` honest
- note whether the missing artifacts limit comparison readiness
- add the paper to `papers_needing_deeper_read` when a deeper Layer 1 read is the next justified action

## Coverage-tier meanings

### `seed_only`
Use this when the paper is present from seed input or lightweight metadata only.
No durable Layer 1 artifact package is available yet.

### `partial_layer1`
Use this when some Layer 1 artifacts exist, but the paper does not yet have a complete Layer 1 package.
Comparison can rely only on the artifacts that actually exist.

### `full_layer1`
Use this when a durable Layer 1 package exists and is the preferred basis for grounded cross-paper comparison.

## Handoff to comparison

Aggregation should leave comparison with:
- a stable `paper_set`
- explicit coverage tiers per paper
- visible missing-artifact notes
- readiness guidance that prevents comparison from flattening seed-only and fully read papers into the same evidence tier

## Layer 1 boundary in v1

Aggregation may identify papers that need deeper Layer 1 reads, but it does **not** perform those reads in v1.
It records missing artifacts and deeper-read candidates so later comparison and synthesis stay honest about current coverage.
