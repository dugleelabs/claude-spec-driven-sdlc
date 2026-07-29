---
name: spec-requirements
description: Draft or revise the requirements.md document for the active specification — user stories, acceptance criteria, functional/non-functional requirements, constraints, success metrics, open questions. Use ONLY when the user explicitly asks to draft, write, or update requirements for the current spec (e.g. "write requirements", "draft the requirements doc", "let's spec out the requirements"). Requires an active spec; do NOT trigger during general feature discussion.
---

# spec-requirements

Author the requirements document for the active spec. Act as a senior requirements analyst: ground every statement in evidence — from the user, the repo, or research — never in invention.

## Operating principles

- **Investigate before asking.** Answer what you can from the repo, existing spec docs, and quick research. Ask the user only what you genuinely cannot determine yourself.
- **Ask informed questions, in one batch.** When input is needed, ask at most 3–5 focused questions in a single message. Where a question has a known option space (auth methods, storage choices, delivery targets), present 2–3 concrete options with a recommended default so the user can answer in a word.
- **MVP first.** Scope P0 to the smallest version that delivers the core value. Everything else is P1/P2 or a future iteration. Do not gold-plate.
- **Plain professional language.** Write for a reader joining the project cold: complete sentences, defined terms, no cryptic shorthand, no filler.

## Step 1 — Load state

1. `cat spec/.current-spec` — active spec. If missing, tell the user to run `spec-new` or `spec-switch`, then stop.
2. `ls spec/<spec>/` — see what already exists.
3. Read `spec/<spec>/README.md` for the spec's stated intent and type (feature vs research).

## Step 2 — Discover context

Build your own picture before asking the user anything:

1. **Explore the codebase.** If this repo contains code, or the feature targets other repos the user has named, inspect them: README, dependency manifests, directory layout, modules related to this feature, existing test setup. This grounds the Context section in facts, not guesses.
2. **Research externals.** If the feature involves third-party services, protocols, or libraries whose current capabilities matter (API surface, pricing, limits, maturity), do a quick web check before framing questions — so your questions offer real options, not blanks.
3. **List remaining unknowns.** Note the material gaps only the user can close: target users, success criteria, hard constraints, must-have vs nice-to-have.

## Step 3 — Close the gaps

If material gaps remain, ask them now — one batched message, informed by Step 2, with options and a recommended default wherever possible. Wait for answers before writing. If nothing material is missing, state what you inferred and proceed.

## Step 4 — Write or revise requirements.md

If `spec/<spec>/requirements.md` exists: read it, summarize its current state in 2–3 sentences, and ask whether to revise specific sections or rewrite. Apply targeted Edits — do not rewrite blindly.

If it does not exist, create it with this structure:

- **Header** — `# Requirements — <spec-id>` followed by `**Status:** Draft · **Created:** <YYYY-MM-DD>`
- **Summary** — 3–5 sentences: the problem, who has it, and what the MVP delivers. Write it last, place it first.
- **Context & Current State** — what exists today, grounded in Step 2 findings: stack, relevant modules (cite file paths where useful), integrations, prior art.
- **Goals & Non-Goals** — short bullets. Non-goals are the first defense against scope creep.
- **User Stories** — `US-01`, `US-02`, … each with acceptance criteria attached (Given/When/Then where it fits naturally).
- **Functional Requirements** — `F-01`, `F-02`, … each prioritized P0/P1/P2. P0 = MVP-blocking; the P0 set alone must describe a shippable product.
- **Non-Functional Requirements** — `NF-01`, … Only the dimensions that genuinely matter for this feature, each with a concrete, MVP-realistic value ("p95 < 300 ms", "no plaintext credentials at rest") — not aspirational boilerplate.
- **Constraints & Assumptions** — technical, organizational, timeline. Mark assumptions the user has not confirmed.
- **Out of Scope & Future Iterations** — capabilities deliberately deferred, each with a one-line reason. Deferring here is how MVP stays small without losing ideas.
- **Success Metrics** — measurable outcomes that tell you the feature worked.
- **Open Questions** — `OQ-01`, … each with what unblocks it and who decides.

## Quality bar

- Every requirement is testable, uniquely identified, and uses "must"/"will" — never "should", "might", "could".
- Edge cases and error scenarios are explicit, not implied.
- No requirement exists only to sound thorough — if it doesn't change what gets built, cut it.
- Acceptance criteria live with their user story, not in a separate floating list.
- The document reads top-to-bottom as a coherent narrative, not a form filled in.

## Step 5 — Hand off

Report to the user:

- Path to the file and a one-line summary of scope (counts: stories, P0/P1/P2 requirements, open questions).
- Any Open Questions that need their decision.
- Recommend `spec-review` with phase `requirements` for a self-audit, then `spec-approve` with phase `requirements` when ready.

## Notes

- Use Write for creation, Edit for revisions.
- Do not approve the phase from this skill. Approval is a separate, explicit user action via `spec-approve`.
