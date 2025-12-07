---
description: Use this standard whenever the user asks for a "CI/CD Pipeline", "Deployment Strategy", or references this rule file
---

# CI/CD Generation Standard

## 1. Document Header (Metadata)
Start every CI/CD document with this standard metadata table:

| **Project** | [Project Name] |
| :--- | :--- |
| **Referenced Doc** | [TDD.md or NFR.md context] |
| **Platform** | [e.g., GitHub Actions, GitLab CI, Jenkins] |
| **Date** | [YYYY-MM-DD] |

## 2. Core Structure
The document **MUST** contain the following 5 sections.

### Section 1: Overview
- Briefly explain the goal of this pipeline (e.g., "enforce testing strategy defined in TDD.md").
- Mention the key stages (Quality -> Validation -> Delivery).

### Section 2: Stage 1: Quality Gate (Static Analysis)
- **Goal**: Fail fast.
- **Tasks**:
  - Linting (flake8, eslint, etc.).
  - Formatting check (black, prettier).
  - Security scanning (bandit, safety, npm audit).

### Section 3: Stage 2: Validation (Test Suite)
- **Goal**: Verify logic.
- **Environment**: Detail required services (Postgres, Redis, etc.).
- **Tasks**:
  - Unit & Integration tests commands.
  - Coverage thresholds (e.g., fail under 80%).

### Section 4: Stage 3: Delivery (Build & Deploy)
- **Goal**: Package and ship.
- **Tasks**:
  - Docker build & push steps.
  - Deployment triggers (staging/prod).

### Section 5: Implementation Configuration
- Provide a **concrete YAML example** (or Jenkinsfile) suitable for the chosen platform.
- The code block must be ready to copy-paste.

## 3. Formatting Rules
- Use clear **bold** headings for pipeline stages.
- list specific commands (e.g., `pytest --cov`) rather than vague descriptions.
- Explicitly link pipeline steps to TDD/NFR requirements (e.g., "As required by NFR 3.1...").
