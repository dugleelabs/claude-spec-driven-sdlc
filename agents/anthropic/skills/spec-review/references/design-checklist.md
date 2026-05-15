# Design review checklist

## Architecture
- [ ] **Architecture Overview**: High-level system diagram provided
- [ ] **Component Breakdown**: All major components identified and explained
- [ ] **Data Flow**: Clear data flow between components
- [ ] **Technology Stack**: All technologies justified with rationale
- [ ] **Integration Points**: External systems and APIs documented

## Data Model
- [ ] **Schema Design**: Database schema / data models defined
- [ ] **Entity Relationships**: Clear ERD or relationship documentation
- [ ] **Data Validation**: Input validation rules specified
- [ ] **Data Migration**: Migration strategy if applicable

## API Design
- [ ] **Endpoint Specifications**: All endpoints documented
- [ ] **Request/Response Formats**: Clear schemas defined
- [ ] **Authentication/Authorization**: Auth flow documented
- [ ] **Error Handling**: Error codes and messages specified
- [ ] **Versioning Strategy**: API versioning approach defined

## Security
- [ ] **Threat Model**: Security threats identified
- [ ] **Authentication**: Auth mechanism properly designed
- [ ] **Authorization**: Access control rules defined
- [ ] **Data Protection**: Encryption at rest and in transit
- [ ] **Input Sanitization**: XSS, SQL injection prevention addressed
- [ ] **Secrets Management**: How secrets / keys are handled

## Performance & Scalability
- [ ] **Performance Targets**: Response time, throughput defined
- [ ] **Caching Strategy**: Caching approach documented
- [ ] **Scalability Plan**: Horizontal/vertical scaling addressed
- [ ] **Database Optimization**: Indexing, query optimization considered

## Reliability
- [ ] **Error Handling**: Graceful degradation strategy
- [ ] **Logging & Monitoring**: Observability approach defined
- [ ] **Disaster Recovery**: Backup and recovery plan
- [ ] **Health Checks**: System health monitoring

## Technical Risks
- [ ] **Risks Identified**: Technical risks documented
- [ ] **Mitigations**: Risk mitigation strategies defined
- [ ] **Dependencies**: Third-party dependency risks assessed
