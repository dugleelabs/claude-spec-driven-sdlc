---
name: spec-update-task
description: Mark a single task in the current spec's tasks.md as complete by flipping its checkbox from [ ] to [x]. Use when the user says "mark T-XX done", "complete the X task", "I finished X", or similar single-task completion phrasing. Do NOT use to update multiple tasks at once — handle those one at a time.
---

# spec-update-task

Mark one task complete in the active spec's `tasks.md`.

## Inputs to collect

- **Task identifier** — either a task ID (`T-A01`, `T-12`) or a description fragment ("create feature branch"). If missing, ask which task.

## Steps

1. Read the active spec name: `cat spec/.current-spec`.
2. Read `spec/<spec>/tasks.md`.
3. Locate the task:
   - If the input looks like a task ID (matches `T-[A-Z0-9]+`), find the matching `- [ ] **T-XX: ...**` line.
   - Otherwise, find the first incomplete task whose description contains the fragment (case-insensitive). If multiple match, ask which one.
4. Use Edit to change that line's `- [ ]` to `- [x]`. Preserve all other content exactly.
5. Recount progress: total tasks vs completed.
6. Report:
   - Which task was marked complete
   - Updated progress (`X/Y complete, NN%`)
   - Suggest the next incomplete task

## Notes

- Only update tasks in the spec repository. Implementation-side changes happen elsewhere.
- If the user is syncing to a tracker, remind them the `spec-sync` skill will propagate this change.
- Never mark a parent task done if any of its subtasks remain `[ ]` — surface that and ask.
