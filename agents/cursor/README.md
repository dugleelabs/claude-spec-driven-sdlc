# Cursor adapter

Adapter for [Cursor](https://cursor.com) — the AI code editor. Ships the 13 SDLC skills as Cursor [Project Rules](https://cursor.com/docs/context/rules) in MDC format.

## Official documentation

- [Cursor Rules documentation](https://cursor.com/docs/context/rules) — canonical reference for the MDC format and rule discovery
- [Cursor documentation home](https://cursor.com/docs)

## Install paths

| Scope | Path |
|---|---|
| Project (this repo only) | `./.cursor/rules/` |

**Cursor user-level rules are configured through the Cursor UI**, not files. There is no user-scope install path on disk for this adapter. Install the rules per project, or use Cursor's UI to set workspace-wide preferences separately.

## Manual install

All commands run from the cloned repo root.

```bash
# Project scope (only scope supported on disk)
mkdir -p ./.cursor/rules
cp agents/cursor/rules/*.mdc ./.cursor/rules/
```

Re-running the command overwrites existing rule files. Cursor auto-discovers rules from `.cursor/rules/` — no editor restart needed.

## Format conventions

- **File:** `.mdc` (Markdown with YAML frontmatter), one file per skill, flat (no subdirectories).
- **Frontmatter fields used in v1:**
  - `description` (required) — copied verbatim from the source `SKILL.md` so Cursor's rule-matching behaves the same way Claude Code's skill-matching does.
  - `alwaysApply: false` — Cursor loads the rule when its description matches user intent (same trigger model as Anthropic skills).
- **Optional Cursor fields not used in v1:** `globs` (apply when files match a pattern). None of the 13 SDLC skills are file-pattern-scoped, so this stays empty.
- **Progressive disclosure: not supported in MDC.** The 3 long-form skills (`spec-research`, `spec-review`, `spec-sync`) inline their `references/*.md` content under a `## References` H2 section at the bottom of the MDC body. Cursor pays the full body cost on every load.

## Known limitations vs canonical SDLC workflow

- **No user-scope file install.** Cursor user rules are UI-only — install per project.
- **`spec-sync` is not supported in v1.** The skill shells out to bash scripts in `scripts/tasks-sync/`, which Cursor's tool model doesn't currently invoke the same way. Cursor users who need tracker sync should fall back to the Anthropic or OpenAI Codex adapter for that workflow.
- **No progressive disclosure.** References are inlined into each MDC body; the file is larger than the SKILL.md equivalent. Not a problem at current sizes (largest is `spec-sync.mdc` at ~600 lines, well within Cursor's practical limits as of May 2026), but a future fallback is to split a single skill across multiple `.mdc` files with narrower descriptions.

## Maintenance notes

- **Watch for:** Cursor changing the MDC frontmatter schema (e.g. renaming `alwaysApply`, adding required fields), changing the discovery path away from `.cursor/rules/`, or introducing a file-based user-scope rule store.
- **Vendor docs:** [Cursor Rules](https://cursor.com/docs/context/rules) — re-verify before each release.
- **When the format changes:** update this README's "Format conventions" first, then re-run the MDC-generation step (`agents/anthropic/skills/spec-*/SKILL.md` → `agents/cursor/rules/spec-*.mdc`) so the two adapters stay in sync on body content.