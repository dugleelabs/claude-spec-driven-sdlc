---
allowed-tools: Bash(cat:*)
description: "[Deprecated] Use /dugleelabs:spec:sync instead"
argument-hint: [--project <number>] [--dry-run]
---

## Deprecation Notice

This command is deprecated. Use `/dugleelabs:spec:sync` instead.

Display this warning to the user:

> **Warning:** `/dugleelabs:spec:github-sync` is deprecated and will be removed in a future release. Use `/dugleelabs:spec:sync` instead. Your existing sync state will be migrated automatically.

Then tell the user to run:

```
/dugleelabs:spec:sync --provider github $ARGUMENTS
```
