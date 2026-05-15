# Project Tracker Sync

Sync your tasks to a project tracker for team visibility. Supports **GitHub Projects** and **Linear**, with a provider-based architecture that's extensible to other tools.

Just ask Claude — the `spec-sync` skill handles the rest:

```
You:    Sync this spec's tasks to Linear.
        → spec-sync fires, prompts for team and project on first run

You:    Sync to GitHub Projects, project 1.
        → spec-sync fires with provider=github

You:    Sync (subsequent runs).
        → spec-sync uses saved config from .sync.json — no extra info needed

You:    Show me what would change if I synced now.
        → spec-sync fires in dry-run mode
```

## How It Works

`tasks.md` is always the source of truth — the tracker reflects its state:

| tasks.md | GitHub Projects | Linear |
|---|---|---|
| `- [ ]` (pending) | Status: Todo | State: Todo (unstarted) |
| `- [x]` (done) | Status: Done | State: Done (completed) |

**Linear** syncs with hierarchy: parent tasks become issues, subtasks become sub-issues nested under the parent. Only parent issues appear on the project board.

**GitHub Projects** uses a flat model: all tasks (parents and subtasks) appear as individual draft items on the board.

## Configuration

The sync command resolves settings through a chain (first match wins):

```
CLI flag  →  .sync.json  →  requirements.md  →  .sync-config.json  →  prompt
```

You can optionally configure tracker preferences during the requirements phase, or let the sync command prompt you on first run. Once configured, settings are saved in `.sync.json` per spec — subsequent syncs need no flags.

### Repo-level Defaults (`.sync-config.json`)

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

### Linear Setup <a id="linear-setup"></a>

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

```
You:    Sync this spec to Linear.
        → spec-sync prompts for team and project on first run

You:    Sync to Linear team ENG.
        → spec-sync uses the named team directly
```

### GitHub Setup <a id="github-setup"></a>

```bash
# Ensure gh CLI is authenticated
gh auth login
```

Then sync:

```
You:    Sync to GitHub Projects in your-org, project 1.
        → spec-sync uses the named owner and project number
```

## Script Architecture

All API operations are implemented as standalone bash scripts in `scripts/tasks-sync/`. The `spec-sync` skill handles parsing, diffing, and decisions — scripts handle deterministic API calls. This saves tokens and makes operations reproducible.

### Companion-scripts copy (required for user-scope installs)

The skill expects `scripts/tasks-sync/<provider>/*.sh` at the **project root** of the repo you're working in. If you installed skills at **user scope** (e.g. `~/.claude/skills/` or `~/.agents/skills/`), the toolkit clone is the only place the scripts live — they need to be copied into each project where you want tracker sync:

```bash
# From the cloned toolkit repo root
cp -r scripts/tasks-sync /path/to/your/project/scripts/
```

Project-scope installs already have the scripts inside the cloned toolkit and don't need this step. The Cursor adapter doesn't support `spec-sync` in v1, so this isn't relevant for Cursor users.

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

## Adding New Providers

The sync system is designed to be extensible. To add a new provider:

1. Create `scripts/tasks-sync/<provider>/` with the required scripts:
   - `auth-check.sh` — validate credentials
   - `list-projects.sh` — list available projects
   - `create-project.sh` — create a new project
   - `create-issue.sh` — create an issue/item
   - `update-issue-state.sh` — update issue status
2. Add provider-specific sections to `agents/anthropic/skills/spec-sync/SKILL.md` (and the relevant `references/*.md` files), then mirror the change into `agents/openai-codex/skills/spec-sync/` and `agents/cursor/rules/spec-sync.mdc` (re-inlining references for the Cursor copy)
3. Add the provider option to the configuration resolution chain
