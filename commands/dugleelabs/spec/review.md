---
allowed-tools: Bash(cat:*), Bash(test:*), Bash(ls:*), Read, Glob
description: Review a specification phase (requirements, design, research, or tasks)
args:
  - name: phase
    description: "Phase to review: requirements, design, research, or tasks"
    required: true
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`

## Your Task

First, list the files in the current spec directory using the Glob tool.

Then, review the **"{{phase}}"** phase document for the current specification.

Review the **"{{phase}}"** phase document for the current specification.

If no argument provided or invalid argument, show usage and list available phases (requirements, design, research, tasks).

### Step 1: Validate and Load

1. Read the current spec name from `spec/.current-spec`
2. Verify the phase document exists (`requirements.md`, `design.md`, `research.md`, or `tasks.md`)
3. Read the full document content
4. Read the README.md for spec context and approval status

### Step 2: Perform Phase-Specific Review

---

## Requirements Review Checklist

If reviewing **requirements**, evaluate against these criteria:

### Completeness
- [ ] **Feature Overview**: Clear problem statement and goals defined
- [ ] **Current State**: Tech stack, existing systems, security posture documented
- [ ] **User Stories**: All user stories have acceptance criteria
- [ ] **Functional Requirements**: Prioritized (P0/P1/P2) with clear descriptions
- [ ] **Non-Functional Requirements**: Performance, security, scalability addressed
- [ ] **Constraints & Assumptions**: Limitations clearly stated
- [ ] **Out of Scope**: Boundaries explicitly defined
- [ ] **Success Metrics**: Measurable outcomes specified
- [ ] **Open Questions**: All critical questions resolved or tracked

### Quality
- [ ] Requirements are testable and verifiable
- [ ] No ambiguous language (avoid "should", "might", "could")
- [ ] Each requirement has a unique identifier
- [ ] Dependencies between requirements identified
- [ ] Edge cases and error scenarios considered

### Stakeholder Alignment
- [ ] Business objectives clearly tied to requirements
- [ ] User personas and journeys well-defined
- [ ] Acceptance criteria agreed upon

---

## Design Review Checklist

If reviewing **design**, evaluate against these criteria:

### Architecture
- [ ] **Architecture Overview**: High-level system diagram provided
- [ ] **Component Breakdown**: All major components identified and explained
- [ ] **Data Flow**: Clear data flow between components
- [ ] **Technology Stack**: All technologies justified with rationale
- [ ] **Integration Points**: External systems and APIs documented

### Data Model
- [ ] **Schema Design**: Database schema/data models defined
- [ ] **Entity Relationships**: Clear ERD or relationship documentation
- [ ] **Data Validation**: Input validation rules specified
- [ ] **Data Migration**: Migration strategy if applicable

### API Design
- [ ] **Endpoint Specifications**: All endpoints documented
- [ ] **Request/Response Formats**: Clear schemas defined
- [ ] **Authentication/Authorization**: Auth flow documented
- [ ] **Error Handling**: Error codes and messages specified
- [ ] **Versioning Strategy**: API versioning approach defined

### Security
- [ ] **Threat Model**: Security threats identified
- [ ] **Authentication**: Auth mechanism properly designed
- [ ] **Authorization**: Access control rules defined
- [ ] **Data Protection**: Encryption at rest and in transit
- [ ] **Input Sanitization**: XSS, SQL injection prevention addressed
- [ ] **Secrets Management**: How secrets/keys are handled

### Performance & Scalability
- [ ] **Performance Targets**: Response time, throughput defined
- [ ] **Caching Strategy**: Caching approach documented
- [ ] **Scalability Plan**: Horizontal/vertical scaling addressed
- [ ] **Database Optimization**: Indexing, query optimization considered

### Reliability
- [ ] **Error Handling**: Graceful degradation strategy
- [ ] **Logging & Monitoring**: Observability approach defined
- [ ] **Disaster Recovery**: Backup and recovery plan
- [ ] **Health Checks**: System health monitoring

### Technical Risks
- [ ] **Risks Identified**: Technical risks documented
- [ ] **Mitigations**: Risk mitigation strategies defined
- [ ] **Dependencies**: Third-party dependency risks assessed

---

## Research Review Checklist

If reviewing **research**, evaluate against these criteria:

### Completeness
- [ ] **Executive summary**: 1-page distillation — a reader should grasp the findings without scrolling
- [ ] **Ethos pillars**: Strategic pillars with definitions and "what this means in practice" paragraphs
- [ ] **Anti-pillars**: Things the project deliberately will NOT become, with behaviour/feature each one rules out and why
- [ ] **Competitive landscape**: All tiers required by the requirements spec are covered; matrix maps each competitor across consistent dimensions
- [ ] **Community signals**: Real user asks sourced from public forums (Reddit, HN, GitHub issues/discussions, changelogs, blog posts)
- [ ] **Candidate critiques**: Every candidate from requirements + any research-surfaced ones evaluated against the same rubric
- [ ] **Dispositions**: Every candidate classified (pillar / feature worth pursuing / deferred / dropped) with written rationale — no silent rejections
- [ ] **Taxonomy / definitions**: If requirements call for distinctions (e.g. Roadmap vs Features), they're formalised with mapping rules
- [ ] **Follow-up specs**: For each "pillar" or "feature worth pursuing," a suggested spec name for `/dugleelabs:spec:new <name>` handoff
- [ ] **References**: Consolidated, deduplicated source list at the end

### Sourcing & Citation Quality
- [ ] Every non-trivial factual claim has an inline citation in `[text](url)` format
- [ ] Sources are primary (docs, changelogs, pricing pages, issue/thread URLs) — not LLM training data
- [ ] Citation format is consistent throughout
- [ ] References section dedupes and organises all cited sources
- [ ] Unsourced claims are flagged as such, not presented as fact

### Analytical Rigor
- [ ] Every candidate evaluated on identical rubric axes (no cherry-picking)
- [ ] Ethos pillars are distinguishing — they differentiate the project from catalogued competitors, not just restate generic values
- [ ] Anti-pillars rule out specific behaviours/features, not vibes
- [ ] Deferred and dropped candidates have rationale equal in rigor to pursued ones
- [ ] Pre-declared user preferences (if any) treated as input, not as research findings
- [ ] No effort estimates, shipping windows, or capacity planning (those belong to follow-up specs)

### Bias Awareness
- [ ] Project's own weaknesses acknowledged honestly, not only strengths highlighted
- [ ] Counter-evidence to preferred conclusions surfaced where it exists
- [ ] Subjective judgments flagged as such, separately from sourced signal
- [ ] Sample limitations in community-signal data acknowledged

---

## Tasks Review Checklist

If reviewing **tasks**, evaluate against these criteria:

### Structure
- [ ] **Task Breakdown**: All work decomposed into actionable tasks
- [ ] **Phase Organization**: Tasks grouped by phase (Foundation, Core, Testing, Deployment)
- [ ] **Granularity**: Tasks are appropriately sized (not too large, not too small)
- [ ] **Dependencies**: Task dependencies clearly mapped

### Completeness
- [ ] **Requirements Coverage**: All requirements have corresponding tasks
- [ ] **Design Implementation**: All design components have implementation tasks
- [ ] **Testing Tasks**: Unit, integration, E2E testing tasks included
- [ ] **Documentation Tasks**: API docs, user docs, README updates included
- [ ] **Deployment Tasks**: CI/CD, environment setup, release tasks included

### Quality Criteria
- [ ] **Actionable**: Each task has clear done criteria
- [ ] **Specific**: Tasks describe concrete deliverables
- [ ] **Independent**: Tasks can be worked on with minimal blocking
- [ ] **Testable**: Each task has verification steps

### Risk & Edge Cases
- [ ] **Error Handling**: Tasks for error scenarios included
- [ ] **Edge Cases**: Tasks for boundary conditions included
- [ ] **Security Tasks**: Security implementation and testing tasks present
- [ ] **Performance Tasks**: Performance optimization and testing tasks included

### Implementation Order
- [ ] **Foundation First**: Infrastructure and setup tasks come first
- [ ] **Incremental Value**: Each phase delivers testable functionality
- [ ] **Critical Path**: Critical path tasks identified
- [ ] **Parallel Work**: Tasks that can be parallelized are identified

---

## Step 3: Generate Review Report

After evaluating, provide a **concise** report — target 300–500 words total. Do not repeat or summarise the full document. Focus only on what matters for a go/no-go decision.

1. **Verdict**: One line — `Ready` / `Needs Work` / `Major Issues`
2. **Top strengths** (2–3 bullets max, one line each)
3. **Issues** (P0 blockers first, then P1 improvements — max 5 total, each with a line reference and a concrete fix)
4. **Next step**: single command to run, or the one edit required before approval

If you have more than 5 issues, rank by impact and list only the top 5. Ask the user if they want the full list.

---

## Usage Examples

```
/dugleelabs:spec:review requirements   # Review requirements document
/dugleelabs:spec:review design         # Review design document (feature specs)
/dugleelabs:spec:review research       # Review research document (research specs)
/dugleelabs:spec:review tasks          # Review tasks document
```