---
description: Use this standard whenever the user asks for "Non-Functional Requirements" or "NFRs", or references this rule file
---

# NFR Generation Standard

## 1. Document Header (Metadata)
Start every NFR document with this standard metadata table:

| **Project Name** | [Project Name] |
| :--- | :--- |
| **Version** | [Version, e.g., 1.0] |
| **Status** | [Status, e.g., Draft/Approved] |
| **Source Document** | [Reference PRD or similar] |
| **Date** | [YYYY-MM-DD] |

## 2. Core Structure
The document **MUST** contain the following 6 sections. Do not omit any section unless explicitly instructed.

### Section 1: Overview
- Briefly describe the purpose of the document.
- Mention the technology stack context (e.g., "adhering to Django/Postgres constraints").

### Section 2: Performance & Scalability
- **Latency**: Define specific targets for Read (< 200ms) and Write (< 500ms) operations.
- **Caching**: Specify strategies (e.g., Redis for frequent reads).
- **Throughput**: Define concurrent user targets and connection pooling strategies.

### Section 3: Security & Compliance
- **Authentication**: JWT/Session standards (short-lived access, rotation).
- **RBAC**: Clear separation of user/admin roles.
- **Data Protection**: Hashing standards (Argon2/PBKDF2) and sensitive data handling (No raw cards).
- **Input Validation**: Mandatory use of validation layers (e.g., DRF Serializers, Zod schemas).

### Section 4: Reliability & Availability
- **Data Integrity**: ACID transaction requirements for critical flows (Order/Stock).
- **Uptime**: Availability targets (e.g., 99.9%).
- **Recovery**: Container restart policies and DB persistence configs.

### Section 5: Maintainability & Code Quality
- **Standards**: Style guides (PEP 8, ESLint, etc.).
- **Documentation**: Swagger/OpenAPI requirements and docstring rules.
- **Logging**: Structured logging (JSON) and error tracking levels.

### Section 6: Environmental Requirements
- **Containerization**: Docker/Docker Compose requirements.
- **Configuration**: Strictly environment-variable based configuration (12-Factor App).

## 3. Formatting Rules
- Use clear **bold** headings for metrics.
- Use lists for readability.
- Keep descriptions concise and actionable (Engineering-focused, not marketing).
