# Design review checklist

Sections a design legitimately marks `Not applicable — <reason>` should be scored not-applicable here, provided the reason holds.

## Fit & Simplicity
- [ ] **MVP-first**: The design is the simplest that satisfies every P0 requirement; extra complexity cites the requirement demanding it
- [ ] **Codebase alignment**: Design extends existing patterns and stack; new technology is justified, not résumé-driven
- [ ] **Right-sized document**: Inapplicable sections carry a reason instead of fabricated boilerplate
- [ ] **Design Decisions recorded**: Material choices list options considered, the choice, and why
- [ ] **Future Considerations**: Deferred capability is noted, with how the design leaves the door open

## Architecture
- [ ] **Overview & diagram**: High-level system diagram provided
- [ ] **Component Breakdown**: All major components identified with responsibilities and boundaries
- [ ] **Data Flow**: Key flows traced end to end across the components
- [ ] **Integration Points**: External systems and APIs documented

## Data Model
- [ ] **Schema Design**: Database schema / data models defined
- [ ] **Entity Relationships**: Clear ERD or relationship documentation
- [ ] **Data Validation**: Input validation rules specified
- [ ] **Data Migration**: Migration strategy if existing data is affected

## API & Interfaces
- [ ] **Contract Specifications**: Endpoints or module contracts documented
- [ ] **Request/Response Formats**: Clear schemas defined
- [ ] **Authentication/Authorization**: Auth flow documented
- [ ] **Error Handling**: Error codes and messages specified
- [ ] **Versioning Strategy**: Approach defined where consumers exist

## Security
- [ ] **Threat Model**: Addresses the actual surface of this feature, not generic boilerplate
- [ ] **Authentication & Authorization**: Mechanisms and access rules defined
- [ ] **Data Protection**: Encryption at rest and in transit where warranted
- [ ] **Input Sanitization**: Injection/XSS prevention addressed for exposed inputs
- [ ] **Secrets Management**: How secrets / keys are handled

## Performance & Reliability
- [ ] **Performance Targets**: Numeric and MVP-realistic, for dimensions that matter
- [ ] **Caching/Optimization**: Present only where a requirement demands it
- [ ] **Error Handling**: Graceful degradation strategy
- [ ] **Logging & Monitoring**: Observability approach defined
- [ ] **Deployment & Rollback**: Deployment shape and recovery path described

## Technical Risks
- [ ] **Risks Identified**: Technical risks documented
- [ ] **Mitigations**: Each risk has a concrete mitigation or explicit acceptance
- [ ] **Dependencies**: Third-party dependency risks assessed
