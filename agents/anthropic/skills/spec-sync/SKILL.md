---
name: spec-sync
description: Sync the active spec's approved tasks.md to a project tracker (GitHub Projects or Linear) — creates issues for new tasks, updates status on changes, flags orphans. Use ONLY when the user explicitly asks to sync, push, or mirror tasks to a tracker (e.g. "sync to Linear", "push tasks to GitHub Projects", "mirror to the tracker"). Requires tasks to be approved. tasks.md is the source of truth.
---

# spec-sync

Sync the active spec's tasks to GitHub Projects or Linear.

## Inputs (all optional, resolved through chain — see config-resolution.md)

- Provider: `github` or `linear`
- Project name (Linear) or number (GitHub)
- Team key (Linear)
- Owner / org (GitHub)
- `--dry-run` flag — preview without API calls
- `--status` flag — show current sync state without changes

If the user invoked the skill conversationally, parse these from their message. Otherwise pull from config files (see references).

## Preconditions

1. **Active spec exists**: read `spec/.current-spec`. If missing, tell user to run `spec-new` or `spec-switch`. Stop.
2. **Tasks approved**: check `spec/<spec>/.tasks-approved` exists. If not, tell user to run `spec-approve` with phase `tasks` first. Stop.

## Step 1 — Resolve configuration

Read `references/config-resolution.md`. Resolve provider, project, team/owner, workflow states / field IDs through the chain:

```
user input → .sync.json → requirements.md sync-config block → .sync-config.json → prompt user
```

Authenticate:
- GitHub: `gh auth status`. If unauthenticated → "Run `gh auth login` first."
- Linear: `scripts/tasks-sync/linear/auth-check.sh`. If fails → tell user how to set `LINEAR_API_KEY`.

## Step 2 — Parse tasks.md

Read `references/diff-rules.md` for parse rules, task-ID generation (`{phase-slug}::{task-slug}::{subtask-slug}`), and the parent/subtask diff logic.

## Step 3 — Load state, compute diff

Read `spec/<spec>/.sync.json` if it exists. If only the legacy `.github-sync.json` exists, migrate to the new format (see `state-formats.md`) and keep the legacy file untouched.

Compute the changeset against parsed tasks. Provider matters here:
- **Linear** preserves hierarchy: parent + subtasks. Parent status is derived from subtask completeness.
- **GitHub Projects** is flat: each item drives its own status independently. No CREATE_SUB action.

## Step 4 — Execute

If `--status`: show current state from `.sync.json`, no API calls.

If `--dry-run`: show the full changeset table (action, task ID, title), summary counts. No API calls. No state writes.

Otherwise execute each action via the matching script in `scripts/tasks-sync/<provider>/`. Script reference and arg shapes are in `references/scripts.md`.

**On script failure** (non-zero exit):
1. Save partial state to `.sync.json`.
2. Report which task failed and the stderr message.
3. Abort remaining tasks.
4. Tell user: "Sync partially completed. Re-run to continue from where it left off."

## Step 5 — Write state

After successful execution, write `spec/<spec>/.sync.json` (format in `references/state-formats.md`). Orphaned tasks get `"orphaned": true` — never delete tracker items, only flag.

## Step 6 — Report

```
Sync complete — <provider> / <project-name>

  Created:   X items
  Updated:   Y items
  Skipped:   Z items (unchanged)
  Orphaned:  W items (removed from tasks.md, kept in provider)

  Last synced: <timestamp>
```

List orphaned items by identifier and title if any.

## Invariants

- `tasks.md` is the source of truth. The provider mirrors its state.
- One provider per spec. If `.sync.json` provider differs from requested, warn and abort.
- API keys are never written to `.sync.json` or any committed file.
- Orphaned items are flagged, never deleted from the provider.
- Re-running after failure continues from where it left off (incremental diff).

## Files

- `references/config-resolution.md` — resolution chain, sync-config block format
- `references/diff-rules.md` — task parsing, ID generation, parent/subtask diff actions
- `references/state-formats.md` — GitHub and Linear `.sync.json` shapes, legacy migration
- `references/scripts.md` — script reference for both providers
