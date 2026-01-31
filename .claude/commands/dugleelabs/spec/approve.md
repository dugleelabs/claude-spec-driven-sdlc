---
allowed-tools: Bash(ls:*), Read, Edit, Glob
description: Approve a specification phase
argument-hint: requirements|design|tasks
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

## Your Task

For the phase "$ARGUMENTS":

1. Read the current spec name from `spec/.current-spec`
2. List the spec directory contents using Glob or Bash ls
3. Verify the phase file exists (requirements.md, design.md, or tasks.md)
4. Update the phase file:
   - Change status from "Draft" to "Approved"
   - Mark approval checkboxes as complete
   - Add approval date
5. Update README.md:
   - Mark the phase as complete with checkmark
   - Update current phase to next phase
   - Update next steps
6. Inform user about next steps:
   - After requirements → run `/spec:design`
   - After design → run `/spec:tasks`
   - After tasks → run `/spec:implement`
7. If invalid phase name, show valid options: requirements, design, tasks