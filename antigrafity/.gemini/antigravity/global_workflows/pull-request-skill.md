---
description: Standard for formatting Merge Requests (Pull Requests)
---

# Merge Request Standard

When asking the agent to create a Merge Request (MR) or Pull Request (PR), or when drafting one yourself, strictly follow this template to ensure consistency and quality.

## 1. Title Format

Use Semantic Commit syntax:
`<type>(<scope>): <concise description>`

**Types:**

-   `feat`: New feature
-   `fix`: Bug fix
-   `docs`: Documentation only
-   `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc)
-   `refactor`: Code change that neither fixes a bug nor adds a feature
-   `perf`: Code change that improves performance
-   `test`: Adding missing tests or correcting existing tests
-   `chore`: Changes to the build process or auxiliary tools and libraries

**Example:**
`feat(auth): implement OIDC login flow`
`fix(api): handle timeout in payment gateway`

## 2. Description Body Template

Use the following markdown structure for the MR body:

```markdown
## Summary

<!-- Briefly explain WHAT changed and WHY. Link to relevant issues (e.g., "Closes #123"). -->

## Key Changes

<!-- Bullet points of technical implementation details -->

-   Added `LoginService` class
-   Updated schema for `users` table
-   fixed race condition in `event_handler.go`
```

## 3. Review Checklist

Before submitting, ensure:

-   [ ] Code compiles/builds locally.
-   [ ] Tests (unit/integration) pass.
-   [ ] New code follows the project's style guide.
-   [ ] No hardcoded secrets or sensitive data.
-   [ ] Documentation updated if necessary.
