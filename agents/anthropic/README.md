# Anthropic adapter — Claude Code

Adapter for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and any agent that implements the [`agentskills.io`](https://agentskills.io/specification) `SKILL.md` standard.

## Official documentation

- [Claude Code Skills documentation](https://code.claude.com/docs/en/skills) — canonical reference
- [Agent Skills specification (`agentskills.io`)](https://agentskills.io/specification) — multi-vendor standard the `SKILL.md` format follows

## Install paths

| Scope | Path |
|---|---|
| User (all your projects) | `~/.claude/skills/` |
| Project (this repo only) | `./.claude/skills/` |

Claude Code auto-discovers skills from both locations on startup. Project-scope wins on conflict.

## Manual install

All commands run from the cloned repo root.

```bash
# User scope — install for all your projects
mkdir -p ~/.claude/skills
cp -r agents/anthropic/skills/* ~/.claude/skills/

# Project scope — install in the current project only
mkdir -p ./.claude/skills
cp -r agents/anthropic/skills/* ./.claude/skills/
```

Re-running either command overwrites existing skill content. Back up local edits to `~/.claude/skills/spec-*/` before re-install if you have customized any skill.

### Companion scripts for `spec-sync`

The `spec-sync` skill shells out to `scripts/tasks-sync/<provider>/*.sh` at the **project root** of the repo you're working in. If you install skills at **user scope**, copy the companion scripts into each project where you want tracker sync:

```bash
# From the cloned repo root, into your project root
cp -r scripts/tasks-sync /path/to/your/project/scripts/
```

Skip this step if you don't use `spec-sync`.

## Format conventions

- **File:** `SKILL.md` per `agentskills.io` (Markdown body with YAML frontmatter)
- **Layout:** `spec-<name>/SKILL.md` plus optional `references/*.md` for progressive disclosure
- **Frontmatter fields used in v1:** `name` (required), `description` (required). No other fields are set today.
- **Progressive disclosure:** Native — Claude Code loads `references/` files on demand. The 3 long-form skills (`spec-research`, `spec-review`, `spec-sync`) rely on this.

## Known limitations vs canonical SDLC workflow

None today. This is the reference adapter — all 12 skills work as designed.

## Maintenance notes

- **Watch for:** new required frontmatter fields, changes to `references/` resolution, deprecation of `agentskills.io` field names.
- **Vendor changelog:** [Claude Code release notes](https://docs.anthropic.com/en/release-notes/claude-code) and the [`code.claude.com` skills docs](https://code.claude.com/docs/en/skills).
- **When the vendor changes the format:** update this README's "Format conventions" first, then resync the 12 `SKILL.md` files. Bump the toolkit's version when shipping the change.
