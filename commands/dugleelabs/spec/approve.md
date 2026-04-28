---
allowed-tools: Bash(ls:*), Read, Edit, Glob
description: Approve a specification phase
args:
  - name: phase
    description: "Phase to approve: requirements, design, research, or tasks"
    required: true
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

## Your Task

For the phase "{{phase}}":

1. Read the current spec name from `spec/.current-spec`
2. List the spec directory contents using Glob or Bash ls
3. Verify the phase file exists (requirements.md, design.md, research.md, or tasks.md)
4. Update the phase file:
   - Change status from "Draft" to "Approved"
   - Mark approval checkboxes as complete
   - Add approval date
5. Update README.md:
   - Mark the phase as complete with checkmark
   - Update current phase to next phase
   - Update next steps
6. Inform user about next steps:
   - After requirements → run `/dugleelabs:spec:design` (feature specs) or `/dugleelabs:spec:research` (research specs — competitive scans, roadmap research, strategy reviews)
   - After design → run `/dugleelabs:spec:tasks`
   - After research → no tasks phase. For each candidate classified as "pillar" or "feature worth pursuing" in `research.md`, create a follow-up spec via `/dugleelabs:spec:new <name>`.
   - After tasks → run `/dugleelabs:spec:implement`
7. If invalid phase name, show valid options: requirements, design, research, tasks