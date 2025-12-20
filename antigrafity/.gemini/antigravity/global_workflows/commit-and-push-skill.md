---
description: Standard workflow for committing and pushing changes with pre-commit checks
---

1. **Branch Management**
   - Evaluate if the current branch is appropriate for the changes.
   - If not relevant, create a new branch using a descriptive name: `git checkout -b <branch_name>`.
   - If the current branch IS relevant and safe to use, proceed with it.

2. **Pre-commit Validation**
   - Check if `.pre-commit-config.yaml` exists in the project root.
   - If it exists, execute the pre-commit checks:
     ```bash
     pre-commit run --all-files
     ```
   - **CRITICAL**: If the pre-commit check **FAILS**:
     - **STOP**. Do NOT commit the changes yet.
     - **DO NOT** automatically apply fixes without user awareness.
     - Analyze the failure output.
     - Provide the user with a specific **suggestion or guide** on how to resolve the issue (e.g., "Run black . to fix formatting" or "Update the config").
     - Wait for the user to resolve the issue or confirm the next step.

3. **Commit**
   - Proceed only if the pre-commit checks PASS (or if no pre-commit config exists).
   - Stage the files:
     ```bash
     git add <files>
     ```
   - Commit the changes with a semantic message:
     ```bash
     git commit -m "<type>: <description>"
     ```
     (e.g., `feat: add user login`, `fix: resolve db connection timeout`)

4. **Push**
   - Push the changes to the target branch:
     ```bash
     git push origin <branch_name>
     ```
   - **CRITICAL**: You are prohibited to push directly to the `main`, `staging`, and `dev` branch! This is a critical bracnh!
