# Configuration resolution

Each setting is resolved independently through this chain (first match wins):

```
user input  →  .sync.json  →  requirements.md sync-config block  →  .sync-config.json  →  prompt user
```

## Provider (mandatory)

1. User input (e.g. "sync to linear")
2. `spec/<spec>/.sync.json` → `provider` field
3. `spec/<spec>/requirements.md` → `<!-- sync-config -->` block → `provider` field
4. `.sync-config.json` at repo root → `default_provider` field
5. Ask user: GitHub or Linear

## Owner / Team

**GitHub:**
1. User input
2. `.sync.json` → `owner`
3. `requirements.md` sync-config → `owner`
4. `.sync-config.json` → `github.owner`
5. Prompt user

**Linear:**
1. User input
2. `.sync.json` → `team_key`
3. `requirements.md` sync-config → `team_key`
4. `.sync-config.json` → `linear.team_key`
5. Run `scripts/tasks-sync/linear/list-teams.sh` and ask user to choose

When a Linear team key is provided, resolve the team ID by running `list-teams.sh` and matching.

## Project Binding

1. User input
2. `.sync.json` → `project_id` (Linear) or `project_number` (GitHub)
3. `requirements.md` sync-config → `project` field
4. Ask user:
   - **Create new** — name = spec title (from `spec/<spec>/README.md`, first `# Heading`)
     - GitHub: `scripts/tasks-sync/github/create-project.sh <owner> "<title>"`
     - Linear: `scripts/tasks-sync/linear/create-project.sh "<title>" <team-id>`
   - **Use existing** — list and choose
     - GitHub: `scripts/tasks-sync/github/list-projects.sh <owner>`
     - Linear: `scripts/tasks-sync/linear/list-projects.sh <team-id>`

## Workflow States (Linear only)

If not cached in `.sync.json`:
- Run `scripts/tasks-sync/linear/get-workflow-states.sh <team-id>`
- Cache `todo_state_id` and `done_state_id` in `.sync.json`

## Field IDs (GitHub only)

If not cached in `.sync.json`:
- Run `scripts/tasks-sync/github/get-field-ids.sh <project-number> <owner>`
- Cache `project_node_id`, `status_field_id`, `todo_option_id`, `done_option_id`

## requirements.md sync-config block

```html
<!-- sync-config
provider: linear
team_key: ENG
project: new
-->
```

Parse each `key: value` line. Fields: `provider`, `team_key`, `owner`, `project`.
