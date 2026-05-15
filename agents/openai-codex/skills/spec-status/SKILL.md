---
name: spec-status
description: Report the status of all specifications in spec/ — which phases are complete, which is active, and what the recommended next action is. Use when the user asks "what's the status of specs", "show me all specs", "where are we", "what spec am I on", or similar overview questions.
---

# spec-status

Summarize all specifications and their progress.

## Steps

1. List all spec directories: `ls -d spec/*/ 2>/dev/null` (or `find spec -maxdepth 1 -mindepth 1 -type d`).
2. Read `spec/.current-spec` to identify the active spec.
3. For each spec directory:
   - Read `README.md` for the phase checklist and overall status.
   - Check which phase files exist: `requirements.md`, `design.md`, `research.md`, `tasks.md`.
   - Check for approval markers: `.requirements-approved`, `.design-approved`, `.research-approved`, `.tasks-approved`.
   - If `tasks.md` exists, count `- [x]` vs `- [ ]` checkboxes for progress %.
4. Render a table or structured list:
   - Spec ID and name
   - Mark the active spec (e.g. `★`)
   - Phase progression: `Requirements ✓ → Design ✓ → Tasks ◻ → Implementation ◻`
   - For specs with tasks underway, show `X/Y tasks complete (NN%)`
5. End with a recommended next action for the active spec — derived from where it is in the workflow.

## Notes

- This skill is read-only. Do not edit any files.
- Keep output scannable. Use a table when there are >2 specs; bullets otherwise.
- Distinguish feature specs (have `design.md`) from research specs (have `research.md`).
