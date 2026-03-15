---
allowed-tools: Bash(ls:*), Read, Write, Glob
description: Create implementation task list
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

## Your Task

1. Read the current spec name from `spec/.current-spec`
2. Read the spec's README.md to verify design phase is approved
3. Read requirements.md and design.md to understand the full scope
4. If design not approved, inform user to run `/dugleelabs:spec:approve design` first
5. If approved, create tasks.md with:
   - Overview with time estimates
   - Phase breakdown (Foundation, Core, Testing, Deployment)
   - Detailed task list with checkboxes
   - Task dependencies
   - Risk mitigation tasks
3. Each task should be specific and actionable
4. Use markdown checkboxes for parent tasks: `- [ ] **T-XX: Task description**`
5. Use markdown checkboxes for subtasks too: `- [ ] Subtask description` (indented under parent)
   - Subtask checkboxes are required for project tracker sync compatibility
   - Do NOT use plain-text bullets (`- text`) for subtasks

Organize tasks to enable incremental development and testing.