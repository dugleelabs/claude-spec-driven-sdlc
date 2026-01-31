---
allowed-tools: Bash(ls:*), Read, Glob, Grep
description: Show all specifications and their status
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "None"`

## Your Task

1. List all spec directories using `ls spec/` or Glob `spec/*/`
2. For each spec directory:
   - Read README.md to get status and phase completion
   - Check which phase files exist (requirements.md, design.md, tasks.md)
   - If tasks.md exists, count completed vs total tasks
3. Present a clear status report showing:
   - All specifications with their IDs and names
   - Current active spec (highlighted)
   - Phase completion status for each spec (Requirements → Design → Tasks → Implementation)
   - Task progress percentage if applicable
   - Recommended next action for active spec

Format the output as a clear table or structured list.