# Summary

<!-- 1–3 bullets describing what this PR changes and why. Link the spec if applicable. -->

-

## Cross-adapter impact

This repo ships per-agent adapters under `agents/`. **If your change affects skill content or any documented install path, update every adapter it applies to and tick the box below.**

I updated affected adapter content in:

- [ ] `agents/anthropic/` (Claude Code)
- [ ] `agents/openai-codex/` (OpenAI Codex CLI)
- [ ] `agents/cursor/` (Cursor)
- [ ] N/A — this PR doesn't touch adapter content (docs/scripts/infra only)

## Test strategy

For PRs that touch adapter content or install paths:

- [ ] Cross-OS install: ran each affected adapter's `cp` command on **macOS** (verbatim from its README)
- [ ] Cross-OS install: ran each affected adapter's `cp` command on **Linux** (or noted "not tested" with reason)
- [ ] Cross-OS install: ran each affected adapter's `cp` command on **WSL2** (or noted "not tested" with reason)
- [ ] Smoke test on at least one affected adapter (invoke 2+ skills end-to-end in the agent's runtime)
- [ ] Acceptance greps:
  - [ ] `grep -rn "\bskills/" docs/ README.md *.md` returns zero non-historic hits
  - [ ] `grep -rn "install\.sh" docs/ README.md agents/ *.md` returns zero hits
  - [ ] `grep -rn "http://" agents/ README.md docs/` returns zero hits

For docs-only or infra-only PRs:

- [ ] Links resolve (no 404s in any markdown file you edited)
- [ ] N/A — neither adapter content nor install paths changed

## Related

<!-- Link spec(s), issue(s), or prior PR(s). -->

-
