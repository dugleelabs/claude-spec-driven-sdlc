---
name: spec-switch
description: Change the active specification by updating spec/.current-spec to point at a different existing spec directory. Use ONLY when the user explicitly asks to switch, change, or set the active spec (e.g. "switch to spec 003", "make X the active spec", "work on Y instead"). Do NOT trigger when the user merely mentions another spec.
---

# spec-switch

Change which spec is active by updating `spec/.current-spec`.

## Inputs to collect

- **Target spec** — directory name (e.g. `028-copair-bug-fixes`) or partial match (e.g. `028`). If the user supplied one, resolve it against the directory listing. If ambiguous or missing, list available specs and ask.

## Steps

1. List specs: `ls -d spec/*/ 2>/dev/null | sort` — strip trailing slashes for matching.
2. Resolve the target:
   - Exact directory match → use it.
   - Partial / prefix match against exactly one spec → use it.
   - Multiple matches or no matches → list candidates and ask the user to choose.
3. Write the resolved directory name (e.g. `028-copair-bug-fixes`) into `spec/.current-spec`.
4. Read the target spec's `README.md` to surface its phase status.
5. Report:
   - The new active spec
   - Phase completion status from its README
   - The recommended next action (e.g. "Requirements is approved → run spec-design next")

## Notes

- Do not overwrite `.current-spec` until the target is resolved unambiguously.
- If `spec/` doesn't exist or is empty, tell the user to use `spec-new` first.
