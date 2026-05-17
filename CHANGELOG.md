# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **`spec-revise` skill** (anthropic, openai-codex, cursor) — applies the fixes from a `spec-review` output file to its phase document. Prompts the user to apply all P0/P1 fixes in one pass or walk through each issue, edits the phase doc, bumps a `**Revision:** N · **Updated:** YYYY-MM-DD` header at the top of the phase doc, and flips resolved checkboxes in the review file with a `_(resolved in revision N on …)_` suffix. Triggered by phrases like "revise requirements", "apply the review fixes", "address the review feedback".

### Changed

- **`spec-review` now writes a persistent review file** at `spec/<spec>/reviews/<phase>-review.md` (overwriting on each run; history lives in git). The file contains the full issue list — not just the top 5 — with stable IDs (`R-01`, `R-02`, …) and unresolved checkboxes that `spec-revise` consumes. The in-chat reply is tightened to a 150–250-word summary that points at the file. Updated across all three adapters; the Cursor MDC keeps its inlined references at the bottom of the rule.

## [1.0.0] - 2026-05-16

First multi-agent release. Pivots packaging from Claude-only to model-agnostic. Skill content is unchanged; the new layout and adapters are the work.

### Changed

- **BREAKING:** Repository renamed `claude-spec-driven-sdlc` → `ai-spec-driven-sdlc`. GitHub auto-redirects the old URL to the new one; update your local remote with `git remote set-url origin git@github.com:dugleelabs/ai-spec-driven-sdlc.git`.
- **BREAKING:** Skill content moved from `skills/spec-*/` to `agents/<adapter>/skills/spec-*/` (or `agents/cursor/rules/spec-*.mdc` for Cursor). Old install paths still work; the source paths change.
- Top-level README rewritten around a multi-agent support matrix. The "Built with Claude" framing is generalized to "Built for AI-led development."
- `docs/directory-structure.md` and `docs/project-tracker-sync.md` updated to reflect the new layout and the companion-scripts copy pattern.

### Added

- **OpenAI Codex CLI adapter** (`agents/openai-codex/`) — same `SKILL.md` content as the Anthropic adapter, installed to `~/.agents/skills/` or `./.agents/skills/`. Codex CLI implements the `agentskills.io` standard verbatim.
- **Cursor adapter** (`agents/cursor/`) — 12 `.mdc` rule files in Cursor's MDC format. References from the 3 long-form skills are inlined into each MDC body because Cursor has no progressive-disclosure equivalent. Install to `./.cursor/rules/` (Cursor user rules are UI-only — no user-scope file install). `spec-sync` is not supported on this adapter in v1.
- **Per-agent READMEs** under each `agents/<adapter>/` folder — install paths, format conventions, known limitations, vendor doc links, and maintenance notes for each.
- `CHANGELOG.md` (this file), following Keep a Changelog format.

### Removed

- Old `skills/` folder. Migration instructions are in the top-level README's [Migrating from v0.x](README.md#migrating-from-v0x) section.

### Migration

From the cloned repo root after `git pull`, pick your agent:

```bash
# Claude Code — replaces the old user-scope install
rm -rf ~/.claude/skills/spec-*
cp -r agents/anthropic/skills/* ~/.claude/skills/

# OpenAI Codex CLI — new in v1
mkdir -p ~/.agents/skills && cp -r agents/openai-codex/skills/* ~/.agents/skills/

# Cursor — new in v1
mkdir -p ./.cursor/rules && cp agents/cursor/rules/*.mdc ./.cursor/rules/
```

Back up custom edits to any `SKILL.md` before re-installing — the `cp` commands overwrite.
