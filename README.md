# Claude Spec-Driven SDLC

<p align="center">
  <strong>Syncs with</strong><br/>
  <a href="#linear-setup"><img src="https://img.shields.io/badge/Linear-5E6AD2?style=for-the-badge&logo=linear&logoColor=white" alt="Linear" /></a>
  <a href="#github-setup"><img src="https://img.shields.io/badge/GitHub_Projects-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Projects" /></a>
</p>

**The future of software development isn't AI writing code for you—it's AI thinking alongside you.**

Traditional SDLC demands extensive documentation, architecture reviews, and project management overhead. Most teams skip it. They jump straight to code, accumulate tech debt, and wonder why projects fail. The discipline exists for good reasons, but the friction is too high.

**AI-led SDLC changes everything.**

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

## The Paradigm Shift

This isn't just automation—it's **augmentation**. Claude becomes your:

- **Requirements Analyst**: Asks the right questions, identifies edge cases you'd miss, structures your thoughts into formal specifications
- **Solutions Architect**: Proposes architectures, evaluates trade-offs, documents decisions with rationale
- **Technical Writer**: Generates comprehensive documentation that stays in sync with your evolving understanding
- **Project Manager**: Breaks work into phases, identifies dependencies, tracks progress
- **Implementation Partner**: Executes tasks systematically while you maintain creative control

**You stay in the driver's seat.** Every phase requires your explicit approval before proceeding. The AI proposes, you dispose.

## Why This Matters

```
Idea → Requirements → Design → Tasks → Implementation
        ↑              ↑         ↑         ↑
     [Approve]     [Approve]  [Approve]  [You Code]
```

Most developers know they *should* write specs. They don't because:
- It's tedious and time-consuming
- Requirements feel obvious (until they're not)
- Design docs get stale immediately
- The overhead doesn't feel worth it for "small" features

**AI-led SDLC removes these excuses.** When generating a comprehensive requirements doc takes a conversation instead of a day, you'll actually do it. When the AI remembers every decision and context from requirements through implementation, nothing gets lost.

The result: **Enterprise-grade engineering discipline at startup speed.**

## Quick Start

### Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- Git repository for your project
- (Optional) [GitHub CLI](https://cli.github.com/) for GitHub Projects sync
- (Optional) [Linear API key](https://linear.app/settings/api) for Linear sync
- (Optional) `jq` and `curl` for Linear API scripts

### Installation

```bash
# Option 1: Clone into your existing project
git clone https://github.com/dugleelabs/claude-spec-driven-sdlc.git .claude-sdlc
cp -r .claude-sdlc/commands .claude/
cp -r .claude-sdlc/scripts .claude/   # Required for project tracker sync

# Option 2: Use as a standalone spec repository
git clone https://github.com/dugleelabs/claude-spec-driven-sdlc.git my-project-specs
cd my-project-specs
```

### Your First Spec

```bash
# Start Claude Code
claude

# Create a new specification
/dugleelabs:spec:new user-authentication

# Define requirements (Claude will guide you through it)
/dugleelabs:spec:requirements

# Review and approve when ready
/dugleelabs:spec:approve requirements

# Generate technical design
/dugleelabs:spec:design

# Approve design
/dugleelabs:spec:approve design

# Break down into tasks
/dugleelabs:spec:tasks

# Approve task list
/dugleelabs:spec:approve tasks

# Implement with full context
/dugleelabs:spec:implement
```

## The Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│   /dugleelabs:spec:new          Create spec directory and README    │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:requirements  AI interviews you, drafts spec     │
│       │                          with user stories & acceptance     │
│       ▼                          criteria                           │
│   /dugleelabs:spec:approve requirements  ← Human checkpoint         │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:design        AI proposes architecture based     │
│       │                          on approved requirements           │
│       ▼                                                             │
│   /dugleelabs:spec:approve design  ← Human checkpoint               │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:tasks         AI decomposes design into          │
│       │                          phased, actionable tasks           │
│       ▼                                                             │
│   /dugleelabs:spec:approve tasks  ← Human checkpoint                │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:implement     AI implements with full context    │
│       │                          from all previous phases           │
│       ▼                                                             │
│   /dugleelabs:spec:sync          Sync to project tracker (optional) │
│                                  Supports GitHub Projects & Linear  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## Commands Reference

| Command | Description |
|---------|-------------|
| `/dugleelabs:spec:new <name>` | Create a new feature specification |
| `/dugleelabs:spec:requirements` | Create or review requirements document |
| `/dugleelabs:spec:design` | Create technical design specification (feature specs) |
| `/dugleelabs:spec:research` | Create research specification (competitive analysis, ethos, dispositions) |
| `/dugleelabs:spec:tasks` | Generate implementation task list |
| `/dugleelabs:spec:implement [phase]` | Start or continue implementation |
| `/dugleelabs:spec:approve <phase>` | Approve a phase (requirements\|design\|research\|tasks) |
| `/dugleelabs:spec:review` | Review current phase and get feedback |
| `/dugleelabs:spec:status` | Show all specs and their progress |
| `/dugleelabs:spec:switch <id>` | Switch to a different specification |
| `/dugleelabs:spec:update-task <task>` | Mark a task as complete |
| `/dugleelabs:spec:sync` | Sync tasks to project tracker (GitHub Projects or Linear) |
| `/dugleelabs:spec:github-sync` | *(Deprecated)* Use `/dugleelabs:spec:sync` instead |

## What Gets Generated

Each spec produces three documents — `requirements.md`, `design.md`, and `tasks.md` — that build on each other through the workflow phases. See [docs/generated-artifacts.md](docs/generated-artifacts.md) for full details on what each contains.

### Research specs (alternate variant)

Not every spec ships code. Competitive analyses, roadmap research, strategy reviews, and architecture spikes produce **decision documents**, not implementations. For these, use `/dugleelabs:spec:research` in place of `/dugleelabs:spec:design`:

```
/dugleelabs:spec:new my-research-topic
/dugleelabs:spec:requirements
/dugleelabs:spec:approve requirements

/dugleelabs:spec:research              # produces research.md — not design.md
/dugleelabs:spec:review research       # self-audit against the research checklist
/dugleelabs:spec:approve research

# Research specs skip /tasks and /implement.
# For each candidate classified as "pillar" or "feature worth pursuing"
# in research.md, create a follow-up spec:
/dugleelabs:spec:new <follow-up-name>
```

`research.md` includes an executive summary, ethos pillars + anti-pillars, competitive landscape with citations, community signals, candidate critiques, dispositions (pillar / feature / deferred / dropped), and a consolidated references section. Sourcing is enforced: every non-trivial claim carries an inline citation.

## Directory Structure

Specs live in `spec/` with sequential IDs, commands in `.claude/commands/`, and sync scripts in `scripts/tasks-sync/`. See [docs/directory-structure.md](docs/directory-structure.md) for the full layout.

## Project Tracker Sync

Sync your tasks to <a id="linear-setup"></a>**[Linear](docs/project-tracker-sync.md#linear-setup)** or <a id="github-setup"></a>**[GitHub Projects](docs/project-tracker-sync.md#github-setup)** for team visibility. `tasks.md` stays the source of truth — the tracker reflects its state. See [docs/project-tracker-sync.md](docs/project-tracker-sync.md) for setup, configuration, and architecture details.

## Best Practices

1. **Don't skip phases** — Each phase builds context for the next. The AI's implementation quality depends on the requirements and design it has to work with.

2. **Be thorough in requirements** — This is where you teach the AI what you're building. Edge cases, error scenarios, acceptance criteria—the more you provide, the better the output.

3. **Review before approving** — Use `/dugleelabs:spec:review` to get Claude's self-assessment before you approve. It often catches its own gaps.

4. **Commit your specs** — These are valuable artifacts. They document not just *what* was built, but *why*.

5. **One spec per feature** — Keep specifications focused. Scope creep in specs leads to scope creep in code.

6. **Iterate on phases** — Don't feel pressured to approve immediately. Discuss, refine, and improve each phase until you're satisfied.

## The Vision

We're at an inflection point. AI can now participate meaningfully in the entire software development lifecycle—not just code generation, but the thinking that precedes it.

This toolkit is an experiment in what that collaboration looks like. It's opinionated, structured, and designed to keep humans in control while leveraging AI's ability to think through problems systematically.

**The best code comes from clear thinking. AI-led SDLC makes clear thinking the default.**

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License - See [LICENSE](LICENSE) for details.

---

Built with Claude by [DugleeLabs](https://github.com/dugleelabs)
