---
name: spec-tasks
description: Decompose an approved design into an actionable, phased task list (tasks.md) with checkboxes, dependencies, and risk-mitigation tasks. Use ONLY when the user explicitly asks to generate tasks, break down work, or create the task list after design is approved (e.g. "generate tasks", "break this down", "create the task breakdown"). Research specs skip this skill.
---

# spec-tasks

Author the implementation task list for the active spec.

## Preconditions

1. Read active spec: `cat spec/.current-spec`.
2. Verify design is approved: check that `spec/<spec>/.design-approved` exists.
   - If not, tell the user: "Design is not approved. Run the `spec-approve` skill with phase `design` first." Then stop.
3. Read `spec/<spec>/requirements.md` and `spec/<spec>/design.md` fully.

## Steps

1. If `spec/<spec>/tasks.md` already exists, read it and make targeted edits. Do not rewrite blindly.
2. If it does not exist, create `spec/<spec>/tasks.md` with:
   - **Status** — `Draft`
   - **Overview** — rough time estimate, scope summary
   - **Phase breakdown** — typically: `Foundation`, `Core`, `Testing`, `Deployment`. Adjust to fit the work.
   - **Task list** — checkboxes for parents AND subtasks
   - **Dependencies** — which tasks block which
   - **Risk mitigation tasks** — surfaced from design risks
3. If scoping, phasing, or sequencing priorities are unclear, ASK before writing.

## Task formatting (strict)

Parent tasks:
```
- [ ] **T-01: Short imperative task title**
```

Subtasks (indented, also checkboxes — required for tracker sync):
```
- [ ] **T-01: Create script directory structure**
  - [ ] Create github directory
  - [ ] Create linear directory
```

Do NOT use plain-text bullets (`- text`) for subtasks. The `spec-sync` skill parses checkbox state.

Phase headers:
```
## Phase 1: Foundation
## Phase 2: Core
```

## Quality bar

- Every requirement (F-XX, NF-XX) maps to at least one task.
- Every design component has an implementation task.
- Testing tasks exist for each phase, not just at the end.
- Documentation tasks (API docs, README) are explicit.
- Tasks are sized to be completable in a single sitting — not "build the whole thing".
- Each task has a clear done criterion.

## Steps after writing

- Recommend `spec-review` with phase `tasks` for a self-audit.
- Recommend `spec-approve` with phase `tasks` when ready.
- Then `spec-implement` to begin work.
