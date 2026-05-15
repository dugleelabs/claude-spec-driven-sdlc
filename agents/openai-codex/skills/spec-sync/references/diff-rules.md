# Task parsing, ID generation, and diff rules

## Parse rules

Read `spec/<spec>/tasks.md`:

1. **Phase header**: `## Phase N: Title` → used for slug generation
2. **Parent task**: `- [ ] **T-XX: Title**` or `- [x] **T-XX: Title**`
3. **Subtask**: indented `- [ ] Text` or `- [x] Text` under a parent
4. **Plain-text subtask** (backward compat): indented `- Text` with no checkbox → treated as pending (`[ ]`)

## Task ID generation

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
5. Strip leading / trailing hyphens

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

## Per-task captured fields

- `id` — generated compound key
- `title` — task text, cleaned (strip `**`, strip `T-XX:` prefix for display)
- `status` — `pending` for `[ ]`, `done` for `[x]`
- `checksum` — MD5 of the title text
- `subtasks` — array of subtask objects (same structure)

## Parent task diff

| Condition | Action |
|---|---|
| Task ID not in `.sync.json` | **CREATE** — new parent task |
| Task ID in state, status differs | **UPDATE_STATUS** — status changed |
| Task ID in state, checksum differs | **UPDATE_TITLE** — title changed (log only, no API update) |
| Task ID in state, same status + checksum | **SKIP** |
| Task ID in `.sync.json` but not in `tasks.md` | **ORPHAN** — mark `"orphaned": true`, warn user |

## Subtask diff (Linear only)

| Condition | Action |
|---|---|
| Subtask ID not in parent's `subtasks` | **CREATE_SUB** |
| Subtask ID in state, status differs | **UPDATE_SUB_STATUS** |
| Subtask ID in state, checksum differs | **UPDATE_SUB_TITLE** (log only) |
| Subtask ID in state, same | **SKIP** |
| Subtask ID in state but not in `tasks.md` | **ORPHAN_SUB** — mark orphaned, warn |

## Parent status derivation (Linear only)

After computing subtask changes, re-derive each parent's effective status:

```
if parent has subtasks:
    all subtasks [x] → parent effective status = "done"
    any subtask [ ]  → parent effective status = "pending"
else:
    parent's own [x] / [ ] → status directly
```

If derived parent status differs from `.sync.json`, add **UPDATE_STATUS** for the parent.

## GitHub provider — flat model

GitHub has no hierarchy. ALL items (parents + subtasks) are flat and independent:
- Each item's own `[ ]` / `[x]` drives its status
- No parent status derivation
- No CREATE_SUB — subtasks are just CREATE
- Task IDs still use the `::subtask-slug` suffix for uniqueness

## Priority mapping (Linear only)

When creating issues, derive priority from phase number:
- Phase 1 → `1` (Urgent)
- Phase 2 → `2` (High)
- Phase 3 → `3` (Normal)
- Phase 4+ → `4` (Low)

Pass as optional last arg to `create-issue.sh` / `create-sub-issue.sh`. If omitted, defaults to `0` (no priority).
