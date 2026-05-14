# Directory Structure

```
your-project/
├── .claude/
│   └── skills/                    # Installed spec skills (copied from skills/)
│       ├── spec-new/
│       ├── spec-requirements/
│       ├── spec-design/
│       ├── spec-research/
│       ├── spec-tasks/
│       ├── spec-implement/
│       ├── spec-approve/
│       ├── spec-review/
│       ├── spec-status/
│       ├── spec-switch/
│       ├── spec-sync/
│       └── spec-update-task/
├── spec/
│   ├── .current-spec              # Tracks active specification
│   ├── 001-user-auth/
│   │   ├── README.md              # Spec overview and status
│   │   ├── requirements.md        # Requirements specification
│   │   ├── design.md              # Technical design (feature specs)
│   │   ├── research.md            # Research report (research specs — alternate to design.md)
│   │   ├── tasks.md               # Implementation checklist
│   │   ├── .requirements-approved # Phase-approval markers (gate downstream skills)
│   │   ├── .design-approved
│   │   ├── .research-approved
│   │   ├── .tasks-approved
│   │   └── .sync.json             # Sync state (if project tracker enabled)
│   └── 002-payment-flow/
│       └── ...
├── scripts/
│   └── tasks-sync/                # Project tracker sync scripts
│       ├── github/                # GitHub Projects API scripts
│       └── linear/                # Linear API scripts
├── .sync-config.json              # (Optional) Repo-level tracker defaults
└── src/                           # Your actual code (separate repo supported)
```

## Skill layout

Each skill follows the [Agent Skills spec](https://agentskills.io/specification):

```
spec-<name>/
├── SKILL.md           # required: YAML frontmatter (name + description) + instructions
└── references/        # optional: extended guidance loaded on demand
    └── *.md
```

Long-form skills (`spec-research`, `spec-review`, `spec-sync`) keep `SKILL.md` short and offload detail into their `references/` directories.
