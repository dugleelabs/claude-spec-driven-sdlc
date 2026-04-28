---
allowed-tools: Bash(ls:*), Bash(echo:*), Bash(test:*)
description: Switch to a different specification
args:
  - name: spec_id
    description: "Spec directory name or ID to switch to (e.g. 028-copair-bug-fixes)"
    required: true
---

## Available Specifications

!`ls -d spec/*/ 2>/dev/null | sort`

## Your Task

Switch the active specification to: {{spec_id}}

1. Verify the spec directory exists
2. Update spec/.current-spec with the new spec directory name ([ID]-{{spec_id}})
3. Show the status of the newly active spec
4. Display next recommended action

If no argument provided, list all available specs.