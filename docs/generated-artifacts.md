# Generated Artifacts

Each specification produces three core documents that build on each other through the workflow phases. All three follow the same MVP-first discipline: P0 scope stays minimal, deferred ideas are recorded (not dropped), and sections that don't apply say why instead of filling in boilerplate.

## requirements.md
- Summary — the problem, who has it, what the MVP delivers
- Context & current state, grounded in repo/system facts
- Goals and non-goals
- User stories (US-XX) with attached acceptance criteria
- Functional requirements (F-XX, P0/P1/P2 priority — P0 alone is a shippable MVP)
- Non-functional requirements (NF-XX) with concrete, MVP-realistic values
- Constraints, assumptions, out-of-scope and future iterations
- Success metrics and open questions (OQ-XX)

## design.md
- Overview and architecture diagram with component breakdown
- Design decisions record — options considered, choice, rationale
- Data model, API/interface contracts, and data flows (where applicable)
- Security scoped to the feature's actual threat surface
- Numeric performance targets; reliability and operations approach
- Future considerations — what the MVP defers and how the design accommodates it
- Technical risks and mitigations

## tasks.md
- Phase-organized breakdown; Phase 1 delivers a runnable walking skeleton
- Checkbox format with task IDs (T-XX), S/M sizing, and `Done when:` criteria
- Testing tasks inside each phase, next to the code they verify
- Traceability table mapping every requirement to its tasks
- Dependencies and risk-mitigation tasks
