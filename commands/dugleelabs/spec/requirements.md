---
allowed-tools: Bash(cat:*), Bash(test:*), Bash(touch:*), Bash(ls:*), Write
description: Create or review requirements specification
args:
  - name: feature_context
    description: "Brief context about the feature: what it does, the tech stack involved, and any relevant constraints"
    required: true
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`
Spec directory: !`ls spec/$(cat spec/.current-spec 2>/dev/null)/ 2>/dev/null || echo "(empty or not found)"`
Feature context: {{feature_context}}

## Your Task

The feature context above contains all project background you need. Do NOT ask the user for any additional context.

For the current active specification:

1. Check if `spec/<current-spec>/requirements.md` exists (use the spec directory listing shown above)
2. If not, create a comprehensive requirements.md using the Write tool with:
   - Feature overview (problem statement, goals) — derived from: {{feature_context}}
   - **Current State brief** — use the feature context verbatim: {{feature_context}}
   - User stories with acceptance criteria
   - Functional requirements (P0, P1, P2)
   - Non-functional requirements
   - Constraints and assumptions
   - Out of scope items
   - Success metrics
   - Open questions
3. If it exists, display current content and suggest improvements
4. Remind user to use `/dugleelabs:spec:approve requirements` when ready

Use the Write tool to create/update the requirements.md file. Do not ask the user any questions before writing.