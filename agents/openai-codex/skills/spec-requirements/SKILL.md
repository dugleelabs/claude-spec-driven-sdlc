---
name: spec-requirements
description: Draft or revise the requirements.md document for the active specification — user stories, acceptance criteria, functional/non-functional requirements, constraints, success metrics, open questions. Use ONLY when the user explicitly asks to draft, write, or update requirements for the current spec (e.g. "write requirements", "draft the requirements doc", "let's spec out the requirements"). Requires an active spec; do NOT trigger during general feature discussion.
---

# spec-requirements

Author the requirements document for the active spec.

## Inputs to collect

- **Feature context** — what the feature does, the tech stack involved, and any relevant constraints. If the user did not give this, ask before writing. Do not invent context.

## Steps

1. Gather state:
   - `cat spec/.current-spec` — active spec
   - `ls spec/<spec>/` — what already exists
2. If `spec/<spec>/requirements.md` already exists:
   - Read it.
   - Surface the current content briefly and ask whether to revise specific sections or rewrite. Make targeted edits via Edit; do not rewrite blindly.
3. If it does NOT exist, draft `spec/<spec>/requirements.md` with these sections:
   - **Status** — `Draft` initially
   - **Feature Overview** — problem statement, goals (from the feature context)
   - **Current State brief** — restate the feature context verbatim so future readers see the framing
   - **User Stories** — each with acceptance criteria
   - **Functional Requirements** — prioritized P0/P1/P2, each with a unique ID like `F-01`
   - **Non-Functional Requirements** — performance, security, scalability, etc., each with an ID like `NF-01`
   - **Constraints & Assumptions**
   - **Out of Scope**
   - **Success Metrics** — measurable outcomes
   - **Open Questions** — unresolved items, each prefixed `OQ-XX`
4. If anything material is ambiguous (target users, success criteria, tech constraints), ASK before writing — do not invent.
5. After writing, tell the user:
   - Path to the file
   - Recommend running the `spec-review` skill with phase `requirements` for a self-audit
   - Then `spec-approve` with phase `requirements` when ready

## Quality bar

- Requirements must be testable and verifiable. Avoid "should", "might", "could" — use "must", "will".
- Each requirement carries a unique ID.
- Edge cases and error scenarios are explicit, not implied.
- Acceptance criteria belong with user stories, not in a separate floating list.

## Notes

- Use the Write tool to create the file. Use Edit for revisions to an existing file.
- Do not approve the phase from this skill. Approval is a separate, explicit user action via `spec-approve`.
