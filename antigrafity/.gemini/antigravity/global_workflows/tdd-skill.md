---
description: Comprehensive guide and template for generating TDD plans
---

# TDD Plan Generation Standard

When requested to create a Test-Driven Development (TDD) plan, use the following structure to ensure coverage, clarity, and adherence to the Red-Green-Refactor cycle.

## 1. Document Header
Start with a metadata table:
| **Project** | [Project Name] |
| :--- | :--- |
| **Document Type** | TDD Specification |
| **Date** | [YYYY-MM-DD] |

## 2. Testing Strategy Overview
Briefly define the tools and hierarchy.
- **Testing Pyramid**: Define percentage targets (e.g., Unit 70%, Integration 20%, E2E 10%).
- **Tooling**: List Runner (e.g., pytest), Plugins, Mocking libraries, and Factories.

## 3. Phase [N]: [Feature Set Name]
Break down tests by implementation phase.

### [N].1 [Component] Model (Unit)
List specific test cases for data models.
- `test_[scenario]`: Expected outcome.

### [N].2 [Component] API (Integration)
*Endpoint: `/path/to/resource`*
List test cases for API endpoints.
- `test_[scenario]`: Expected HTTP status code and payload verification.

### [N].3 Business Logic / Services (Unit)
*Service: `[ServiceName]`*
List test cases for isolated business logic.
- `test_[scenario]`: logical assertions.
*(Repeat for all phases: Foundation, Core Features, Advanced, Admin/Reporting)*

## [Last Section]. Implementation Workflow (Red-Green-Refactor)
Explicitly state the workflow to be followed for these tests:
1. **Red**: Write the test case first.
2. **Green**: Implement minimal code to pass.
3. **Refactor**: Optimize (e.g., query optimization, clean code).
