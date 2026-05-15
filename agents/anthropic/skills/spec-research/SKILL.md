---
name: spec-research
description: Author a research report (research.md) for specs whose deliverable is a decision, not code — competitive scans, roadmap research, strategy reviews, architecture spikes. Produces ethos pillars, candidate critiques, dispositions, and follow-up spec recommendations with rigorous sourcing. Use ONLY when the user explicitly asks for research after requirements are approved (e.g. "do the research", "write the research doc", "competitive scan", "evaluate candidates"). Use spec-design instead for code-producing feature specs.
---

# spec-research

Author a constructive, decision-enabling research report for the active spec.

## What this skill produces

A `research.md` for specs whose output is a decision, not implementation. Common variants:
- **Competitive scan** — map an existing market, find where we lead/trail
- **Roadmap research** — decide what to build next and why
- **Strategy review** — evaluate a direction against alternatives
- **Architecture spike** — compare approaches before committing

Research specs skip `spec-tasks` and `spec-implement`. The handoff to implementation is a list of follow-up specs (via `spec-new`).

## Inputs to collect

- **Research topic** — focus area or question (e.g. "small-model tool-calling patterns", "competitor auth approaches"). If the user did not give one, ask.

## Step 1 — Preconditions

1. Read active spec: `cat spec/.current-spec`.
2. Verify requirements approved: check `spec/<spec>/.requirements-approved` exists. If not, tell the user to run `spec-approve` with phase `requirements` first, then stop.
3. Read `spec/<spec>/requirements.md` fully. Extract:
   - Vision, problem statement, goals
   - Candidate list (from Open Questions resolution or elsewhere)
   - Functional (F-XX) and non-functional (NF-XX) requirements — the rubric inputs
   - Any mandated dimensions (pricing, licensing, accessibility, security, etc.) that must appear in the matrix
   - Any explicit drops / non-goals — respect them unless research materially contradicts them
4. If requirements are missing any of the above, write with what's there and flag the gap in Open Questions. Do not invent inputs.

## Step 2 — Gather evidence

Use WebSearch and WebFetch to collect primary sources. Target a mix:
- **Official sources** — product docs, changelogs, pricing pages, release notes, repo READMEs
- **User voice** — Reddit, HN, GitHub issues/discussions, blogs, third-party reviews
- **Signals of weight** — upvotes, comment counts, frequency of the same ask across forums, thread age

**Sourcing rules:**
- Every non-trivial factual claim cites a primary source inline as `[anchor text](url)` at the point of the claim. Not a trailing footnote.
- Unsourceable claims are flagged `[unsourced — verify]` or removed.
- Do not rely on training data for facts likely to have changed (pricing, features, versions, team structure).
- If a competitor has no public changelog, say so — don't fabricate.

## Step 3 — Write research.md

Create `spec/<spec>/research.md` (sibling to `requirements.md`; NOT `design.md`).

The 10-section structure, quality rules, and section-by-section guidance live in `references/research-structure.md` and `references/quality-rules.md`. Read those before drafting. Never skip Executive Summary, Ethos, Candidate Critiques, Dispositions, or References.

## Step 4 — Post-write summary

After writing, report:
- Number of sources cited (roughly)
- Number of actors / products in the landscape
- Number of signal clusters identified
- Candidates critiqued (split: from requirements / surfaced by research)
- Disposition distribution: X pillars, Y features, Z deferred, W dropped
- Follow-up specs recommended (count)
- Any Open Questions flagged for user resolution

Then recommend:
- `spec-review` with phase `research` for a self-audit
- `spec-approve` with phase `research` when ready
- After approval, run `spec-new` for each surviving candidate

## Iteration

Research is iterative. On rerun:
- Preserve the existing `research.md` structure
- Update evidence and dispositions in place
- Add a `### Changelog` appendix at the bottom (date, what changed, why)
- If rerun reveals the original requirements are wrong, do NOT reshape research to match — flag in Open Questions and let the user decide

## Files

- `references/research-structure.md` — the 10-section template, in full, with per-section formatting
- `references/quality-rules.md` — sourcing, analytical rigor, bias awareness, readability, length
