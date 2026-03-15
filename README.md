# Claude Spec-Driven SDLC

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
| `/dugleelabs:spec:design` | Create technical design specification |
| `/dugleelabs:spec:tasks` | Generate implementation task list |
| `/dugleelabs:spec:implement [phase]` | Start or continue implementation |
| `/dugleelabs:spec:approve <phase>` | Approve a phase (requirements\|design\|tasks) |
| `/dugleelabs:spec:review` | Review current phase and get feedback |
| `/dugleelabs:spec:status` | Show all specs and their progress |
| `/dugleelabs:spec:switch <id>` | Switch to a different specification |
| `/dugleelabs:spec:update-task <task>` | Mark a task as complete |
| `/dugleelabs:spec:sync` | Sync tasks to project tracker (GitHub Projects or Linear) |
| `/dugleelabs:spec:github-sync` | *(Deprecated)* Use `/dugleelabs:spec:sync` instead |

## What Gets Generated

### requirements.md
- Feature overview and problem statement
- Current state context (tech stack, existing systems)
- User stories with acceptance criteria
- Functional requirements (P0, P1, P2 priority)
- Non-functional requirements (performance, security, scalability)
- Constraints, assumptions, and out-of-scope items
- Success metrics and open questions

### design.md
- Architecture overview with diagrams
- Technology stack decisions with rationale
- Data models and schema
- API design
- Security considerations
- Performance considerations
- Deployment architecture
- Technical risks and mitigations

### tasks.md
- Phase-organized task breakdown
- Checkbox format for progress tracking
- Task dependencies clearly marked
- Actionable, specific items ready for implementation

## Directory Structure

```
your-project/
├── .claude/
│   └── commands/
│       └── dugleelabs/
│           └── spec/           # All spec commands live here
├── spec/
│   ├── .current-spec           # Tracks active specification
│   ├── 001-user-auth/
│   │   ├── README.md           # Spec overview and status
│   │   ├── requirements.md     # Requirements specification
│   │   ├── design.md           # Technical design document
│   │   ├── tasks.md            # Implementation checklist
│   │   └── .sync.json           # Sync state (if project tracker enabled)
│   └── 002-payment-flow/
│       └── ...
├── scripts/
│   └── tasks-sync/              # Project tracker sync scripts
│       ├── github/              # GitHub Projects API scripts
│       └── linear/              # Linear API scripts
├── .sync-config.json            # (Optional) Repo-level tracker defaults
└── src/                         # Your actual code (separate repo supported)
```

## Project Tracker Sync

Sync your tasks to a project tracker for team visibility. Supports **GitHub Projects** and **Linear**, with a provider-based architecture that's extensible to other tools.

```bash
# Sync to Linear (first time — will prompt for team and project)
/dugleelabs:spec:sync --provider linear

# Sync to GitHub Projects
/dugleelabs:spec:sync --provider github --project 1

# Subsequent syncs use saved config (no flags needed)
/dugleelabs:spec:sync

# Preview changes without executing
/dugleelabs:spec:sync --dry-run
```

### How It Works

`tasks.md` is always the source of truth — the tracker reflects its state:

| tasks.md | GitHub Projects | Linear |
|---|---|---|
| `- [ ]` (pending) | Status: Todo | State: Todo (unstarted) |
| `- [x]` (done) | Status: Done | State: Done (completed) |

**Linear** syncs with hierarchy: parent tasks become issues, subtasks become sub-issues nested under the parent. Only parent issues appear on the project board.

**GitHub Projects** uses a flat model: all tasks (parents and subtasks) appear as individual draft items on the board.

### Configuration

The sync command resolves settings through a chain (first match wins):

```
CLI flag  →  .sync.json  →  requirements.md  →  .sync-config.json  →  prompt
```

You can optionally configure tracker preferences during the requirements phase, or let the sync command prompt you on first run. Once configured, settings are saved in `.sync.json` per spec — subsequent syncs need no flags.

#### Repo-level Defaults (`.sync-config.json`)

Create a `.sync-config.json` at the repo root to set defaults for all specs:

```json
{
  "default_provider": "linear",
  "github": {
    "owner": "your-org"
  },
  "linear": {
    "team_key": "ENG"
  }
}
```

#### Linear Setup

Store your Linear API key in the global credentials file (works across all projects):

```bash
mkdir -p ~/.config/linear
echo "LINEAR_API_KEY=lin_api_xxxxx" > ~/.config/linear/credentials
chmod 600 ~/.config/linear/credentials
```

The sync scripts automatically load credentials from `~/.config/linear/credentials`. No per-project setup needed.

Alternatively, set it as an environment variable (overrides the credentials file):

```bash
export LINEAR_API_KEY=lin_api_xxxxx
```

Then sync:

```bash
# Sync will prompt for team and project on first run
/dugleelabs:spec:sync --provider linear

# Or specify explicitly
/dugleelabs:spec:sync --provider linear --team ENG
```

#### GitHub Setup

```bash
# Ensure gh CLI is authenticated
gh auth login

# Sync to a specific project
/dugleelabs:spec:sync --provider github --owner your-org --project 1
```

### Script Architecture

All API operations are implemented as standalone bash scripts in `scripts/tasks-sync/`. The sync command (Claude) handles parsing, diffing, and decisions — scripts handle deterministic API calls. This saves tokens and makes operations reproducible.

```
scripts/tasks-sync/
├── github/
│   ├── list-projects.sh       # List org projects
│   ├── create-project.sh      # Create a new project
│   ├── create-item.sh         # Create a draft item
│   ├── get-field-ids.sh       # Get Status field metadata
│   └── update-status.sh       # Update item status
└── linear/
    ├── _graphql.sh            # Shared GraphQL helper
    ├── auth-check.sh          # Validate API key
    ├── list-teams.sh          # List workspace teams
    ├── list-projects.sh       # List team projects
    ├── create-project.sh      # Create a new project
    ├── get-workflow-states.sh  # Get todo/done state IDs
    ├── create-issue.sh        # Create a parent issue
    ├── create-sub-issue.sh    # Create a sub-issue
    └── update-issue-state.sh  # Update issue workflow state
```

### Adding New Providers

The sync system is designed to be extensible. To add a new provider:

1. Create `scripts/tasks-sync/<provider>/` with the required scripts:
   - `auth-check.sh` — validate credentials
   - `list-projects.sh` — list available projects
   - `create-project.sh` — create a new project
   - `create-issue.sh` — create an issue/item
   - `update-issue-state.sh` — update issue status
2. Add provider-specific sections to `sync.md` command prompt
3. Add the provider option to the configuration resolution chain

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
