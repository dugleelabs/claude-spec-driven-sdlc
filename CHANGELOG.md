# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - TBD

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
