---
name: spec-revise
description: Apply the fixes from a spec-review output file to the corresponding phase document (requirements, design, research, or tasks) — edits the phase doc, bumps its Revision/Updated header, and checks off resolved issues in the review file. Use ONLY when the user explicitly asks to revise, apply review fixes, or address review feedback for a phase doc (e.g. "revise requirements", "apply the design review", "address the review feedback", "fix the issues from the review"). Requires a review file produced by spec-review at spec/<spec>/reviews/<phase>-review.md.
---

# spec-revise

Apply the fixes recorded in a `spec-review` output file to its phase document, then mark the resolved issues as done in the review file.

## Inputs to collect

- **Phase** — one of `requirements`, `design`, `research`, `tasks`. If missing or invalid, list the valid options and ask.

## Step 1 — Locate the review file

1. Read active spec: `cat spec/.current-spec`.
2. Look for `spec/<spec>/reviews/<phase>-review.md`.
   - If it does NOT exist, stop and tell the user to run `spec-review` with phase `<phase>` first.
3. Also list `spec/<spec>/reviews/` for any other files matching `<phase>-review*.md` (e.g. archived `<phase>-review-2026-05-01.md`):
   - If exactly one review file is present, use it.
   - If more than one is present, list all candidates with their modified timestamps, recommend the most recently modified, and ask the user which one to apply. Do not proceed silently.
4. Verify the phase doc exists at `spec/<spec>/<phase>.md`. If not, stop.

## Step 2 — Parse the review file

Read the chosen review file and extract:

- The verdict line.
- Every unchecked issue (`- [ ] **R-XX** — …`). Capture the ID, severity bucket (P0/P1/P2), reference, and fix text.
- Already-checked issues (`- [x] **R-XX** — …`) are skipped — they were resolved in a prior revise cycle.

If every issue is already checked, tell the user there is nothing to revise and suggest re-running `spec-review` (the phase doc may have changed since the last review).

## Step 3 — Choose the revise mode

Ask the user, in one short message:

> The review has `<N>` open issues (`<P0 count>` P0, `<P1 count>` P1, `<P2 count>` P2). Apply all P0/P1 fixes in one pass, or walk through each issue with you?

Wait for the answer. The two modes:

- **Apply all** — work through every open P0 and P1 issue, editing the phase doc as you go. Skip P2 unless the user said to include them.
- **Walk through** — for each open issue (P0 → P1 → P2), propose the exact edit, wait for `yes` / `no` / `skip` before applying. `skip` leaves the issue unchecked in the review file.

## Step 4 — Apply fixes to the phase doc

For each issue you are applying:

1. Re-read the relevant section of `spec/<spec>/<phase>.md` (line numbers in the review may have shifted as prior fixes landed).
2. Use the Edit tool to apply the concrete fix described by the issue. Keep the change scoped to what the issue calls for — do not refactor surrounding content.
3. If the fix is ambiguous or the referenced location no longer exists, do NOT guess: leave the issue unchecked and note it for the final summary.

## Step 5 — Bump the phase doc's Revision header

Add or update a revision header at the top of `spec/<spec>/<phase>.md`, immediately after the H1 title and before the `Status` line if present.

Header format (single line):

```
**Revision:** <N> · **Updated:** YYYY-MM-DD
```

Rules:

- If no header exists, insert it (start at `Revision: 1`).
- If a header exists, increment `<N>` by 1 and set `Updated` to today's date.
- If you applied zero fixes (everything was skipped), do NOT bump the header.

## Step 6 — Check off resolved issues in the review file

For each issue you successfully applied:

- Flip `- [ ]` to `- [x]` on its line.
- Append ` _(resolved in revision <N> on YYYY-MM-DD)_` to the end of the line, where `<N>` is the new revision number from Step 5.

Issues you skipped or could not safely apply stay as `- [ ]` so the next revise cycle (or the user) can finish them.

## Step 7 — Reply to the user

Target **120–200 words**. Structure:

1. **Revision** — e.g. "Revision 1 → 2"
2. **Applied** — count + bullets listing each `R-XX` that was resolved, one line each
3. **Skipped / deferred** — any open issues left, with one-line reasons
4. **Files touched** — phase doc path + review file path
5. **Next step** — recommend `Run spec-review with phase <phase>` if any P0/P1 remain, or `Run spec-approve with phase <phase>` if the review was Ready or all blocking issues are now resolved

## Notes

- Edit, don't rewrite. Use the Edit tool to apply targeted changes; do not regenerate the phase doc.
- The review file is the source of truth for the fix list. Always update its checkboxes — never silently apply a fix without flipping its checkbox.
- Do not approve the phase from this skill. Approval stays an explicit user action via `spec-approve`.
- If the review file's verdict was `Ready`, there should be no open issues; stop and point the user at `spec-approve`.
