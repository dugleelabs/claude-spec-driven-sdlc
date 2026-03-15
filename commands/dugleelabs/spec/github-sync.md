---
allowed-tools: Bash(gh:*), Bash(cat:*), Bash(test:*), Bash(grep:*), Bash(sed:*), Bash(date:*), Bash(md5:*), Read, Write, Edit, Glob
description: Sync approved tasks to GitHub Projects
argument-hint: [--project <number>] [--dry-run]
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`
gh authenticated: !`gh auth status 2>&1 | head -3`

## Arguments

$ARGUMENTS

## Prerequisites

Before syncing, verify ALL of these conditions:

1. **Active spec exists**: `spec/.current-spec` must exist
   - If not: Tell user "No active spec. Run `/dugleelabs:spec:switch` or `/dugleelabs:spec:new` first."

2. **Tasks approved**: `spec/<spec-id>/.tasks-approved` must exist
   - If not: Tell user "Tasks not approved. Run `/dugleelabs:spec:approve tasks` first."

3. **gh CLI authenticated**: `gh auth status` must succeed
   - If not: Tell user "GitHub CLI not authenticated. Run `gh auth login` first."

## Your Task

### Step 1: Parse Arguments

Parse `$ARGUMENTS` for:
- `--project <number>`: GitHub Project number (required on first sync, optional after)
- `--dry-run`: Preview changes without executing

### Step 2: Load or Create Sync State

Check for existing sync state file:
```
spec/<spec-id>/.github-sync.json
```

If exists and no `--project` provided, use saved project number.
If doesn't exist and no `--project` provided, list available projects:
```bash
gh project list --owner dugleelabs --format json
```
Then tell user to specify `--project <number>`.

### Step 3: Parse tasks.md

Read `spec/<spec-id>/tasks.md` and extract tasks. Generate task IDs using the compound key format:
```
{phase-slug}::{section-slug}::{task-slug}
```

For each task, capture:
- `id`: Generated compound key
- `title`: The task text (after `- [ ]` or `- [x]`)
- `status`: "pending" for `- [ ]`, "done" for `- [x]`
- `checksum`: MD5 of the task title (for change detection)

### Step 4: Determine Changes

Compare parsed tasks against `.github-sync.json`:
- **New tasks**: Not in sync state → need to create
- **Status changed (pending → done)**: Task marked complete in tasks.md → update GitHub to "Done"
- **Status changed (done → pending)**: Task reverted to pending in tasks.md → update GitHub to "Todo"
- **Title changed**: Different checksum → update title (if supported)
- **Unchanged tasks**: Same status and checksum → skip

### Step 5: Execute Sync (or Dry Run)

If `--dry-run`:
- Display what WOULD happen without making changes
- Show: "Would create X items, update Y items"

Otherwise, for each change:

**Create new draft item:**
```bash
gh project item-create <project-number> --owner dugleelabs --title "<task-title>" --format json
```

**Update item status** (requires GraphQL for custom fields):
```bash
# First get the project field IDs (cache these for the session)
gh project field-list <project-number> --owner dugleelabs --format json

# Extract Status field options:
# - "Todo" option ID (for pending tasks)
# - "Done" option ID (for completed tasks)

# Then update using GraphQL
gh api graphql -f query='
mutation {
  updateProjectV2ItemFieldValue(
    input: {
      projectId: "<project-node-id>"
      itemId: "<item-node-id>"
      fieldId: "<status-field-id>"
      value: { singleSelectOptionId: "<option-id>" }
    }
  ) {
    projectV2Item { id }
  }
}'
```

**Status update directions:**
- `pending → done`: Use "Done" option ID
- `done → pending`: Use "Todo" option ID (revert)

### Step 6: Update Sync State

Write updated `.github-sync.json`:
```json
{
  "project_number": <number>,
  "owner": "dugleelabs",
  "last_synced": "<ISO-8601-timestamp>",
  "tasks": {
    "<task-id>": {
      "title": "<task-title>",
      "project_item_id": "<PVTI_xxx>",
      "issue_number": null,
      "status": "pending|done",
      "checksum": "<md5-hash>"
    }
  }
}
```

### Step 7: Report Results

Display summary:
- Total tasks in tasks.md
- Items created
- Items marked Done (pending → done)
- Items reverted to Todo (done → pending)
- Items unchanged
- Link to GitHub Project

## Status Mapping

| tasks.md | GitHub Project Status |
|----------|----------------------|
| `- [ ]`  | Todo                 |
| `- [x]`  | Done                 |

**Bidirectional Sync:**
- Marking `- [ ]` → `- [x]` in tasks.md will update GitHub to "Done"
- Reverting `- [x]` → `- [ ]` in tasks.md will update GitHub back to "Todo"

## Error Handling

- **No active spec**: "No active spec. Run `/dugleelabs:spec:switch` or `/dugleelabs:spec:new` first."
- **Tasks not approved**: "Tasks not approved. Run `/dugleelabs:spec:approve tasks` first."
- **gh not authenticated**: "GitHub CLI not authenticated. Run `gh auth login` first."
- **Project not found**: List available projects and ask user to specify valid `--project <number>`
- **API errors**: Display the error and suggest checking permissions

## Task ID Generation Example

Given this tasks.md structure:
```markdown
## Phase 1: Foundation

### Backend Configuration
- [ ] Configure Strapi Users plugin
- [x] Set up JWT authentication
```

Generate IDs:
- `phase-1-foundation::backend-configuration::configure-strapi-users-plugin`
- `phase-1-foundation::backend-configuration::set-up-jwt-authentication`

Slugify rules:
1. Lowercase
2. Replace spaces with hyphens
3. Remove special characters except hyphens
4. Collapse multiple hyphens

## Important Notes

- Owner is hardcoded to `dugleelabs`
- Creates draft Project items (not Issues)
- Tracks state locally to enable incremental syncs
- Use `--dry-run` to preview changes safely
- **Supports reverting tasks**: If a task is changed from `[x]` back to `[ ]` in tasks.md, the sync will update GitHub Project status from "Done" back to "Todo"
- Source of truth is `tasks.md` - GitHub Project reflects the state in tasks.md
