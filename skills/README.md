# Claude Spec-Driven SDLC — Skills

This directory holds the skills that implement the spec-driven workflow. Each skill is a self-contained `SKILL.md` (plus optional `references/` for longer guidance) following the Anthropic [Agent Skills specification](https://agentskills.io/specification).

Skills are model-discovered: Claude loads a skill when the user's request matches its `description`. There is no slash-command invocation — describe what you want and Claude picks the right skill.

## Catalog

| Skill | What it does |
|---|---|
| `spec-new` | Create a new spec directory under `spec/` and set it active |
| `spec-requirements` | Draft / revise `requirements.md` for the active spec |
| `spec-design` | Draft / revise `design.md` (feature specs) |
| `spec-research` | Draft / revise `research.md` (decision-only specs) |
| `spec-tasks` | Decompose approved design into `tasks.md` |
| `spec-implement` | Drive implementation across target repos |
| `spec-approve` | Mark a phase approved (requirements / design / research / tasks) |
| `spec-review` | Self-audit a phase document against its checklist |
| `spec-status` | Report status of all specs |
| `spec-switch` | Change the active spec |
| `spec-sync` | Sync approved tasks to GitHub Projects or Linear |
| `spec-update-task` | Mark a single task complete in `tasks.md` |

## Workflow

```
spec-new  →  spec-requirements  →  spec-approve  →  spec-design   →  spec-approve  →  spec-tasks  →  spec-approve  →  spec-implement
                                                  └  spec-research →  spec-approve  →  (no tasks; create follow-up specs via spec-new)
```

`spec-review` is optional at any phase. `spec-sync` runs after tasks are approved.

## Installation

**Project-level (recommended for repo contributors):**

```bash
mkdir -p .claude/skills
cp -r skills/* .claude/skills/
```

**User-level (available across all your projects):**

```bash
mkdir -p ~/.claude/skills
cp -r skills/* ~/.claude/skills/
```

Claude Code auto-discovers skills from both locations on startup.

## Structure

Each skill directory matches the canonical spec:

```
spec-<name>/
├── SKILL.md          # required: frontmatter + instructions
└── references/       # optional: extended guidance, checklists, schemas
    └── *.md
```

`SKILL.md` frontmatter:

```yaml
---
name: spec-<name>           # must match directory name
description: <what + when>  # how Claude decides to load it
---
```

## Design notes

- **Phase gating is explicit.** Each authoring skill checks for `.<phase>-approved` marker files before proceeding. The skill model is permissive about loading; the gates inside each skill enforce sequencing.
- **No invented context.** Skills explicitly tell Claude to ask the user before writing content that isn't grounded in prior phase documents.
- **`tasks.md` is the source of truth.** The sync skill never deletes tracker items — orphans are flagged.
- **Long skills offload to `references/`.** Anthropic's guideline is to keep `SKILL.md` under ~5k tokens; `spec-research`, `spec-review`, and `spec-sync` move detail into their `references/` directories.
