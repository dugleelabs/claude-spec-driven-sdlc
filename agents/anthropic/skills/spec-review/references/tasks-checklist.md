# Tasks review checklist

## Structure
- [ ] **Task Breakdown**: All work decomposed into actionable tasks
- [ ] **Phase Organization**: Tasks grouped into phases that fit the work
- [ ] **Walking Skeleton**: Phase 1 ends in a runnable end-to-end slice; each later phase ends with something demonstrable
- [ ] **Granularity**: Tasks are single-sitting sized (S/M); anything larger is split
- [ ] **Dependencies**: Non-obvious task dependencies mapped

## Completeness & Traceability
- [ ] **Traceability table**: Every F-XX and NF-XX maps to the task IDs that implement and verify it
- [ ] **Design Coverage**: All design components have implementation tasks
- [ ] **Testing Tasks**: Testing lives inside each phase next to the code it verifies, not in a trailing phase
- [ ] **Documentation Tasks**: API docs, user docs, README updates explicit
- [ ] **Release Tasks**: CI/CD, environment setup, release tasks included where applicable
- [ ] **No orphan tasks**: Every task traces to a requirement, design element, or engineering hygiene — nothing "just in case"

## Quality Criteria
- [ ] **Done criteria**: Each parent task carries an observable `Done when:` line
- [ ] **Specific**: Tasks describe concrete deliverables, with affected files/areas noted where known
- [ ] **Independent**: Tasks can be worked with minimal blocking

## Risk & Edge Cases
- [ ] **Error Handling**: Tasks for error scenarios included
- [ ] **Edge Cases**: Tasks for boundary conditions included
- [ ] **Risk Mitigation**: Each active design risk has a task in the earliest phase it can be addressed
- [ ] **Security & Performance**: Implementation and verification tasks present where requirements demand them

## Formatting (required for tracker sync)
- [ ] Parent tasks use `- [ ] **T-XX: Title**` format
- [ ] Subtasks are indented checkboxes, not plain-text bullets
- [ ] Phase headers use `## Phase N: Title`
