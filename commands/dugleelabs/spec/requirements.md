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

### Optional: Project Tracker

After the "Current State" section, ask the user if they want to configure a project tracker now (or skip until sync time).

If yes, collect:
1. **Provider**: GitHub Projects or Linear
2. **Project**: Create new or use existing
3. **Provider-specific config**: owner (GitHub) or team key (Linear)

Persist the choices as an HTML comment block in the requirements document (invisible in rendered markdown):

```
<!-- sync-config
provider: linear
team_key: ENG
project: new
-->
```

This section is entirely optional — the user can skip and configure at sync time instead.

**Important:** The Current State section should capture:
- Repository links (main app, API/backend, shared libraries, design system)
- Tech stack (frontend, backend, database, hosting)
- Existing authentication mechanisms (if any)
- Security posture (HTTPS, compliance requirements, current measures)
- Engineering standards (API style, testing requirements, code review process)

Use the Write tool to create/update the requirements.md file.