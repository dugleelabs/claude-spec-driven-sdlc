---
name: spec-implement
description: Begin or continue implementation of an approved spec's tasks — sets up target repositories, manages git branches, and works through tasks.md sequentially, updating checkboxes as it goes. Use ONLY when the user explicitly asks to start, continue, or implement tasks (e.g. "start implementation", "begin implementing", "let's build phase 1", "continue the implementation"). Requires tasks to be approved.
---

# spec-implement

Drive implementation of the active spec's task list across target repositories.

## Preconditions

1. Read active spec: `cat spec/.current-spec`.
2. Verify tasks approved: check that `spec/<spec>/.tasks-approved` exists.
   - If not, tell the user: "Tasks are not approved. Run the `spec-approve` skill with phase `tasks` first." Then stop.
3. Read `spec/<spec>/requirements.md` to identify target repositories.
4. Read `spec/<spec>/tasks.md` to load the task list.

## Step 1 — Identify target repositories

The spec repository is separate from the code it describes. Parse `requirements.md` for repository names, URLs, or descriptions.

For each identified repository:
- Ask the user for the local path.
- Verify the path exists.
- Confirm the mapping before proceeding.

If no repositories are referenced, ask the user where implementation should happen.

## Step 2 — Git branch setup (per repository)

**Never implement directly on `main`.** For each target repo:

1. Check current branch: `git -C <repo-path> branch --show-current`.
2. Check for uncommitted changes: `git -C <repo-path> status --short`.

**If on `main`:**
- `git -C <repo-path> pull origin main`
- `git -C <repo-path> checkout -b feat/<spec-id>`
- Inform the user of the new branch.

**If on a non-main branch:**
- Ask: "In `<repo>` you're on `<branch>`. Continue here, or create a new branch?"
- If creating new, ask whether to branch from current or from main, and how to handle any uncommitted changes (stash / commit-and-push).
- Create the branch accordingly.

## Step 3 — Status display

Show the user:
- Spec ID and name
- Target repositories and their branches
- Total tasks vs completed
- Current phase (first phase with incomplete tasks)
- Next 5–10 incomplete tasks

If the user gave a phase argument (e.g. "phase 2"), focus on that phase only.

## Step 4 — Work through tasks

For each task in order within the current phase:

1. Show the task details and any subtasks.
2. Identify which target repository the task affects.
3. Implement the task in that repository.
4. After completing, update `tasks.md` in the SPEC repo: flip `- [ ]` to `- [x]` (use Edit, do not rewrite the whole file).
5. Suggest committing in the target repo when a logical unit of work is done.
6. Move to the next task.

## Guidelines

- Work tasks sequentially within a phase. Complete Phase N before starting Phase N+1.
- Update checkboxes IMMEDIATELY after each task completes — do not batch updates.
- Commit in the target repo with descriptive messages tied to the task ID where possible.
- If blocked, note the blocker in tasks.md (a sub-bullet under the task) and move on.
- If the user is using a tracker, the `spec-update-task` skill (or `spec-sync`) propagates checkbox changes.

## Notes

- Keep spec repo and target repos in sync; don't let task-completion drift from actual code state.
- If a task reveals the design was wrong, stop and surface it — don't silently reshape the work. The user may need to revise the design.
