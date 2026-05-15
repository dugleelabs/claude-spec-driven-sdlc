# .sync.json formats

## GitHub provider

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

## Linear provider

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

## Legacy migration

If `.sync.json` does NOT exist but `.github-sync.json` exists:

1. Read `.github-sync.json`.
2. Transform to new format:
   - Add `"provider": "github"`
   - For each task: rename `project_item_id` → `item_id`, remove `issue_number`
   - Copy all other fields as-is (`project_number`, `owner`, `last_synced`)
3. Write as `.sync.json`.
4. **Keep `.github-sync.json` untouched** (do not delete).
5. Tell the user: "Migrated `.github-sync.json` → `.sync.json`."

If neither exists, start fresh with an empty task state.
