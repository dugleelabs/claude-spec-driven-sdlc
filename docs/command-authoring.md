# Command Authoring Contract

This document describes how to write slash commands compatible with Copair's small model intake system (introduced in copair 2.0.0 / spec 028 Phase B).

---

## The `args:` frontmatter contract

Every command that requires user-supplied context must declare its arguments in YAML frontmatter using `args:`. This allows Copair to collect missing arguments from the user before dispatching the command — critical for small models that cannot reliably infer context from natural language.

### Schema

```yaml
---
allowed-tools: Read, Write, Bash
description: One-line description shown in /commands
args:
  - name: my_arg
    description: "What to ask the user if this arg is missing"
    required: true
  - name: optional_arg
    description: "Optional: description shown in /help"
    required: false
    default: "fallback-value"
---
```

### Field reference

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | string | yes | Identifier used in `{{name}}` placeholders |
| `description` | string | no | Shown as the collection prompt for small models |
| `required` | boolean | no | `true` = collected if missing; `false` = skipped |
| `default` | string | no | Value substituted when arg is absent and not required |

### Placeholder syntax

Use `{{arg_name}}` in the command body wherever the argument value should appear:

```markdown
## Your Task

Feature context: {{feature_context}}

Create requirements for the feature described above.
```

The interpolation engine substitutes `{{feature_context}}` with the collected or passed value before sending the prompt to the agent. Unknown placeholders are left as-is (no error).

---

## `argument-hint` compatibility shim

Commands that were written before this contract used `argument-hint`:

```yaml
argument-hint: <feature-name>
```

Copair's command loader synthesizes a single non-required `ArgDefinition` from the hint text when `args:` is absent. The first word of the hint (after stripping `<>[]|` characters) becomes the arg name.

**The shim is a fallback only.** It does not produce required args, it does not support multiple args, and the synthesized name may be imprecise. Prefer `args:` for new commands.

### Migration

Replace:
```yaml
argument-hint: <feature-name>
```

With:
```yaml
args:
  - name: feature_name
    description: "Short kebab-case name for the feature"
    required: true
```

And replace `$ARGUMENTS` in the body with `{{feature_name}}`.

---

## Deprecation window

The `argument-hint` shim will remain in the loader indefinitely for backward compatibility with existing commands and external repositories. There is no removal date planned.

However, commands that use `argument-hint` will not benefit from:
- Small model sequential intake (missing args collected before dispatch)
- Correct `/help` argument listing
- Future intake features that build on `ArgDefinition`

---

## Large model behavior

For large models (non-small-model sessions), `dispatchWithIntake` calls `command.execute` directly without collecting any args. Required args that are absent remain absent — the command body receives an empty string for the missing placeholder. This preserves the existing behavior for capable models that can handle incomplete context through inference.

---

## Example: fully migrated command

**Before:**
```yaml
---
allowed-tools: Bash(ls:*), Read, Write
description: Create requirements specification
argument-hint: <feature-context>
---

Ask the user to provide context about the feature, then create requirements.md.
```

**After:**
```yaml
---
allowed-tools: Bash(ls:*), Read, Write
description: Create requirements specification
args:
  - name: feature_context
    description: "Brief context: what the feature does, the tech stack, any constraints"
    required: true
---

Feature context: {{feature_context}}

Create requirements.md based on the context above.
```
