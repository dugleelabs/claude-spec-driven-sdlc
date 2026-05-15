# Sync scripts reference

All scripts live under `scripts/tasks-sync/<provider>/`. They exit non-zero on failure with human-readable stderr.

## GitHub (`scripts/tasks-sync/github/`)

| Script | Usage | Output |
|---|---|---|
| `list-projects.sh` | `<owner>` | `[{ number, title, id }]` |
| `create-project.sh` | `<owner> <title>` | `{ number, title, id, url }` |
| `create-item.sh` | `<project-number> <owner> <title>` | `{ id, title }` |
| `get-field-ids.sh` | `<project-number> <owner>` | `{ project_node_id, status_field_id, todo_option_id, done_option_id }` |
| `update-status.sh` | `<project-node-id> <item-node-id> <field-id> <option-id>` | `{ id }` |

### Action → script mapping

| Action | Script |
|---|---|
| CREATE | `create-item.sh <project-number> <owner> "<title>"` |
| UPDATE_STATUS (pending→done) | `update-status.sh <project-node-id> <item-id> <field-id> <done-option-id>` |
| UPDATE_STATUS (done→pending) | `update-status.sh <project-node-id> <item-id> <field-id> <todo-option-id>` |

After CREATE, record the returned `id` as `item_id` in the task state.

## Linear (`scripts/tasks-sync/linear/`)

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

### Action → script mapping

| Action | Script |
|---|---|
| CREATE | `create-issue.sh <team-id> <project-id> <state-id> "<title>" [priority]` |
| CREATE_SUB | `create-sub-issue.sh <team-id> <project-id> <state-id> <parent-issue-id> "<title>" [priority]` |
| UPDATE_STATUS | `update-issue-state.sh <issue-id> <state-id>` |
| UPDATE_SUB_STATUS | `update-issue-state.sh <sub-issue-id> <state-id>` |

For UPDATE_STATUS / UPDATE_SUB_STATUS:
- `pending` → `todo_state_id` from `.sync.json.workflow_states.todo`
- `done` → `done_state_id` from `.sync.json.workflow_states.done`

After CREATE / CREATE_SUB, record `id` and `identifier` in the task state.

## Error handling

On script failure during sync:
1. Save partial state.
2. Report which task failed and the stderr message.
3. Abort remaining tasks.
4. Re-running picks up incrementally.
