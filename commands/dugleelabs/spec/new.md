---
allowed-tools: Bash(mkdir:*), Bash(echo:*), Bash(date:*), Bash(ls:*)
description: Create a new feature specification
args:
  - name: feature_name
    description: "Short kebab-case name for the new feature (e.g. user-auth, payment-flow)"
    required: true
---

## Current Spec Status

Existing specs: !`ls spec/ 2>/dev/null || echo "No spec directory"`
Today's date: !`date +%Y-%m-%d`

## Your Task

Create a new specification directory for the feature: {{feature_name}}

1. Determine the next ID number (format: 001, 002, etc.)
2. Create directory: `spec/[ID]-{{feature_name}}/`
3. Update `spec/.current-spec` with the new spec directory name ([ID]-{{feature_name}})
4. Create a README.md in the new directory with:
   - Feature name: {{feature_name}}
   - Creation date: use the "Today's date" value shown above
   - Initial status checklist
5. Inform the user about next steps

Use the Bash tool to create directories and files as needed.