---
allowed-tools: Read, Glob, Grep, Edit, Write, Bash
description: Start implementation from approved tasks
argument-hint: [phase-number]
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`
Spec repository: This repository contains only specifications, not implementation code.

## Arguments

$ARGUMENTS

## Your Task

### Step 1: Load Spec Context

1. Read `spec/.current-spec` to get the active spec ID
2. Verify `spec/<spec-id>/.tasks-approved` exists
   - If not: Tell user "Tasks not approved. Run `/spec:approve tasks` first."
3. Read `spec/<spec-id>/requirements.md` to identify target repositories
4. Read `spec/<spec-id>/tasks.md` to get the task list

### Step 2: Identify Target Repositories

**IMPORTANT:** The spec repository is separate from code repositories.

1. Parse `requirements.md` to find repository references:
   - Look for repository names, URLs, or descriptions in the requirements
   - Repositories are typically specified during the requirements phase

2. For each identified repository:
   - Ask user for the local path to the repository
   - Verify the path exists
   - Store the mapping for use during implementation

3. Confirm all target repositories with the user before proceeding

### Step 3: Git Branch Setup (Per Repository)

**IMPORTANT: Never implement directly on the `main` branch in any repository.**

For EACH target repository that will be modified:

1. Check current branch: `git -C <repo-path> branch --show-current`
2. Check for uncommitted changes: `git -C <repo-path> status --short`

**If on `main` branch:**
- Pull latest: `git -C <repo-path> pull origin main`
- Create implementation branch: `git -C <repo-path> checkout -b feat/<spec-id>`
- Inform user of the new branch

**If on a different branch:**
- Ask user: "In `<repo-name>`, you're on branch `<branch-name>`. Do you want to:"
  - Continue on this branch (Recommended if already working on this feature)
  - Create a new branch

**If user wants to create a new branch:**

1. Ask: "Create new branch from:"
   - **Current branch** (`<branch-name>`) - Keeps current context
   - **Main branch** - Fresh start from latest main

2. If there are uncommitted changes, ask how to handle them:
   - **Stash** - Stash changes (can restore later)
   - **Commit & Push** - Commit to current branch and push before switching

3. Create the new branch:
   - If from current: `git -C <repo-path> checkout -b feat/<spec-id>`
   - If from main:
     - `git -C <repo-path> checkout main && git -C <repo-path> pull origin main`
     - `git -C <repo-path> checkout -b feat/<spec-id>`

### Step 4: Display Current Status

Show the user:
- Spec name and ID
- Target repositories and their current branches
- Total tasks vs completed tasks
- Current phase (first phase with incomplete tasks)
- Next 5-10 incomplete tasks to work on

### Step 5: Begin Implementation

If phase number provided in arguments, focus on that phase only.

For each task:
1. Show the task details and any sub-items
2. Identify which repository this task affects based on task context
3. Implement the task in the correct repository
4. After completing, update `tasks.md` in the SPEC repository to mark task as done: `- [ ]` → `- [x]`
5. Optionally run `/spec:update-task T-XXX` to mark complete and sync to GitHub

### Step 6: Progress Tracking

After each completed task:
- Show updated progress (X of Y tasks complete)
- Suggest committing changes in the target repository if significant work done
- Move to next task

### Implementation Guidelines

- Work on tasks sequentially within each phase
- Complete Phase N before moving to Phase N+1
- Update task checkboxes in spec repo immediately after completing each task
- Commit changes in target repositories regularly with descriptive messages
- If blocked on a task, note the blocker and move to next task
- Keep spec repository and implementation repositories in sync

Start by reading the requirements.md and tasks.md to identify target repositories!
