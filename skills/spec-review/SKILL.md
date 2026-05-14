---
name: spec-review
description: Self-audit a specification phase document (requirements, design, research, or tasks) against a phase-specific checklist and return a Ready / Needs Work / Major Issues verdict with top issues and a recommended next step. Use ONLY when the user explicitly asks to review, audit, or check a phase doc (e.g. "review the design", "audit requirements", "is this ready to approve"). Do NOT auto-trigger after writing a phase doc — wait for an explicit ask.
---

# spec-review

Audit a phase document against its checklist and return a concise go/no-go report.

## Inputs to collect

- **Phase** — one of `requirements`, `design`, `research`, `tasks`. If missing or invalid, list the valid options and ask.

## Step 1 — Load

1. Read active spec: `cat spec/.current-spec`.
2. Verify the phase file exists: `spec/<spec>/<phase>.md`. If not, tell the user the doc doesn't exist and stop.
3. Read the full document.
4. Read `spec/<spec>/README.md` for spec context and approval state.

## Step 2 — Apply the phase-specific checklist

Load the matching checklist from `references/` and evaluate the document against it:

- `requirements` → `references/requirements-checklist.md`
- `design` → `references/design-checklist.md`
- `research` → `references/research-checklist.md`
- `tasks` → `references/tasks-checklist.md`

Each checklist is grouped by category. For each item, decide: passes / partial / fails / not-applicable.

## Step 3 — Produce the report

Target **300–500 words total**. Do NOT repeat or summarise the full document. Structure:

1. **Verdict** — one line: `Ready` / `Needs Work` / `Major Issues`
2. **Top strengths** — 2–3 bullets max, one line each
3. **Issues** — P0 blockers first, then P1 improvements. Max 5 total. Each issue carries:
   - A line reference (e.g. "L142–148" or "§4.2 — API design")
   - A concrete fix, not generic advice
4. **Next step** — a single concrete instruction: the one edit needed, or `Run spec-approve with phase <phase>` if Ready.

If more than 5 issues exist, rank by impact and surface only the top 5. Ask the user whether they want the full list.

## Notes

- This skill is read-only by default. Do not edit the phase document during a review.
- A "Ready" verdict means the user can proceed to `spec-approve`. Don't say Ready unless you'd stake your reputation on the doc shipping as-is.
- Use specific line refs, not "the requirements section". The user wants to jump straight to the issue.
