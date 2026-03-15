---
allowed-tools: Bash(cat:*), Bash(grep:*), Read, Write
description: Mark a task as complete
argument-hint: <task-description-or-number>
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`

## Your Task

First, read the tasks.md file from the current spec directory to see available tasks.

Then, update the task status for: "$ARGUMENTS"

1. Find the matching task in tasks.md
2. Change `- [ ]` to `- [x]` for that task
3. Show updated progress statistics
4. Suggest next task to work on

Use the Write tool to update the file.