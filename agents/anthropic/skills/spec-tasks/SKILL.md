---
name: spec-tasks
description: Decompose an approved design into an actionable, phased task list (tasks.md) with checkboxes, dependencies, and risk-mitigation tasks. Use ONLY when the user explicitly asks to generate tasks, break down work, or create the task list after design is approved (e.g. "generate tasks", "break this down", "create the task breakdown"). Research specs skip this skill.
---

# spec-tasks

Author the implementation task list for the active spec. Act as a senior tech lead planning delivery: every task traces to a requirement or design element, and every phase ends with something that runs.

## Operating principles

- **Investigate before asking.** Sizing and sequencing questions are usually answerable from the design and the target codebase. Ask the user only about genuine priority calls (e.g. which P1s make the first release).
- **MVP first.** Phase 1 ends in a walking skeleton — the thinnest end-to-end slice that runs. Later phases layer capability onto something already working. Never plan a big-bang integration at the end.
- **Test as you go.** Testing tasks live inside each phase next to the code they verify — not in a trailing "Testing" phase.

## Step 1 — Preconditions

1. Read active spec: `cat spec/.current-spec`.
2. Verify design is approved: `spec/<spec>/.design-approved` exists. If not, tell the user: "Design is not approved. Run the `spec-approve` skill with phase `design` first." Then stop.
3. Read `spec/<spec>/requirements.md` and `spec/<spec>/design.md` fully.
4. If needed, skim the target codebase enough to size tasks realistically (what exists vs what must be built).

## Step 2 — Write or revise tasks.md

If `spec/<spec>/tasks.md` exists: read it and apply targeted Edits — do not rewrite blindly.

If it does not exist, create it with this structure:

- **Header** — `# Tasks — <spec-id>` followed by `**Status:** Draft · **Created:** <YYYY-MM-DD>`
- **Overview** — scope summary, phase count, and the sizing legend: `S` (under an hour), `M` (one focused sitting). If a task feels like `L`, split it before writing it down.
- **Phases** — Phase 1 delivers the walking skeleton; each subsequent phase ends with something demonstrable. Typical arc: Foundation → Core → Hardening → Release; adjust to fit the work.
- **Dependencies** — which tasks block which, only where non-obvious from order.
- **Traceability** — a table mapping every `F-XX` and `NF-XX` to the task IDs that implement and verify it. An unmapped requirement is a gap — fix it before finishing the doc.
- **Risk mitigation** — a task for each design risk that needs active mitigation, placed in the earliest phase where it can be addressed.

## Task formatting (strict — spec-sync parses this)

Parent tasks:
```
- [ ] **T-01: Short imperative task title** _(S)_
```

Subtasks (indented, also checkboxes — required for tracker sync):
```
- [ ] **T-01: Create script directory structure** _(M)_
  - [ ] Create github directory
  - [ ] Create linear directory
```

Do NOT use plain-text bullets (`- text`) for subtasks. Phase headers:
```
## Phase 1: Foundation
## Phase 2: Core
```

Under each parent task, add a `Done when:` line stating the observable completion criterion (e.g. `Done when: POST /auth/login returns a JWT for valid credentials and 401 otherwise`). Where known, note the files or area touched.

## Quality bar

- Every requirement (F-XX, NF-XX) maps to at least one task; every design component has an implementation task.
- Every task traces to a requirement, a design element, or engineering hygiene (tests, docs, release) — nothing exists "just in case".
- Tasks are completable in a single sitting with a clear, observable done criterion.
- Documentation tasks (API docs, README updates) are explicit, not assumed.
- Phase 1 alone, completed, produces something a user or reviewer can run.

## Step 3 — Hand off

Report the file path and counts (phases, tasks, coverage: X/Y requirements mapped). Then recommend:

- `spec-review` with phase `tasks` for a self-audit
- `spec-approve` with phase `tasks` when ready
- Then `spec-implement` to begin work
