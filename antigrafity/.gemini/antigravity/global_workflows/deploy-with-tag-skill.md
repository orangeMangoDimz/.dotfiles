---
description: Standard for deploying and releasing via Git Tags
---

# Deploy with Tag Skill & Workflow

This document outlines the mandatory steps for creating releases using Git Tags.

## 1. Workflow Verification (Mandatory)

> **CRITICAL**: Before proceeding, you **MUST** verify that a CI/CD workflow file exists in the repository.

-   **Action**: Check for the existence of:
    -   GitLab: `.gitlab-ci.yml`
    -   GitHub: `.github/workflows/*.yml`

**IF NO WORKFLOW IS FOUND:**

-   **STOP IMMEDIATELY.**
-   **DO NOT** create a tag.
-   **REPORT** directly to the user: "Cannot proceed with tagging: No CI/CD workflow found."

> **CRITICAL**: You need to be in the main / master branch! Pull the latest changes before creating a new tag!

## 2. Semantic Versioning

Determine the new version number based on **Semantic Versioning** rules (`v<Major>.<Minor>.<Patch>`):

-   **Major** (e.g., `v1.0.0` -> `v2.0.0`): Breaking changes.
-   **Minor** (e.g., `v1.0.0` -> `v1.1.0`): New features (backward compatible).
-   **Patch** (e.g., `v1.0.0` -> `v1.0.1`): Bug fixes (backward compatible).

**Action**:

1.  Check the latest existing tag (e.g., `git describe --tags --abbrev=0`).
2.  If no tags exist, start with `v0.1.0` or `v1.0.0` as appropriate.
3.  Calculate the next version based on the changes since the last tag.

## 3. Tag Creation & Description

When creating the tag, you must include a release description (annotated tag or release note).

### 3.1 Tag Command

```bash
git tag -a v1.1.0 -m "Release v1.1.0: [Short Summary]"
git push origin v1.1.0
```

### 3.2 Description Standard

Provide a description covering the following:

```markdown
# Release [Version]

## Summary

[Brief description of the release goal]

## Key Changes

-   [Feature/Fix]: [Description]
-   [Feature/Fix]: [Description]

## Metadata

-   **Date**: [YYYY-MM-DD]
-   **Previous Version**: [Old Tag]
```
