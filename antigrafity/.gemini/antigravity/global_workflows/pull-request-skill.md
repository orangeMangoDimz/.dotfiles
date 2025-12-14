---
description: Standard for formatting Merge Requests (Pull Requests)
---

# merge request standard

when asking the agent to create a merge request (mr) or pull request (pr), or when drafting one yourself, strictly follow this template to ensure consistency and quality.

## 1. title format

use semantic commit syntax:
`<type>(<scope>): <concise description>`

**types:**

-   `feat`: new feature
-   `fix`: bug fix
-   `docs`: documentation only
-   `style`: changes that do not affect the meaning of the code (white-space, formatting, etc)
-   `refactor`: code change that neither fixes a bug nor adds a feature
-   `perf`: code change that improves performance
-   `test`: adding missing tests or correcting existing tests
-   `chore`: changes to the build process or auxiliary tools and libraries

**example:**
`feat(auth): implement oidc login flow`
`fix(api): handle timeout in payment gateway`

## 2. description body template

use the following markdown structure for the mr body:

```markdown
## summary

<!-- briefly explain what changed and why. link to relevant issues (e.g., "closes #123"). -->

## key changes

<!-- bullet points of technical implementation details -->

-   added `loginservice` class
-   updated schema for `users` table
-   fixed race condition in `event_handler.go`
```

## 3. review checklist

before submitting, ensure:

-   [ ] code compiles/builds locally.
-   [ ] tests (unit/integration) pass.
-   [ ] new code follows the project's style guide.
-   [ ] no hardcoded secrets or sensitive data.
-   [ ] documentation updated if necessary.

## 4. branching & submission strategy

**target branch rule**: always apply the merge request to the `dev` branch.

**missing dev branch protocol**:
if the `dev` branch is missing, you must create it:

1.  clone it from `main`.
    ```bash
    git checkout main && git pull origin main
    git checkout -b dev
    git push -u origin dev
    ```

**submission protocol**:

1.  attempt to open the merge request targeting `dev` using available tools (mcp).
2.  **multi-branch strategy**: you must create a separate merge request for every active branch (excluding `main` and `dev`) targeting `dev`.
    -   _example_: if existing branches are `main`, `dev`, `feat-a`, `feat-b`, `fix-c`. you create 3 mrs: `feat-a` -> `dev`, `feat-b` -> `dev`, `fix-c` -> `dev`.
3.  **fallback**: if you cannot create it directly (e.g., tool limitations), you **must** output the description as a markdown response for me to copy and paste.
