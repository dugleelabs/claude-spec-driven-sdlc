# Directory Structure

```
your-project/
├── .claude/
│   └── commands/
│       └── dugleelabs/
│           └── spec/           # All spec commands live here
├── spec/
│   ├── .current-spec           # Tracks active specification
│   ├── 001-user-auth/
│   │   ├── README.md           # Spec overview and status
│   │   ├── requirements.md     # Requirements specification
│   │   ├── design.md           # Technical design document
│   │   ├── tasks.md            # Implementation checklist
│   │   └── .sync.json           # Sync state (if project tracker enabled)
│   └── 002-payment-flow/
│       └── ...
├── scripts/
│   └── tasks-sync/              # Project tracker sync scripts
│       ├── github/              # GitHub Projects API scripts
│       └── linear/              # Linear API scripts
├── .sync-config.json            # (Optional) Repo-level tracker defaults
└── src/                         # Your actual code (separate repo supported)
```
