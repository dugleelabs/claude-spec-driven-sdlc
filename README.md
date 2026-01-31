# Claude Spec-Driven SDLC

A structured specification-driven software development lifecycle powered by [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Transform your ideas into well-documented, systematically implemented features through a guided workflow.

```
Idea → Requirements → Design → Tasks → Implementation
```

## Why Spec-Driven Development?

Building software without a spec is like building a house without blueprints. You might finish, but you'll make costly mistakes along the way. This toolkit enforces a disciplined approach:

- **Requirements First**: Define what you're building before writing code
- **Design Before Code**: Think through architecture and edge cases upfront
- **Traceable Tasks**: Every line of code ties back to a documented requirement
- **Human Checkpoints**: You approve each phase before proceeding

## Quick Start

### Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- Git repository for your project
- (Optional) [GitHub CLI](https://cli.github.com/) for project board sync

### Installation

Clone this repository into your project or use it as a template:

```bash
# Option 1: Clone into your existing project
git clone https://github.com/dugleelabs/claude-spec-driven-sdlc.git .claude-sdlc
cp -r .claude-sdlc/.claude/commands .claude/

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

# Define requirements (Claude will guide you)
/dugleelabs:spec:requirements

# Approve requirements when ready
/dugleelabs:spec:approve requirements

# Create technical design
/dugleelabs:spec:design

# Approve design
/dugleelabs:spec:approve design

# Generate implementation tasks
/dugleelabs:spec:tasks

# Approve tasks
/dugleelabs:spec:approve tasks

# Start implementing!
/dugleelabs:spec:implement
```

## The Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│   /dugleelabs:spec:new          Create spec directory and README    │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:requirements  Define user stories, acceptance    │
│       │                          criteria, requirements             │
│       ▼                                                             │
│   /dugleelabs:spec:approve requirements  ← Human checkpoint         │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:design        Architecture, data models, API,    │
│       │                          security & performance             │
│       ▼                                                             │
│   /dugleelabs:spec:approve design  ← Human checkpoint               │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:tasks         Break down into actionable tasks   │
│       │                          with phases and dependencies       │
│       ▼                                                             │
│   /dugleelabs:spec:approve tasks  ← Human checkpoint                │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:implement     Execute tasks systematically       │
│       │                                                             │
│       ▼                                                             │
│   /dugleelabs:spec:github-sync   Sync to GitHub Projects (optional) │
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
| `/dugleelabs:spec:github-sync` | Sync tasks to GitHub Projects |

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
│   │   └── .github-sync.json   # GitHub sync state (if enabled)
│   └── 002-payment-flow/
│       └── ...
└── src/                        # Your actual code (separate repo supported)
```

## Spec Documents

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
- Technology stack decisions
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
- Actionable, specific items

## GitHub Projects Integration

Sync your tasks to a GitHub Project board for team visibility:

```bash
# First time: specify project number
/dugleelabs:spec:github-sync --project 1

# Subsequent syncs use saved project
/dugleelabs:spec:github-sync

# Preview changes without executing
/dugleelabs:spec:github-sync --dry-run
```

Task status flows bidirectionally:
- `- [ ]` in tasks.md → **Todo** in GitHub
- `- [x]` in tasks.md → **Done** in GitHub

## Best Practices

1. **Don't skip phases** - Each phase builds on the previous. Requirements inform design, design informs tasks.

2. **Be thorough in requirements** - The more detail here, the smoother implementation goes. Include edge cases, error scenarios, and acceptance criteria.

3. **Review before approving** - Use `/dugleelabs:spec:review` to get Claude's feedback on completeness before approving.

4. **Commit your specs** - Specifications are valuable documentation. Commit them alongside your code.

5. **One spec per feature** - Keep specifications focused. A "user authentication" spec shouldn't include "user profile management."

6. **Separate spec and code repos** - The implementation command supports working across multiple repositories.

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License - See [LICENSE](LICENSE) for details.

---

Built with Claude by [DugleeLabs](https://github.com/dugleelabs)
