---
description: Deployment Strategy & Workflow Standard for CI/CD
---

# Deployment Strategy & Workflow Standard

This document outlines the mandatory steps and standards for deploying the project to the server using CI/CD.

## 1. Pre-Deployment Checks (Mandatory)

> **CRITICAL**: If ANY of these checks fail, **STOP IMMEDIATELY**. Do not proceed with the deployment. Report the missing requirements to the user directly.

### 1.1 Workflow Availability

-   **Verify**: Ensure a valid CI/CD workflow file exists.
    -   GitLab: `.gitlab-ci.yml`
    -   GitHub: `.github/workflows/*.yml`

### 1.2 Environment Configuration

-   **Verify**: Ensure environment example files exist to guide deployment configuration.
    -   Required: `.env.example`, `.env.dev.example`, or `.env.prod.example`.

### 1.3 Security & Ignore Rules

-   **Verify**: Ensure sensitive configuration files are ignored.
    -   Check `.gitignore` contains `.env`.

### 1.4 Bracnh Strategy

-   **Verify**: Ensure your current bracnh is on dev.
    -   If not, then checkout to the dev bracnh. Pull from the latest commit first.

## 2. Merge/Pull Request Standard

If all Pre-Deployment Checks pass, create a Merge/Pull Request using the following strict structure.

### 2.1 Description Template

```markdown
## 1. Summary

**Version**: [Next Tag Version, e.g., v1.1.0]
**Description**: [Brief explanation of what this release contains and its purpose]

## 2. Key Changes

<!-- Track by commit. Compare original main commit with new one. -->

-   [Commit Hash] - [Commit Message]
-   [Commit Hash] - [Commit Message]

**Link**: [Insert Merge/Pull Request Link if available]

## 3. Review Checklist

-   [ ] Workflow availability checked (.gitlab-ci.yml / .github/workflows)
-   [ ] Environment examples verified (.env.example)
-   [ ] .gitignore verified (ignores .env)
-   [ ] Automated tests passed
```

## 3. Fallback Instruction

If the automated tool cannot provide the description field during MR creation, the agent must output the formatted markdown description in the chat response for manual copying.
