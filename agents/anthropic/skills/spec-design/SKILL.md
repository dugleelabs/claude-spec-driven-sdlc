---
name: spec-design
description: Draft or revise the design.md document for the active specification — architecture, data model, API design, security, performance, deployment, risks. For feature specs that produce code. Use ONLY when the user explicitly asks to draft/write/update the design after requirements are approved (e.g. "write the design doc", "design this", "let's design the architecture"). For research-style specs, use spec-research instead.
---

# spec-design

Author the technical design document for the active feature spec.

## Preconditions

1. Read active spec: `cat spec/.current-spec`.
2. Verify requirements are approved: check that `spec/<spec>/.requirements-approved` exists.
   - If not, tell the user: "Requirements are not approved. Run the `spec-approve` skill with phase `requirements` first." Then stop.
3. Read `spec/<spec>/requirements.md` fully to understand what is being designed.
4. Read `spec/<spec>/README.md` for spec context.

## Steps

1. If `spec/<spec>/design.md` already exists, read it and make targeted edits via Edit. Do not rewrite blindly.
2. If it does not exist, create `spec/<spec>/design.md` with these sections:
   - **Status** — `Draft`
   - **Architecture Overview** — high-level system diagram (ASCII or mermaid)
   - **Component Breakdown** — major components, responsibilities, boundaries
   - **Data Flow** — how data moves through the system
   - **Technology Stack** — choices with rationale tied back to requirements
   - **Data Model** — schemas, entities, relationships (ERD where helpful)
   - **API Design** — endpoints, request/response shapes, auth, errors, versioning
   - **Security** — threat model, auth/authz, data protection, input sanitization, secrets
   - **Performance & Scalability** — targets, caching, scaling plan
   - **Reliability** — error handling, logging/monitoring, recovery
   - **Deployment Architecture**
   - **Technical Risks & Mitigations**
3. If any architectural or technology decisions are unclear from requirements, ASK before writing — do not invent.
4. Use ASCII art or mermaid for diagrams.
5. After writing, recommend:
   - `spec-review` with phase `design` for a self-audit
   - `spec-approve` with phase `design` when ready
   - Then `spec-tasks` to decompose into tasks

## Quality bar

- Every technology choice has a justification.
- Every external dependency or integration is explicit.
- The threat model addresses the actual surface area, not generic OWASP boilerplate.
- Performance targets are numeric, not "fast".

## Notes

- Use the Write tool for creation, Edit for revisions.
- This skill is for code-producing specs only. Research specs use `spec-research`.
