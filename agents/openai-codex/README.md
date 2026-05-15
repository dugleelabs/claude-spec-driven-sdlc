# OpenAI Codex CLI adapter

Adapter for [OpenAI Codex CLI](https://developers.openai.com/codex) and any agent that implements the [`agentskills.io`](https://agentskills.io/specification) `SKILL.md` standard.

Codex CLI implements the same `SKILL.md` format as Claude Code. Content here is **bit-for-bit identical** to `agents/anthropic/skills/` — the two adapters ship in parallel to keep each install path self-contained.

## Official documentation

- [OpenAI Codex Skills documentation](https://developers.openai.com/codex/skills) — canonical reference
- [Agent Skills specification (`agentskills.io`)](https://agentskills.io/specification) — multi-vendor standard the `SKILL.md` format follows

## Install paths

| Scope | Path |
|---|---|
| User (all your projects) | `~/.agents/skills/` |
| Project (this repo only) | `./.agents/skills/` |

Codex CLI auto-discovers skills from both locations on startup. Project-scope wins on conflict.

## Manual install

All commands run from the cloned repo root.

```bash
# User scope — install for all your projects
mkdir -p ~/.agents/skills
cp -r agents/openai-codex/skills/* ~/.agents/skills/

# Project scope — install in the current project only
mkdir -p ./.agents/skills
cp -r agents/openai-codex/skills/* ./.agents/skills/
```

Re-running either command overwrites existing skill content. Back up local edits before re-install if you have customized any skill.

### Companion scripts for `spec-sync`

The `spec-sync` skill shells out to `scripts/tasks-sync/<provider>/*.sh` at the **project root** of the repo you're working in. If you install skills at **user scope**, copy the companion scripts into each project where you want tracker sync:

```bash
# From the cloned repo root, into your project root
cp -r scripts/tasks-sync /path/to/your/project/scripts/
```

Skip this step if you don't use `spec-sync`.

## Format conventions

- **File:** `SKILL.md` per `agentskills.io` (Markdown body with YAML frontmatter) — identical to the Anthropic adapter.
- **Layout:** `spec-<name>/SKILL.md` plus optional `references/*.md` for progressive disclosure.
- **Frontmatter fields used in v1:** `name` (required), `description` (required).
- **Progressive disclosure:** Native — Codex CLI loads `references/` files on demand.

## Known limitations vs canonical SDLC workflow

None today. The 12 skills work identically to the Anthropic adapter.

## Maintenance notes

- **Watch for:** Codex CLI changing its install path (`~/.agents/skills/` is current as of May 2026), or diverging from the `agentskills.io` standard.
- **Vendor docs:** [Codex CLI documentation](https://developers.openai.com/codex) and the [Skills docs](https://developers.openai.com/codex/skills) above.
- **When Codex diverges from `agentskills.io`:** the Anthropic and Codex adapters stop being identical and need independent maintenance. This README's "Format conventions" is the source of truth for the Codex side from that point forward.
