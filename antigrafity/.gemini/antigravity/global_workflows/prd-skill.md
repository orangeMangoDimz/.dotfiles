---
description: Guidelines and template for generating Engineering-Grade PRDs
---

# PRD Generation Standard
When requested to create a Product Requirements Document (PRD), use the following structure to ensure consistency, clarity, and engineering rigor.

## 1. Document Header
Start with a metadata table:
| **Project Name** | [Name] |
| :--- | :--- |
| **Version** | 1.0 (Draft) |
| **Status** | In Planning |
| **Date** | [YYYY-MM-DD] |

## 2. Introduction
- **1.1 Purpose**: concise summary of what we are building.
- **1.2 Scope**: Define the MVP boundaries (what is IN and what is OUT).
- **1.3 Definitions & Acronyms**: Clarify technical terms.

## 3. Functional Requirements
Group requirements by logical feature sets. Mark priority (P0, P1, P2).
### [Feature Group Name]
**Priority: [P0/P1]**
- **Requirement 1**: Description.
- **Requirement 2**: Description.
*(Repeat for all major feature groups like Auth, Core Business Logic, Admin, etc.)*


## 4. Technical Requirements
- **3.1 Technology Stack**: Explicitly list Backend, Frontend, DB, Caching, Auth, etc.
- **3.2 Database Schema (High-Level)**: List key entities and their attributes.
- **3.3 Architecture & Infrastructure**: Monolith/Microservices, Containerization, Environment management.


## 5. API Specification (Core Endpoints)
Provide a high-level table of critical endpoints:
| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| VERB | /path/ | Action description | Yes/No |


## 6. Non-Functional Requirements
- **5.1 Performance**: Latency targets, caching strategies.
- **5.2 Security**: Auth protocols, encryption, protection standards.
- **5.3 Scalability**: Strategy for growth (statelessness, horizon scaling).


## 7. Implementation Plan / Roadmap
Break down into phases:
- **Phase 1**: Foundation (Setup, Auth).
- **Phase 2**: Core Features.
- **Phase 3**: Advanced Features / Integrations.
- **Phase 4**: Polish / Admin / Launch.
