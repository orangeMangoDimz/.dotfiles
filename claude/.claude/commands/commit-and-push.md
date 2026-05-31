---
description: Commit current changes and push (with branch choice + pre-commit gate)
---

# commit-and-push

## When to use

Apply when the user wants current changes committed and pushed. Each run produces **one new commit**.

## Step 1: Gather context automatically

Run these in parallel without asking:

```bash
git status
git diff --stat
git branch --show-current
git log --oneline -5
```

## Step 2: Auto-propose everything (no questions yet)

From the diff and status, generate:

1. **Commit message** — Conventional Commit style. Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`. Use `feat:` (not `feature:`). Keep subject ≤50 chars; add body only when "why" is non-obvious.
2. **Branch** — default to current branch. If HEAD is detached or no branch exists, propose a new branch name derived from the commit message.

If the user already stated a commit message or branch in the same message, use that verbatim.

## Step 3: Single confirmation

Present exactly once:

> Will commit **`<message>`** on **`<branch>`** and push. Proceed?

Wait for user confirmation. Do **not** proceed without it. Do **not** ask separate questions about branch or message — include any alternatives in the same prompt if relevant.

## Pre-commit gate (`.pre-commit-config.yaml`)

After confirmation, before `git commit`:

1. Run `pre-commit run` from repo root.
2. If it **passes** → proceed to commit/push.
3. If it **fails** or `pre-commit` is unavailable:
   - Try to auto-fix if the failure is straightforward (formatting, linting auto-fixes).
   - Re-run `pre-commit run`. If it now passes → commit/push without interrupting user.
   - If still failing → report the failure and ask the user once: **fix manually** or **bypass** (`--no-verify`). Never use `--no-verify` without this explicit confirmation.
4. If `.pre-commit-config.yaml` is missing → skip gate.

## Execution

**Current branch:**

```bash
git add -A
git commit -m "<commit message>"
git push
```

If no upstream: `git push -u origin $(git branch --show-current)`.

**New branch:**

```bash
git checkout -b <branch-name>
git add -A
git commit -m "<commit message>"
git push -u origin <branch-name>
```

Add `--no-verify` to `git commit` only after explicit user bypass confirmation.

## After successful push

Once push completes:

- If current branch is `main` or `master` → stop. Do **not** prompt for a PR.
- Otherwise, ask the user once:

> Push successful. Open a pull request into `dev`? (y/n)

- If **yes** → invoke `/pull-request` command.
- If **no** → stop.

## Rules

- **One** `git commit` per invocation.
- If nothing to commit → report and stop, no empty commit.
- One confirmation only — do not ask follow-up questions about message or branch unless the user requests changes.
- PR prompt fires only after a successful push; skip if push failed.
