# AI Spec-Driven SDLC

<p align="center">
  <strong>Syncs with</strong><br/>
  <a href="docs/project-tracker-sync.md#linear-setup"><img src="https://img.shields.io/badge/Linear-5E6AD2?style=for-the-badge&logo=linear&logoColor=white" alt="Linear" /></a>
  <a href="docs/project-tracker-sync.md#github-setup"><img src="https://img.shields.io/badge/GitHub_Projects-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Projects" /></a>
</p>

**AI-led SDLC for any coding agent.** A model-agnostic toolkit of 12 skills that walk a developer through requirements → design → tasks → implementation, with explicit approval gates at every phase. Ships native adapters for Claude Code, OpenAI Codex CLI, and Cursor.

## Supported agents

Install is a single `cp` per agent. Pick your agent below; the per-agent README has the exact command.

| Agent | Status | Install (project scope, run from repo root) | Adapter |
|---|---|---|---|
| **Claude Code** (Anthropic) | ✅ v1 | `mkdir -p .claude/skills && cp -r agents/anthropic/skills/* .claude/skills/` | [agents/anthropic](agents/anthropic/README.md) |
| **OpenAI Codex CLI** | ✅ v1 | `mkdir -p .agents/skills && cp -r agents/openai-codex/skills/* .agents/skills/` | [agents/openai-codex](agents/openai-codex/README.md) |
| **Cursor** | ✅ v1 (no `spec-sync`) | `mkdir -p .cursor/rules && cp agents/cursor/rules/*.mdc .cursor/rules/` | [agents/cursor](agents/cursor/README.md) |
| Cline · Continue.dev · Windsurf | 🛠 Planned | — | Follow-up spec |
| Gemini CLI · Aider | 🔬 Researching | — | — |

Each per-agent README documents user-scope vs project-scope install, format conventions, known limitations, and maintenance notes.

If your agent isn't in the matrix and you want it added, open an issue.

## Why this exists

**The future of software development isn't AI writing code for you — it's AI thinking alongside you.**

Traditional SDLC demands extensive documentation, architecture reviews, and project management overhead. Most teams skip it. They jump straight to code, accumulate tech debt, and wonder why projects fail. The discipline exists for good reasons, but the friction is too high.

**AI-led SDLC changes this.**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│   Traditional SDLC                    AI-Led SDLC                           │
│   ─────────────────                   ───────────────                       │
│   Write specs alone (hours)     →     Collaborative spec generation (mins)  │
│   Architecture reviews (days)   →     Instant design validation             │
│   Manual task breakdown         →     Intelligent task decomposition        │
│   Context lost between phases   →     Perfect context preservation          │
│   Documentation as afterthought →     Documentation as the process          │
│   Solo developer bottleneck     →     AI pair throughout lifecycle          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

This isn't just automation — it's **augmentation**. Your agent becomes your requirements analyst, solutions architect, technical writer, project manager, and implementation partner.

**You stay in the driver's seat.** Every phase requires your explicit approval before proceeding. The AI proposes, you dispose.

## Quick start

### Prerequisites

- A supported coding agent installed and configured (see [Supported agents](#supported-agents))
- Git repository for your project
- (Optional) [GitHub CLI](https://cli.github.com/) for GitHub Projects sync
- (Optional) [Linear API key](https://linear.app/settings/api) for Linear sync
- (Optional) `jq` and `curl` for the Linear sync scripts

### Install (per agent)

Clone this repo, then run the `cp` command for your agent:

```bash
git clone https://github.com/dugleelabs/ai-spec-driven-sdlc.git
cd ai-spec-driven-sdlc
```

**Claude Code:**
```bash
mkdir -p .claude/skills
cp -r agents/anthropic/skills/* .claude/skills/
```

**OpenAI Codex CLI:**
```bash
mkdir -p .agents/skills
cp -r agents/openai-codex/skills/* .agents/skills/
```

**Cursor:**
```bash
mkdir -p .cursor/rules
cp agents/cursor/rules/*.mdc .cursor/rules/
```

For user-scope install (skills available across all your projects), see your adapter's README. The 3 per-agent READMEs are the authoritative install reference.

### Your first spec

Just describe what you want — your agent picks the right skill at each step:

```
You:    Let's create a spec for user authentication.
        → spec-new fires, creates spec/001-user-authentication/

You:    Draft the requirements. It uses email + password, with a TOTP option later.
        → spec-requirements fires, drafts requirements.md (asks clarifying questions)

You:    Review the requirements.
        → spec-review fires with phase=requirements, returns a verdict

You:    Looks good — approve requirements.
        → spec-approve fires, sets .requirements-approved

You:    Now write the design.
        → spec-design fires, drafts design.md

You:    Approve the design and generate tasks.
        → spec-approve → spec-tasks fires

You:    Approve tasks and let's start implementing phase 1.
        → spec-approve → spec-implement fires
```

## The workflow

```mermaid
flowchart TD
    new([spec-new<br/><i>create spec directory + README</i>])
    req([spec-requirements<br/><i>draft user stories, acceptance criteria</i>])
    approveReq{{spec-approve · requirements}}
    branch{Feature spec<br/>or research spec?}

    design([spec-design<br/><i>propose architecture</i>])
    approveDesign{{spec-approve · design}}
    tasks([spec-tasks<br/><i>decompose into phased tasks</i>])
    approveTasks{{spec-approve · tasks}}
    implement([spec-implement<br/><i>build, updating tasks.md</i>])
    sync([spec-sync<br/><i>mirror to GitHub Projects or Linear · optional</i>])

    research([spec-research<br/><i>landscape, ethos, candidate dispositions</i>])
    approveResearch{{spec-approve · research}}
    followups([spec-new<br/><i>one follow-up spec per surviving candidate</i>])

    new --> req --> approveReq --> branch
    branch -- feature --> design --> approveDesign --> tasks --> approveTasks --> implement --> sync
    branch -- research --> research --> approveResearch --> followups

    classDef skill fill:#1f2937,stroke:#60a5fa,stroke-width:1px,color:#f9fafb;
    classDef gate  fill:#7c2d12,stroke:#fb923c,stroke-width:1px,color:#fff7ed;
    classDef decision fill:#312e81,stroke:#a5b4fc,stroke-width:1px,color:#eef2ff;
    class new,req,design,tasks,implement,sync,research,followups skill;
    class approveReq,approveDesign,approveTasks,approveResearch gate;
    class branch decision;
```

**Rounded nodes** are skills your agent invokes. **Hex gates** (`spec-approve · …`) are human checkpoints — no phase advances without one. **The diamond** is the only fork: feature specs ship code, research specs ship decisions and spawn follow-up specs.

`spec-review` and `spec-status` can run at any time and are omitted from the main path. `spec-switch` and `spec-update-task` are housekeeping skills, also off-path.

## Skills reference

| Skill | Triggers when you say... |
|---|---|
| `spec-new` | "create a new spec for X", "start a spec called X" |
| `spec-requirements` | "draft requirements", "write the requirements doc" |
| `spec-design` | "design this", "draft the design doc" |
| `spec-research` | "do the research", "competitive scan", "evaluate candidates" |
| `spec-tasks` | "generate tasks", "break this down" |
| `spec-implement` | "start implementation", "begin building", "implement phase 2" |
| `spec-approve` | "approve requirements", "approve the design" |
| `spec-review` | "review the design", "audit the requirements" |
| `spec-status` | "show all specs", "what's the status" |
| `spec-switch` | "switch to spec 003", "work on the auth spec instead" |
| `spec-sync` | "sync to Linear", "push tasks to GitHub Projects" |
| `spec-update-task` | "mark T-12 done", "I finished the auth task" |

Each phase-authoring skill checks for the previous phase's approval marker before proceeding, so the workflow can't skip steps.

Skill definitions live under [`agents/`](agents/) — one folder per supported agent, each in that agent's native format. The Anthropic and Codex adapters use `SKILL.md` per the [Agent Skills specification](https://agentskills.io/specification); Cursor uses MDC rules.

## What gets generated

Each spec produces three documents — `requirements.md`, `design.md`, and `tasks.md` — that build on each other through the workflow phases. See [docs/generated-artifacts.md](docs/generated-artifacts.md) for full details on what each contains.

### Research specs (alternate variant)

Not every spec ships code. Competitive analyses, roadmap research, strategy reviews, and architecture spikes produce **decision documents**, not implementations. For these, ask your agent for research in place of design:

```
You:    Create a spec for evaluating local-model tooling.       → spec-new
You:    Draft requirements: define what "local-model tooling"
        means and the dimensions to evaluate.                   → spec-requirements
You:    Approve requirements.                                   → spec-approve
You:    Do the research.                                        → spec-research
                                                                  (produces research.md, not design.md)
You:    Review the research.                                    → spec-review (phase=research)
You:    Approve research.                                       → spec-approve
You:    For each "pillar" and "feature worth pursuing"
        in research.md, create a follow-up spec.                → spec-new (one per candidate)
```

Research specs skip the tasks and implementation phases. `research.md` includes an executive summary, ethos pillars + anti-pillars, competitive landscape with citations, community signals, candidate critiques, dispositions (pillar / feature / deferred / dropped), and a consolidated references section. Sourcing is enforced: every non-trivial claim carries an inline citation.

## Directory structure

Specs live in `spec/`, agent adapters under `agents/<adapter>/`, and tracker-sync companion scripts under `scripts/tasks-sync/`. See [docs/directory-structure.md](docs/directory-structure.md) for the full layout.

## Project tracker sync

Sync your tasks to <a id="linear-setup"></a>**[Linear](docs/project-tracker-sync.md#linear-setup)** or <a id="github-setup"></a>**[GitHub Projects](docs/project-tracker-sync.md#github-setup)** for team visibility. `tasks.md` stays the source of truth — the tracker reflects its state. See [docs/project-tracker-sync.md](docs/project-tracker-sync.md) for setup, configuration, and architecture details. (Currently supported on the Anthropic and OpenAI Codex adapters; not on Cursor in v1.)

## Migrating from v0.x

The v0.x layout (`skills/spec-*/`) was Claude-only. v1.0.0 reorganizes the same skill content under per-agent adapter folders. Pick the migration command for your agent and run it from the cloned repo root after `git pull`:

```bash
# Claude Code — replaces the old user-scope install
rm -rf ~/.claude/skills/spec-*
cp -r agents/anthropic/skills/* ~/.claude/skills/

# OpenAI Codex CLI — new in v1
mkdir -p ~/.agents/skills && cp -r agents/openai-codex/skills/* ~/.agents/skills/

# Cursor — new in v1
mkdir -p ./.cursor/rules && cp agents/cursor/rules/*.mdc ./.cursor/rules/
```

If you customized any `SKILL.md` before migrating, back it up first — the copy commands overwrite. See [CHANGELOG.md](CHANGELOG.md) for the full list of v1 changes.

## Best practices

1. **Don't skip phases.** Each phase builds context for the next. The AI's implementation quality depends on the requirements and design it has to work with. The phase-approval markers enforce this in the skills, but only if you let them.
2. **Be thorough in requirements.** This is where you teach the AI what you're building. Edge cases, error scenarios, acceptance criteria — the more you provide, the better the output.
3. **Review before approving.** Ask your agent to review the phase before approving it. The `spec-review` skill returns a verdict (`Ready` / `Needs Work` / `Major Issues`) and often catches gaps you'd miss.
4. **Commit your specs.** These are valuable artifacts. They document not just *what* was built, but *why*.
5. **One spec per feature.** Keep specifications focused. Scope creep in specs leads to scope creep in code.
6. **Iterate on phases.** Don't feel pressured to approve immediately. Discuss, refine, and improve each phase until you're satisfied.

## Contributing

Contributions are welcome — especially new adapters. The repo is organized so that adding an agent means adding one folder under `agents/<your-agent>/` with a README and the 12 skills in that agent's native format. Open an issue first to flag the work so we don't duplicate.

## License

MIT License — see [LICENSE](LICENSE) for details.

---

Built for AI-led development by [DugleeLabs](https://github.com/dugleelabs).
