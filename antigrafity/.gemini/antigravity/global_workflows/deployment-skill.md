---
description: Use this standard whenever the user asks for "Deployment Strategy", "Production Ops", "Incident Response", or references this rule file
---

# Deployment Strategy Generation Standard

## 1. Document Header (Metadata)
Start every Deployment document with this standard metadata table:

| **Project** | [Project Name] |
| :--- | :--- |
| **Referenced Doc** | [ci_cd.md or similar] |
| **Strategy Type** | [e.g., Blue/Green, Canary, Rolling] |
| **Date** | [YYYY-MM-DD] |

## 2. Core Structure
The document **MUST** contain the following 5 sections.

### Section 1: Overview
- Briefly explain the scope (Deployment + Monitoring + Incident Response).

### Section 2: Deployment Architecture
- **Strategy**: Define the strategy (Blue/Green is preferred for critical systems) and explain "why" (e.g., Zero Downtime).
- **Diagram**: Include a Mermaid flow or conceptual text description of the infrastructure (LB -> App -> DB).

### Section 3: Monitoring & Observability Stack
- **APM**: Specify tools for error tracking (Sentry, New Relic) and performance thresholds.
- **Metrics**: Define key metrics (RPS, Error Rate, Latency).
- **Logging**: Enforce structured logging requirements.

### Section 4: Incident Response Flow
- **Severity Levels**: Define SEV-1 (Critical), SEV-2 (High), SEV-3 (Low).
- **Protocol**: detailed steps: Alert -> Triage -> Mitigate (Revert first!) -> Resolve.
- **Post-Mortem**: Requirement for RCA on critical incidents.

### Section 5: Disaster Recovery (DR)
- **Backups**: Database snapshot strategies (WAL logs, daily dumps).
- **Targets**: Define RPO (Data Loss tolerance) and RTO (Restoration time tolerance).

## 3. Formatting Rules
- Use clear **tables** for Severity Levels.
- Use **Mermaid** graphs for architecture where possible.
- Focus on "Mitigation" (restore service) over "Resolution" (fix bug) in the response protocol.
