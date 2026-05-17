---
name: spec-approve
description: Mark a specification phase (requirements, design, research, or tasks) as approved — flips status from Draft to Approved and writes a phase-approval marker file. Use ONLY when the user explicitly approves a phase (e.g. "approve requirements", "looks good, approve the design", "approve tasks"). Do NOT infer approval from positive feedback alone.
---

# spec-approve

Mark a phase as approved for the active spec.

## Inputs to collect

- **Phase** — one of `requirements`, `design`, `research`, `tasks`. If the user did not specify, ask. Reject anything else with the valid list.

## Steps

1. Read active spec: `cat spec/.current-spec`.
2. Verify the phase file exists: `spec/<spec>/<phase>.md`. If not, tell the user the phase hasn't been drafted yet and stop.
3. Update `spec/<spec>/<phase>.md`:
   - Change any `Status: Draft` line to `Status: Approved`.
   - Check any approval checkboxes (e.g. `- [ ] Approved` → `- [x] Approved`).
   - Add or update an `Approved: <YYYY-MM-DD>` line (use today's date via `date +%Y-%m-%d`).
4. Write the marker file: `spec/<spec>/.<phase>-approved` (empty file is fine). This is what downstream skills check to gate progression.
5. Update `spec/<spec>/README.md`:
   - Tick the phase in the checklist (`- [ ]` → `- [x]`).
   - Update the "current phase" / "next step" line.
6. Report next steps based on phase:
   - **requirements approved** → feature spec: run `spec-design`. Research spec: run `spec-research`.
   - **design approved** → run `spec-tasks`.
   - **research approved** → no tasks phase. For each candidate classified as "pillar" or "feature-worth-pursuing" in `research.md`, run `spec-new` to create a follow-up spec.
   - **tasks approved** → run `spec-implement`. Optionally `spec-sync` to push to a tracker.

## Notes

- Do not edit any other phase files when approving one. Approval is scoped to the named phase.
- To apply pre-approval review feedback to a Draft phase doc, use `spec-revise` — it consumes the `spec-review` output file. Do not run `spec-revise` on an already-approved phase.
- If the user later asks to "un-approve" an approved phase, tell them to edit the file directly and remove the `.<phase>-approved` marker — there is no `spec-unapprove` skill.
