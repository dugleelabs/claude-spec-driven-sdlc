---
allowed-tools: Bash(cat:*), Bash(grep:*), Read, Write
description: Mark a task as complete
args:
  - name: task
    description: "Task description or task ID to mark complete (e.g. T-A01 or 'create feature branch')"
    required: true
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`

## Your Task

First, read the tasks.md file from the current spec directory to see available tasks.

Then, update the task status for: "{{task}}"

1. Find the matching task in tasks.md
2. Change `- [ ]` to `- [x]` for that task
3. Show updated progress statistics
4. Suggest next task to work on

Use the Write tool to update the file.