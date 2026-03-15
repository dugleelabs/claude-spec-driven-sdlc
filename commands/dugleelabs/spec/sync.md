---
allowed-tools: Bash(scripts/tasks-sync/*), Bash(cat:*), Bash(test:*), Bash(md5:*), Bash(date:*), Bash(jq:*), Read, Write, Edit, Glob
description: Sync approved tasks to project tracker (GitHub Projects or Linear)
argument-hint: [--provider <github|linear>] [--project <name|number>] [--team <key>] [--owner <org>] [--dry-run]
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

## Arguments

$ARGUMENTS

## Prerequisites

Before syncing, verify ALL of these conditions:

1. **Active spec exists**: `spec/.current-spec` must exist and be non-empty
   - If not: Tell user "No active spec. Run `/dugleelabs:spec:switch` or `/dugleelabs:spec:new` first."

2. **Tasks approved**: `spec/<spec-id>/.tasks-approved` must exist
   - If not: Tell user "Tasks not approved. Run `/dugleelabs:spec:approve tasks` first."

## Step 1: Parse Arguments

Parse `$ARGUMENTS` for these flags:
- `--provider <github|linear>`: Project tracker provider
- `--project <name|number>`: Project to sync to (name for Linear, number for GitHub)
- `--team <key>`: Linear team key (e.g., `ENG`)
- `--owner <org>`: GitHub organization (e.g., `dugleelabs`)
- `--dry-run`: Preview changes without executing
- `--status`: Show current sync state without making changes

## Step 2: Resolve Configuration

Resolve each setting independently through this chain (first match wins):

```
CLI flag  →  .sync.json  →  requirements.md  →  .sync-config.json  →  prompt user
```

### 2a: Provider (mandatory)

1. Check `--provider` flag
2. Check `spec/<spec-id>/.sync.json` → `provider` field
3. Check `spec/<spec-id>/requirements.md` for `<!-- sync-config` block → `provider` field
4. Check `.sync-config.json` at repo root → `default_provider` field
5. If none found: ask user to choose GitHub or Linear

### 2b: Authenticate

**GitHub provider:**
- Run `gh auth status` to verify GitHub CLI is authenticated
- If not: Tell user "GitHub CLI not authenticated. Run `gh auth login` first."

**Linear provider:**
- Run: `scripts/tasks-sync/linear/auth-check.sh`
- If fails: Tell user "Linear API key not configured. Either create `~/.config/linear/credentials` with `LINEAR_API_KEY=lin_api_xxxxx`, or set the `LINEAR_API_KEY` environment variable."

### 2c: Owner / Team

**GitHub:**
1. `--owner` flag
2. `.sync.json` → `owner`
3. `requirements.md` sync-config → `owner`
4. `.sync-config.json` → `github.owner`
5. Prompt user

**Linear:**
1. `--team` flag
2. `.sync.json` → `team_key`
3. `requirements.md` sync-config → `team_key`
4. `.sync-config.json` → `linear.team_key`
5. If none: run `scripts/tasks-sync/linear/list-teams.sh` and show list for user to choose

When a Linear team is selected by key, resolve the team ID:
- Run `scripts/tasks-sync/linear/list-teams.sh`, find the team by key, extract the `id`

### 2d: Project Binding

1. `--project` flag
2. `.sync.json` → `project_id` (Linear) or `project_number` (GitHub)
3. `requirements.md` sync-config → `project` field
4. If none found, ask user:
   - **Create new**: Create a project named after the spec title (from `spec/<spec-id>/README.md`, first `# Heading`)
     - GitHub: `scripts/tasks-sync/github/create-project.sh <owner> "<spec-title>"`
     - Linear: `scripts/tasks-sync/linear/create-project.sh "<spec-title>" <team-id>`
   - **Use existing**: List available projects for selection
     - GitHub: `scripts/tasks-sync/github/list-projects.sh <owner>`
     - Linear: `scripts/tasks-sync/linear/list-projects.sh <team-id>`

### 2e: Workflow States (Linear only)

If Linear and workflow states not cached in `.sync.json`:
- Run: `scripts/tasks-sync/linear/get-workflow-states.sh <team-id>`
- Cache `todo_state_id` and `done_state_id` in `.sync.json`

### 2f: Field IDs (GitHub only)

If GitHub and field IDs not cached in `.sync.json`:
- Run: `scripts/tasks-sync/github/get-field-ids.sh <project-number> <owner>`
- Cache `project_node_id`, `status_field_id`, `todo_option_id`, `done_option_id` in `.sync.json`

### Parsing the `<!-- sync-config -->` block

In `requirements.md`, look for an HTML comment block:

```
<!-- sync-config
provider: linear
team_key: ENG
project: new
-->
```

Parse each `key: value` line. Fields: `provider`, `team_key`, `owner`, `project`.

## Step 3: Parse tasks.md

Read `spec/<spec-id>/tasks.md` and extract all tasks.

### Parse Rules

1. **Phase header**: `## Phase N: Title` → used for slug generation
2. **Parent task**: `- [ ] **T-XX: Title**` or `- [x] **T-XX: Title**` → parent task
3. **Subtask**: Indented `- [ ] Text` or `- [x] Text` under a parent → subtask
4. **Plain-text subtask** (backward compat): Indented `- Text` with no checkbox → treated as pending (`[ ]`)

### Task ID Generation

Compound key format:
```
{phase-slug}::{task-slug}
```

Subtask IDs extend the parent:
```
{phase-slug}::{task-slug}::{subtask-slug}
```

**Slugify rules:**
1. Lowercase
2. Replace spaces with hyphens
3. Remove special characters except hyphens
4. Collapse multiple hyphens
5. Strip leading/trailing hyphens

**Example:**
```markdown
## Phase 1: Foundation

- [ ] **T-01: Create script directory structure**
  - [ ] Create github directory
  - [ ] Create linear directory
```

Generates:
- Parent: `phase-1-foundation::t-01-create-script-directory-structure`
- Subtask: `phase-1-foundation::t-01-create-script-directory-structure::create-github-directory`
- Subtask: `phase-1-foundation::t-01-create-script-directory-structure::create-linear-directory`

### For each task, capture:
- `id`: Generated compound key
- `title`: The task text (cleaned — remove `**`, `T-XX:` prefix for display)
- `status`: `pending` for `[ ]`, `done` for `[x]`
- `checksum`: MD5 of the title text
- `subtasks`: Array of subtask objects (same structure)

## Step 4: Load Sync State

### If `.sync.json` exists:
Read it. Verify `provider` matches current provider.
- If mismatch: warn user and abort. A spec can only sync to one provider.

### If `.sync.json` does NOT exist but `.github-sync.json` exists:
**Migrate** the old format:
1. Read `.github-sync.json`
2. Transform to new format:
   - Add `"provider": "github"`
   - For each task in `tasks`: rename `project_item_id` → `item_id`, remove `issue_number`
   - Copy all other fields as-is (`project_number`, `owner`, `last_synced`)
3. Write as `.sync.json`
4. **Keep `.github-sync.json` untouched** (do not delete)
5. Inform user: "Migrated `.github-sync.json` → `.sync.json`"

### If neither exists:
Start fresh — empty task state.

## Step 5: Compute Diff

Compare parsed tasks against `.sync.json` state to produce a changeset.

### Parent Task Diff

| Condition | Action |
|---|---|
| Task ID not in `.sync.json` | **CREATE** — new parent task |
| Task ID in state, status differs | **UPDATE_STATUS** — status changed |
| Task ID in state, checksum differs | **UPDATE_TITLE** — title changed (log only, no API update) |
| Task ID in state, same status + checksum | **SKIP** — unchanged |
| Task ID in `.sync.json` but not in `tasks.md` | **ORPHAN** — mark `"orphaned": true` in state, warn user |

### Subtask Diff (Linear provider only)

| Condition | Action |
|---|---|
| Subtask ID not in parent's `subtasks` | **CREATE_SUB** — new subtask |
| Subtask ID in state, status differs | **UPDATE_SUB_STATUS** — subtask status changed |
| Subtask ID in state, checksum differs | **UPDATE_SUB_TITLE** — title changed (log only) |
| Subtask ID in state, same | **SKIP** |
| Subtask ID in state but not in `tasks.md` | **ORPHAN_SUB** — mark orphaned, warn user |

### Parent Status Derivation (Linear provider only)

After computing subtask changes, re-derive each parent's effective status:

```
if parent has subtasks:
    all subtasks [x] → parent effective status = "done"
    any subtask [ ]  → parent effective status = "pending"
else:
    parent's own [x]/[ ] → status directly
```

If derived parent status differs from `.sync.json`, add **UPDATE_STATUS** for the parent.

### GitHub Provider (Flat Model)

For GitHub, there is **no hierarchy**. ALL items (parents + subtasks) are treated as flat, independent items:
- Each item's own `[ ]`/`[x]` checkbox drives its status
- No parent status derivation
- No CREATE_SUB — subtasks are just CREATE (same as parents)
- Task IDs still use the `::subtask-slug` suffix for uniqueness

## Step 6: Execute (or Dry Run)

### Status Mode

If `--status` was specified:
- Read `.sync.json` for the current spec
- If no `.sync.json`: tell user "No sync state found. Run `/dugleelabs:spec:sync` first."
- Display:
  - Provider and project name
  - Last synced timestamp
  - Task counts: pending, done, orphaned
- **No API calls. No state changes.**
- Exit after displaying.

### Dry Run Mode

If `--dry-run` was specified:
- Display the full changeset as a table: action, task ID, title
- Show summary counts: create, update, skip, orphan
- **Make no API calls. Do not write `.sync.json`.**
- Exit after displaying.

### Execute Mode

Process the changeset in order. For each action, call the appropriate script:

**GitHub provider:**

| Action | Script |
|---|---|
| CREATE | `scripts/tasks-sync/github/create-item.sh <project-number> <owner> "<title>"` |
| UPDATE_STATUS (pending→done) | `scripts/tasks-sync/github/update-status.sh <project-node-id> <item-id> <field-id> <done-option-id>` |
| UPDATE_STATUS (done→pending) | `scripts/tasks-sync/github/update-status.sh <project-node-id> <item-id> <field-id> <todo-option-id>` |

After CREATE, record the returned `id` as `item_id` in the task state.

**Linear provider:**

| Action | Script |
|---|---|
| CREATE | `scripts/tasks-sync/linear/create-issue.sh <team-id> <project-id> <state-id> "<title>" [priority]` |
| CREATE_SUB | `scripts/tasks-sync/linear/create-sub-issue.sh <team-id> <project-id> <state-id> <parent-issue-id> "<title>" [priority]` |
| UPDATE_STATUS | `scripts/tasks-sync/linear/update-issue-state.sh <issue-id> <state-id>` |
| UPDATE_SUB_STATUS | `scripts/tasks-sync/linear/update-issue-state.sh <sub-issue-id> <state-id>` |

For UPDATE_STATUS/UPDATE_SUB_STATUS:
- `pending` → use `todo_state_id` from `.sync.json` → `workflow_states.todo`
- `done` → use `done_state_id` from `.sync.json` → `workflow_states.done`

**Priority mapping (Linear only):** When creating issues, derive priority from the phase number:
- Phase 1 → `1` (Urgent)
- Phase 2 → `2` (High)
- Phase 3 → `3` (Normal)
- Phase 4+ → `4` (Low)

Pass as the optional last argument to `create-issue.sh` / `create-sub-issue.sh`. If omitted, defaults to `0` (no priority).

After CREATE/CREATE_SUB, record `id`, `identifier` in the task state.

### Error Handling During Execution

If a script fails (non-zero exit):
1. **Save partial state** — write `.sync.json` with all tasks synced so far
2. **Report the error** — show which task failed and the stderr message
3. **Abort** — stop processing remaining tasks
4. **Inform user** — "Sync partially completed. Re-run to continue from where it left off."

## Step 7: Write Sync State

After all actions complete successfully, write `spec/<spec-id>/.sync.json`.

**GitHub format:**
```json
{
  "provider": "github",
  "project_number": 5,
  "owner": "dugleelabs",
  "project_node_id": "PVT_xxx",
  "status_field_id": "PVTSSF_xxx",
  "status_options": {
    "todo": "xxx",
    "done": "yyy"
  },
  "last_synced": "2026-03-15T10:00:00Z",
  "tasks": {
    "<task-id>": {
      "title": "T-01: ...",
      "item_id": "PVTI_xxx",
      "status": "pending",
      "checksum": "abc123"
    }
  }
}
```

**Linear format:**
```json
{
  "provider": "linear",
  "team_id": "uuid",
  "team_key": "ENG",
  "project_id": "uuid",
  "project_name": "Linear Sync",
  "workflow_states": {
    "todo": "uuid-unstarted",
    "done": "uuid-completed"
  },
  "last_synced": "2026-03-15T10:00:00Z",
  "tasks": {
    "<task-id>": {
      "title": "T-01: ...",
      "item_id": "uuid-issue",
      "identifier": "ENG-42",
      "status": "pending",
      "checksum": "abc123",
      "subtasks": {
        "<subtask-id>": {
          "title": "Create migration file",
          "item_id": "uuid-sub",
          "identifier": "ENG-43",
          "status": "done",
          "checksum": "def456"
        }
      }
    }
  }
}
```

Orphaned tasks have `"orphaned": true` added to their entry.

## Step 8: Report Results

Display a summary:

```
Sync complete — <provider> / <project-name>

  Created:   X items
  Updated:   Y items
  Skipped:   Z items (unchanged)
  Orphaned:  W items (removed from tasks.md, kept in provider)

  Last synced: <timestamp>
```

If any orphans were found, list them:
```
Orphaned items (still in <provider>, removed from tasks.md):
  - <identifier>: <title>
```

## Script Reference

### GitHub Scripts (`scripts/tasks-sync/github/`)

| Script | Usage | Output |
|---|---|---|
| `list-projects.sh` | `<owner>` | `[{ number, title, id }]` |
| `create-project.sh` | `<owner> <title>` | `{ number, title, id, url }` |
| `create-item.sh` | `<project-number> <owner> <title>` | `{ id, title }` |
| `get-field-ids.sh` | `<project-number> <owner>` | `{ project_node_id, status_field_id, todo_option_id, done_option_id }` |
| `update-status.sh` | `<project-node-id> <item-node-id> <field-id> <option-id>` | `{ id }` |

### Linear Scripts (`scripts/tasks-sync/linear/`)

| Script | Usage | Output |
|---|---|---|
| `auth-check.sh` | (no args) | `{ id, name }` |
| `list-teams.sh` | (no args) | `[{ id, name, key }]` |
| `list-projects.sh` | `<team-id>` | `[{ id, name, state }]` |
| `create-project.sh` | `<name> <team-id>` | `{ id, name }` |
| `get-workflow-states.sh` | `<team-id>` | `{ todo_state_id, todo_state_name, done_state_id, done_state_name }` |
| `create-issue.sh` | `<team-id> <project-id> <state-id> <title> [priority]` | `{ id, identifier, title }` |
| `create-sub-issue.sh` | `<team-id> <project-id> <state-id> <parent-id> <title> [priority]` | `{ id, identifier, title, parent_id }` |
| `update-issue-state.sh` | `<issue-id> <state-id>` | `{ id, identifier, state_name }` |

### Script Error Handling

- All scripts exit non-zero on failure
- Error messages go to stderr (human-readable)
- On script failure during sync: save partial state, report error, abort

## Important Notes

- Source of truth is always `tasks.md` — the provider reflects its state
- One provider per spec (a spec syncs to either GitHub or Linear, not both)
- API keys are never written to `.sync.json` or any committed file
- Orphaned items are never deleted from the provider — only flagged in state
- Re-running sync after a failure continues from where it left off (incremental diff)
