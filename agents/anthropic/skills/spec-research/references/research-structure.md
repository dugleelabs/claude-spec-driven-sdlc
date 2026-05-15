# research.md — 10-section structure

The standard shape. Tighten or omit sections when scope doesn't need them, but **never** skip: Executive Summary, Ethos, Candidate Critiques, Dispositions, References.

The goal is a **usable report**, not a bibliography. Every section produces something decision-enabling, not just descriptive.

---

## 1. Executive Summary (≈ ½–1 page — standalone-readable)

A reader must be able to act on this section alone. Include:

- **TL;DR** — 3–5 bullets summarising the most consequential findings
- **Ethos pillars** — names only, one line each
- **Disposition headline** — "X pillars identified, Y features worth pursuing, Z deferred, W dropped"
- **Follow-up specs recommended** — names only, one per line
- **Headline tensions** — any unresolved trade-offs the reader should know before diving in

Write it last, place it first.

## 2. Ethos / Strategic Pillars

The yardstick every candidate is measured against. Derive pillars from the requirements spec's Vision/Goals, not from the candidate list.

For each pillar:
- **Name** (short, memorable)
- **Definition** (one line)
- **What this means in practice** (one paragraph — give concrete examples of decisions the pillar would shape)
- **How it distinguishes us** (one line — reference catalogued competitors, not generic values)

Then, **anti-pillars** — what the project deliberately will NOT become. For each:
- Definition (one line)
- Specific behaviours/features it rules out (concrete, not vibes)
- Why (tied to a pillar or ethos commitment)

Pillars fail the test if they're interchangeable with any competitor's marketing copy. Push until they're genuinely distinguishing.

## 3. Competitive / Environmental Landscape

Shape of the space we're operating in. Two deliverables:

**a) Matrix** — every actor mapped across consistent dimensions. Pull dimensions from requirements (model/tool support, pricing/license, IDE/terminal, unique differentiators) plus any axes the vision adds (e.g. cloud-locked vs local-capable, data residency, accessibility). Every cell is a judgment, not a copy-paste from marketing.

**b) Per-actor commentary** — one paragraph each. Lead with differentiation vs the pillars. Not a description of the product; a judgment on where it threatens us, where we threaten it, and where we simply aren't competing.

End with a **Gaps** subsection: what's missing in the landscape that we could own.

## 4. Community / User Signals

Counter-weight to assumption-driven design. Structure:

- **Signal clusters** — group asks into themes (e.g. "users want offline workflows", "users complain about cost at scale"). NOT a flat list of individual threads.
- **Weight per cluster** — very-frequent-repeated ask vs one-off gripe. Treat them differently.
- **Source diversity** — signals from Reddit, HN, GitHub, and blogs each have different demographics. Note which clusters come from which sources.
- **Sample limitations** — explicitly acknowledge what this sample is NOT representative of (e.g. enterprise procurement signals are absent from Reddit).
- **Signals that contradict us** — surface user asks that push against the project's current direction. These are the most valuable.

Cite every signal inline.

## 5. Candidate Critiques

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

**Research-surfaced candidates** — if the evidence reveals a candidate the requirements spec didn't list, add it here with an `[added by research]` tag. Do not silently expand scope.

**Requirements-contradicted findings** — if research reveals a requirement-level assumption is wrong, do not silently reshape the research around it. Add a note in the candidate critique AND flag it in Open Questions.

## 6. Dispositions

The decision. One classification per candidate, in a flat table:

| Candidate | Disposition | Rationale | Follow-up spec? |
|---|---|---|---|
| <name> | pillar / feature-worth-pursuing / deferred / dropped | 1–2 sentences tying the classification back to pillars and/or signals | name for `spec-new <name>` (or — if deferred/dropped) |

**Rules:**
- **No silent rejections.** Every candidate, including deferred and dropped, has a rationale equal in rigor to pursued ones.
- **Deferred ≠ dropped.** Deferred means "revisit under what trigger" — state the trigger. Dropped means "won't do, won't revisit" — state why not.
- **No effort, no timelines.** Scoping belongs to follow-up specs.
- **Respect user-declared drops** from requirements unless research materially contradicts them. If contradicted, resurface the candidate with the contradicting evidence and propose the reader reconsiders — don't unilaterally un-drop.

## 7. Taxonomy / Definitions (include only if requirements call for distinctions)

Formalise distinctions the requirements spec asked for — e.g. Roadmap vs Features, core vs plugin, community vs commercial, pillar vs concrete deliverable. Include mapping rules so future work has no ambiguity. Skip if not needed.

## 8. Trade-offs & Open Questions

Surface what the research could NOT resolve. Two kinds:
- **Genuine trade-offs** — mutually exclusive or tension-bearing choices (e.g. "local-first simplicity vs team-sharing power"). Frame as trade-offs, not false binaries.
- **Open questions** — things research couldn't answer and the project must still decide. Prefix with `OQ-XX` so they're referenceable.

Purpose: prevent false confidence. If the whole report sounds certain, it's lying.

## 9. Follow-up Specs

Handoff to implementation. For each candidate classified "pillar" or "feature-worth-pursuing":
- Proposed spec name (lowercase, hyphen-separated, suitable for `spec-new <name>`)
- One-line scope note — what a follow-up spec covers
- Recommended order if dependencies exist; otherwise note "no inherent order"

This is the only place sequencing appears — and only at the level of "X depends on Y", not "ship in week 3".

## 10. References

Consolidated, deduplicated source list. Organise by whichever dimension reads best (tier, topic, alphabetical). Every URL cited inline must appear here; nothing appears here that isn't cited inline.
