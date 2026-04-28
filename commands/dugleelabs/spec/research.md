---
allowed-tools: Bash(ls:*), Read, Write, Glob, WebSearch, WebFetch
description: Create a research specification — produces a constructive, decision-enabling report (competitive analysis, ethos, candidate critiques, dispositions)
args:
  - name: research_topic
    description: "The research focus area or question (e.g. 'small model tool-calling patterns' or 'competitor auth approaches')"
    required: true
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

Research topic: {{research_topic}}

## Your Task

This command produces a **research document** for specs whose deliverable is a **decision, not code**. Typical variants:

- **Competitive scan** — map an existing market, find where we lead/trail
- **Roadmap research** — decide what to build next and why
- **Strategy review** — evaluate a direction against alternatives
- **Architecture spike** — compare approaches before committing to one

Research specs skip `/dugleelabs:spec:tasks` and `/dugleelabs:spec:implement`. The handoff to implementation is a list of **follow-up specs** the research recommends creating via `/dugleelabs:spec:new`.

The goal of this command is not a bibliography — it is a **usable report**. A reader should be able to act on the findings without reading the whole document. Every section must produce something decision-enabling, not just descriptive.

---

### Step 1 — Preconditions

1. Read the current spec name from `spec/.current-spec`.
2. Read the spec's `README.md` to verify the requirements phase is approved. If not, tell the user to run `/dugleelabs:spec:approve requirements` first and stop.
3. Read `requirements.md` fully. Extract:
   - Vision / Problem statement / Goals — these frame what "good" looks like
   - Candidate list (from Open Questions resolution or elsewhere)
   - Functional requirements (F-XX) and non-functional requirements (NF-XX) — these are the rubric inputs
   - Any mandated dimensions (e.g. pricing axis, licensing axis, accessibility axis, security axis) that must appear in the matrix
   - Any explicit drops or non-goals — respect them unless research materially contradicts them
4. If the requirements spec is missing any of the above, write the report with what's there and flag the gap in the Open Questions section. Do not invent inputs.

---

### Step 2 — Gather evidence

Use `WebSearch` and `WebFetch` to collect primary sources. Target a mix:

- **Official sources** — product docs, changelogs, pricing pages, release notes, repo READMEs
- **User voice** — Reddit threads, Hacker News discussions, GitHub issues/discussions, blog posts, third-party reviews
- **Signals of weight** — upvotes, comment counts, frequency of the same ask across forums, age of the thread

Rules:

- Every non-trivial factual claim must cite a primary source inline.
- Cite in `[anchor text](url)` format at the point of the claim, not as a trailing footnote.
- If a claim can't be sourced, either remove it or flag it as `[unsourced — verify]`.
- Do not rely on LLM training data for facts that have likely changed since the model was trained (pricing, features, version numbers, team structure).
- Acknowledge gaps: if a competitor has no public changelog, say so rather than fabricating one.

---

### Step 3 — Write `research.md`

Create `research.md` in the current spec directory (sibling to `requirements.md`; do **not** use `design.md` — that's for code-bearing specs). The structure below is the standard shape. Tighten or omit sections when the spec's scope doesn't need them, but never skip the Executive Summary, Ethos, Candidate Critiques, Dispositions, or References.

#### 1. Executive Summary (≈ 1/2 to 1 page — standalone-readable)

A reader must be able to act on this section alone. Include:

- **TL;DR** — 3-5 bullets summarising the most consequential findings
- **Ethos pillars** — names only, one line each
- **Disposition headline** — "X pillars identified, Y features worth pursuing, Z deferred, W dropped"
- **Follow-up specs recommended** — names only, one per line
- **Headline tensions** — any unresolved trade-offs the reader should know before diving in

This section is the report's front door. Write it last, but place it first.

#### 2. Ethos / Strategic Pillars

The yardstick every candidate is measured against. Derive pillars from the requirements spec's Vision/Goals, not from the candidate list.

For each pillar:

- **Name** (short, memorable)
- **Definition** (one line)
- **What this means in practice** (one paragraph — give concrete examples of decisions the pillar would shape)
- **How it distinguishes us** (one line — reference catalogued competitors, not generic values)

Then, **anti-pillars** — what the project deliberately will NOT become. For each anti-pillar:

- Definition (one line)
- Specific behaviours/features it rules out (not vibes — concrete examples)
- Why (tied to a pillar or ethos commitment)

Pillars fail the test if they're interchangeable with any competitor's marketing copy. Push until they're genuinely distinguishing.

#### 3. Competitive / Environmental Landscape

Shape of the space we're operating in. Two deliverables:

**a) Matrix** — every actor mapped across consistent dimensions. Pull the dimensions from requirements (model/tool support, pricing/license, IDE/terminal, unique differentiators) plus any axes the vision adds (e.g. cloud-locked vs local-capable, data residency, accessibility). Every cell is a judgment, not a copy-paste from marketing.

**b) Per-actor commentary** — one paragraph each. Lead with differentiation vs the pillars. Not a description of the product; a judgment on where it threatens us, where we threaten it, and where we simply aren't competing.

End with a **Gaps** subsection: what's missing in the landscape that we could own.

#### 4. Community / User Signals

Counter-weight to assumption-driven design. Structure:

- **Signal clusters** — group asks into themes (e.g. "users want offline workflows," "users complain about cost at scale"). Do not produce a flat list of individual threads.
- **Weight per cluster** — very-frequent-repeated ask vs one-off gripe. Treat them differently.
- **Source diversity** — signals from Reddit, HN, GitHub, and blogs each have different demographics. Note which clusters come from which sources.
- **Sample limitations** — explicitly acknowledge what this sample is NOT representative of (e.g. enterprise procurement signals are absent from Reddit).
- **Signals that contradict us** — surface user asks that push against the project's current direction. These are the most valuable.

Cite every signal inline.

#### 5. Candidate Critiques

Apply the rubric uniformly. Every candidate receives the same axes, evaluated the same way.

**Rubric axes** — pull from requirements F-XX. Common baseline:

- Ethos alignment — how this candidate reinforces or conflicts with each pillar
- User impact — who benefits, by how much, what we can source as evidence
- Competitive differentiation — does this widen or close a gap the landscape identified
- Open questions / risks — what we genuinely don't know
- Any domain-specific axes from the vision (e.g. local-model impact, privacy impact, cost-to-user impact)

**Format per candidate:**

```
### Candidate: <name>

**Description.** One paragraph on what it is.

**Evidence.** What the landscape and signals say about demand / precedent / risk. Cite.

**Evaluation.**
- Ethos alignment: <one sentence per pillar>
- User impact: <who, how much, cited evidence>
- Competitive differentiation: <widens/closes which gap>
- <Domain-specific axis>: <judgment>
- Open questions / risks: <list>

**Dependencies.** Does this candidate only make sense if another candidate ships too? Is it blocked by something?
```

**Research-surfaced candidates** — if the evidence reveals a candidate the requirements spec didn't list, add it here with an `[added by research]` tag. Do not silently expand scope; the reader must see that the candidate pool grew.

**Requirements-contradicted findings** — if research reveals a requirement-level assumption is wrong, do not silently reshape the research around it. Add a note in the candidate critique AND flag it in Open Questions.

#### 6. Dispositions

The decision. One classification per candidate, in a flat table:

| Candidate | Disposition | Rationale | Follow-up spec? |
|---|---|---|---|
| <name> | pillar / feature-worth-pursuing / deferred / dropped | 1-2 sentences tying the classification back to pillars and/or signals | name for `/dugleelabs:spec:new <name>` (or — if deferred/dropped) |

Rules:

- **No silent rejections.** Every candidate, including deferred and dropped, has a rationale equal in rigor to pursued ones.
- **Deferred ≠ dropped.** Deferred means "revisit under what trigger" — state the trigger. Dropped means "won't do, won't revisit" — state why not.
- **No effort, no timelines.** Scoping belongs to the follow-up specs.
- **Respect user-declared drops** from the requirements spec unless research materially contradicts them. If contradicted, resurface the candidate with the contradicting evidence and propose the reader reconsiders — don't unilaterally un-drop.

#### 7. Taxonomy / Definitions (include only if requirements call for distinctions)

Formalise distinctions the requirements spec asked for — e.g. Roadmap vs Features, core vs plugin, community vs commercial, pillar vs concrete deliverable. Include mapping rules so future work has no ambiguity. Skip this section if the spec doesn't need it.

#### 8. Trade-offs & Open Questions

Surface what the research could NOT resolve. Two kinds:

- **Genuine trade-offs** — mutually exclusive or tension-bearing choices (e.g. "local-first simplicity vs team-sharing power"). Frame them as trade-offs, not false binaries.
- **Open questions** — things research couldn't answer and the project must still decide. Prefix with OQ-XX so they're referenceable.

This section's purpose: prevent false confidence. If the whole report sounds certain, it's lying.

#### 9. Follow-up Specs

Handoff to implementation. For each candidate classified as "pillar" or "feature-worth-pursuing":

- Proposed spec name (lowercase, hyphen-separated, suitable for `/dugleelabs:spec:new <name>`)
- One-line scope note — what a follow-up spec covers
- Recommended order if dependencies exist; otherwise note "no inherent order"

This is the only place sequencing appears — and only at the level of "X depends on Y," not "ship in week 3."

#### 10. References

Consolidated, deduplicated source list. Organise by whichever dimension reads best (tier, topic, alphabetical). Every URL cited inline must appear here; nothing appears here that isn't cited inline.

---

### Quality rules

**Sourcing.** Every non-trivial factual claim cites a primary source inline. Unsourceable claims are flagged, not stated.

**Analytical rigor.**

- Same rubric for every candidate — no cherry-picking axes for preferred ideas.
- Pillars must be distinguishing vs catalogued competitors, not generic values.
- Anti-pillars must rule out specific behaviours, not vibes.
- Evidence, interpretation, and recommendation must be separable. A reader should be able to disagree with your interpretation while accepting your evidence.

**Bias awareness.**

- Acknowledge the project's own weaknesses — where it trails, where it's at parity. Do not only surface strengths.
- Surface counter-evidence to preferred conclusions when it exists.
- Flag subjective judgment separately from sourced signal. Phrases like "in my judgment" / "based on signals alone" are not weakness — they are calibration.
- User-declared preferences in the requirements spec are **input, not finding**. Don't treat the user's gut-feel ranking as research output.

**Readability.**

- Lead with the finding, then the evidence. Inverted pyramid.
- Tables for comparisons, prose for judgments.
- No filler ("it's important to note," "in conclusion," "as we can see").
- Scannable headings.
- Executive Summary must be usable alone in 2 minutes of reading.

**Length.**

- Match scope. A small architecture spike doesn't need a 20-page report.
- Section targets for typical scope: Executive Summary 1/2-1 page; Ethos 1-2 pages; Landscape 2-4 pages; Signals 1-2 pages; Candidate Critiques variable (≈ 1 page per candidate); Dispositions 1 page; Trade-offs 1 page; Follow-up Specs 1/2 page; References — as long as needed.
- When in doubt, shorter. If a section isn't producing a decision, it's padding.

---

### Step 4 — Post-write summary to the user

After writing `research.md`, report back with:

- Number of sources cited (roughly)
- Number of actors/products catalogued in the landscape
- Number of signal clusters identified
- Number of candidates critiqued (split: from requirements / surfaced by research)
- Disposition distribution: X pillars, Y features, Z deferred, W dropped
- Count of follow-up specs recommended
- Any Open Questions flagged for user resolution

Then prompt: next step is `/dugleelabs:spec:review research` to self-audit against the Research Review Checklist, then `/dugleelabs:spec:approve research` when ready. After approval, create follow-up specs via `/dugleelabs:spec:new <name>` for each surviving candidate — the research is done, implementation specs take over.

---

### Iteration

Research is iterative. If the user reruns this command, preserve the existing `research.md` structure, update the evidence and dispositions in place, and note what changed in a `### Changelog` appendix at the bottom (date, what was added/revised, and why — e.g. "new signal cluster surfaced after Reddit thread X"). Don't silently rewrite.

If rerunning reveals the original requirements are wrong, do not reshape the research to match. Flag the contradiction in Open Questions and let the user decide whether to amend requirements.
