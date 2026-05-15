# Directory Structure

## Source repository layout (this repo)

```
ai-spec-driven-sdlc/
├── README.md                          # Top-level: positioning + agent support matrix
├── CHANGELOG.md                       # Release notes (Keep a Changelog format)
├── LICENSE
├── docs/
│   ├── directory-structure.md         # This file
│   ├── generated-artifacts.md
│   └── project-tracker-sync.md
├── scripts/
│   └── tasks-sync/                    # Companion bash scripts the spec-sync skill shells out to
│       ├── github/                    # GitHub Projects API scripts
│       └── linear/                    # Linear API scripts
└── agents/                            # Per-agent adapter folders (model-agnostic packaging)
    ├── anthropic/
    │   ├── README.md                  # Install + format docs for this adapter
    │   └── skills/                    # 12 spec-* skills in agentskills.io SKILL.md format
    │       ├── spec-new/
    │       ├── spec-requirements/
    │       ├── ... (10 more)
    ├── openai-codex/
    │   ├── README.md
    │   └── skills/                    # Identical content to anthropic/skills/ (Codex CLI uses the same format)
    │       └── ... (12 spec-* skills)
    └── cursor/
        ├── README.md
        └── rules/                     # 12 flat MDC files, references inlined
            ├── spec-new.mdc
            ├── spec-requirements.mdc
            └── ... (10 more)
```

Pick the adapter folder that matches your agent and run the `cp` command from its README. See the top-level [README support matrix](../README.md#supported-agents).

## Skill format (agentskills.io adapters)

The Anthropic and OpenAI Codex adapters use the [Agent Skills spec](https://agentskills.io/specification):

```
spec-<name>/
├── SKILL.md           # required: YAML frontmatter (name + description) + instructions
└── references/        # optional: extended guidance loaded on demand
    └── *.md
```

Long-form skills (`spec-research`, `spec-review`, `spec-sync`) keep `SKILL.md` short and offload detail into their `references/` directories. The Cursor adapter inlines those references into the MDC body because Cursor has no progressive-disclosure equivalent.

## Companion scripts pattern (`scripts/tasks-sync/`)

The `spec-sync` skill body references `scripts/tasks-sync/<provider>/*.sh` — a path relative to the **user's project root**, not the cloned toolkit. With user-scope installs, the skill is global but the scripts live only in the toolkit clone. Each `agentskills.io` adapter README documents a second `cp` step that copies `scripts/tasks-sync/` into the project where you want tracker sync:

```bash
cp -r scripts/tasks-sync /path/to/your/project/scripts/
```

Skip this step if you don't use `spec-sync`. The Cursor adapter does not support `spec-sync` in v1, so the companion-scripts copy is not relevant there.

## Installed layout in your project

```
your-project/
├── .claude/skills/                    # If installed via the Anthropic adapter (project scope)
│   └── spec-*/                        # 12 skill directories
├── .agents/skills/                    # If installed via the OpenAI Codex adapter (project scope)
│   └── spec-*/
├── .cursor/rules/                     # If installed via the Cursor adapter (project scope, only scope)
│   └── spec-*.mdc                     # 12 MDC files
├── spec/
│   ├── .current-spec                  # Tracks active specification
│   ├── 001-user-auth/
│   │   ├── README.md                  # Spec overview and status
│   │   ├── requirements.md            # Requirements specification
│   │   ├── design.md                  # Technical design (feature specs)
│   │   ├── research.md                # Research report (research specs — alternate to design.md)
│   │   ├── tasks.md                   # Implementation checklist
│   │   ├── .requirements-approved     # Phase-approval markers (gate downstream skills)
│   │   ├── .design-approved
│   │   ├── .research-approved
│   │   ├── .tasks-approved
│   │   └── .sync.json                 # Sync state (if project tracker enabled)
│   └── 002-payment-flow/
│       └── ...
├── scripts/
│   └── tasks-sync/                    # Optional — copy from this toolkit if using spec-sync at user scope
│       ├── github/
│       └── linear/
├── .sync-config.json                  # (Optional) Repo-level tracker defaults
└── src/                               # Your actual code (separate repo supported)
```
