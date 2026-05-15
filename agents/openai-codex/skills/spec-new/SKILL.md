---
name: spec-new
description: Create a new feature specification directory under spec/ with a sequential ID and a README scaffold. Use ONLY when the user explicitly asks to start a new spec, feature spec, or research spec — e.g. "create a spec for X", "new spec called X", "let's spec out X". Do NOT trigger on general feature discussion; wait for an explicit ask.
---

# spec-new

Create a new specification directory under `spec/` and set it as the active spec.

## Inputs to collect

- **Feature name** — short kebab-case (e.g. `user-auth`, `payment-flow`). If the user gave a name in their message, use it verbatim. Otherwise ask once for the name before proceeding.

## Steps

1. Gather context with bash:
   - `ls spec/ 2>/dev/null || echo "No spec directory"` — see existing specs
   - `date +%Y-%m-%d` — today's date for the README
2. Determine the next sequential ID by scanning the existing spec directories. IDs are zero-padded 3-digit numbers (`001`, `002`, …). The next ID is `max(existing) + 1`. If `spec/` doesn't exist, start at `001`.
3. Create the directory `spec/<ID>-<feature-name>/` with `mkdir -p`.
4. Write `spec/.current-spec` containing the new spec directory name (just `<ID>-<feature-name>`, no trailing newline beyond what the editor adds).
5. Create `spec/<ID>-<feature-name>/README.md` with:
   - `# <ID>-<feature-name>` title
   - `**Created:** <today's date>` line
   - `**Status:** Draft` line
   - A phase checklist:
     ```
     - [ ] Requirements
     - [ ] Design (or Research, for research specs)
     - [ ] Tasks
     - [ ] Implementation
     ```
   - A "Next step" line: `Run the spec-requirements skill to draft requirements.`
6. Report to the user:
   - The new spec ID and directory path
   - That it is now the active spec
   - The recommended next step: draft requirements via the `spec-requirements` skill

## Notes

- One spec per feature — if the user describes multiple unrelated features, ask whether to create separate specs.
- Do not invent feature context. If the name is ambiguous, ask before creating.
- Use Write for the README and Bash for `mkdir` and writing `.current-spec`.
