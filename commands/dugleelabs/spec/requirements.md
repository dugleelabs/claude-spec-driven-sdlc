---
allowed-tools: Bash(cat:*), Bash(test:*), Bash(touch:*), Bash(ls:*), Write
description: Create or review requirements specification
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`

## Your Task

First, read the current spec name from `spec/.current-spec` and list the contents of that spec directory.

For the current active specification:

1. Check if requirements.md exists
2. If not, create a comprehensive requirements.md with:
   - Feature overview (problem statement, goals)
   - **Current State brief** (tech stack, existing auth, security posture, engineering standards) - Ask user to provide this context
   - User stories with acceptance criteria
   - Functional requirements (P0, P1, P2)
   - Non-functional requirements
   - Constraints and assumptions
   - Out of scope items
   - Success metrics
   - Open questions
3. If it exists, display current content and suggest improvements
4. Remind user to use `/dugleelabs:spec:approve requirements` when ready

**Important:** The Current State section should capture:
- Repository links (main app, API/backend, shared libraries, design system)
- Tech stack (frontend, backend, database, hosting)
- Existing authentication mechanisms (if any)
- Security posture (HTTPS, compliance requirements, current measures)
- Engineering standards (API style, testing requirements, code review process)

Use the Write tool to create/update the requirements.md file.