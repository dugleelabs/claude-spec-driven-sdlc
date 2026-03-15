---
allowed-tools: Bash(ls:*), Read, Write, Glob
description: Create technical design specification
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null`

## Your Task

1. Read the current spec name from `spec/.current-spec`
2. Read the spec's README.md to verify requirements phase is approved
3. Read requirements.md to understand what needs to be designed
4. If requirements not approved, inform user to run `/dugleelabs:spec:approve requirements` first
5. If approved, create/update design.md with:
   - Architecture overview (with diagrams)
   - Technology stack decisions
   - Data model and schema
   - API design
   - Security considerations
   - Performance considerations
   - Deployment architecture
   - Technical risks and mitigations
4. Use ASCII art or mermaid diagrams where helpful

Use the Write tool to create the design document.