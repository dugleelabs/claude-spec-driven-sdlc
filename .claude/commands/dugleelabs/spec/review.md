---
allowed-tools: Bash(cat:*), Bash(test:*), Bash(ls:*), Read, Glob
description: Review a specification phase (requirements, design, or tasks)
argument-hint: requirements|design|tasks
---

## Context

Current spec: !`cat spec/.current-spec 2>/dev/null || echo "No active spec"`

Spec files: !`current=$(cat spec/.current-spec 2>/dev/null); [ -n "$current" ] && ls "spec/$current/" 2>/dev/null || echo "No spec directory"`

## Your Task

Review the **"$ARGUMENTS"** phase document for the current specification.

If no argument provided or invalid argument, show usage and list available phases (requirements, design, tasks).

### Step 1: Validate and Load

1. Read the current spec name from `spec/.current-spec`
2. Verify the phase document exists (`requirements.md`, `design.md`, or `tasks.md`)
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

After evaluating, provide:

1. **Summary**: Overall assessment (Ready / Needs Work / Major Issues)
2. **Strengths**: What's well done
3. **Issues Found**: Specific problems with line references
4. **Recommendations**: Concrete suggestions for improvement
5. **Missing Items**: Any required sections or content that's missing
6. **Next Steps**:
   - If approved: `/spec:approve $ARGUMENTS`
   - If needs work: Specific edits required

---

## Usage Examples

```
/spec:review requirements   # Review requirements document
/spec:review design         # Review design document
/spec:review tasks          # Review tasks document
```