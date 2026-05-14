# research.md — quality rules

## Sourcing

- Every non-trivial factual claim cites a primary source inline as `[text](url)` at the claim, not as a trailing footnote.
- Unsourceable claims are flagged `[unsourced — verify]`, not stated.
- Sources are primary (docs, changelogs, pricing pages, issue/thread URLs) — not LLM training data.
- Citation format is consistent throughout.
- References section dedupes and organises all cited sources.

## Analytical rigor

- Same rubric for every candidate — no cherry-picking axes for preferred ideas.
- Pillars must be distinguishing vs catalogued competitors, not generic values.
- Anti-pillars must rule out specific behaviours, not vibes.
- Deferred and dropped candidates get rationale equal in rigor to pursued ones.
- Evidence, interpretation, and recommendation must be separable. A reader should be able to disagree with your interpretation while accepting your evidence.
- No effort estimates, shipping windows, or capacity planning — those belong to follow-up specs.

## Bias awareness

- Acknowledge the project's own weaknesses — where it trails, where it's at parity. Do not only surface strengths.
- Surface counter-evidence to preferred conclusions when it exists.
- Flag subjective judgment separately from sourced signal. Phrases like "in my judgment" / "based on signals alone" are calibration, not weakness.
- User-declared preferences in the requirements spec are **input, not finding**. Don't treat the user's gut-feel ranking as research output.
- Acknowledge sample limitations in community-signal data.

## Readability

- Lead with the finding, then the evidence. Inverted pyramid.
- Tables for comparisons, prose for judgments.
- No filler ("it's important to note", "in conclusion", "as we can see").
- Scannable headings.
- Executive Summary must be usable alone in 2 minutes of reading.

## Length

- Match scope. A small architecture spike doesn't need a 20-page report.
- Section targets for typical scope:
  - Executive Summary ½–1 page
  - Ethos 1–2 pages
  - Landscape 2–4 pages
  - Signals 1–2 pages
  - Candidate Critiques variable (≈ 1 page per candidate)
  - Dispositions 1 page
  - Trade-offs 1 page
  - Follow-up Specs ½ page
  - References — as long as needed
- When in doubt, shorter. If a section isn't producing a decision, it's padding.
