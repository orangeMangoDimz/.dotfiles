---
description: Open one PR into `dev` with business-level TL;DR, Summary, Changes table, Note
---

# pull-request

## When to use

Apply when the user wants **one** pull request into **`dev`**, with a **clear title and body**, and the feature branch is already **pushed** to `origin`.

## PR title

Use the same spirit as Conventional Commits and project git conventions: imperative, scoped, no trailing period.

- Shape: `<type>(<scope>): <short description>`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`
- Examples: `feat(reports): add monthly summary endpoint`, `fix(auth): handle expired refresh tokens`

## PR body structure

Describe at **business/behavior level**, not code level. Commit history already shows code-level detail.

| Section | Content |
| --- | --- |
| **TL;DR** | One sentence: what user/system gets + why. |
| **Summary** | Bullet list (3-5 items). Each bullet one short point: problem solved, who benefits, impact. Keep reviewer-scannable — no long paragraphs. |
| **Changes** | Table by capability/flow. Before/After describe **observable behavior**, not files or functions. |
| **Note** | Bullet list. Each bullet one item: `Closes #n` / `Refs #n`, migration, risks, rollback, breaking changes, screenshots for UI. Omit section if nothing to note. |

Keep the PR focused on one coherent change. Large unrelated edits belong in separate PRs.

## Command

Run from the repository root. Replace placeholders. The body uses a here-doc so the description stays readable in the PR UI.

```bash
gh pr create --base dev --head <branch-name> --title "<type>(<scope>): <description>" --body "$(cat <<'EOF'
## TL;DR

[One sentence: what user/system gets + why.]

## Summary

- [Problem or gap this addresses]
- [Who benefits and how]
- [Impact or outcome]

## Changes

| Capability | Before | After |
|------------|--------|-------|
| [feature/flow] | [old behavior] | [new behavior] |

## Note

- [Closes #n / Refs #n]
- [Migration, risks, rollback, or breaking changes if any]
EOF
)"
```

## Example

Title: `feat(reports): add CSV export for monthly summary`

Body:

```markdown
## TL;DR

Finance can now download monthly reports as CSV without database access.

## Summary

- Finance had to ask engineering for raw data every month-end
- This adds self-serve CSV export on the monthly summary endpoint
- Reduces engineering toil and speeds up month-end close for finance

## Changes

| Capability | Before | After |
|------------|--------|-------|
| Monthly report export | JSON only via API | CSV download available for finance users |
| Access | Required engineer to run query | Self-serve from reports UI |

## Note

- Refs #42
- No migration needed
- Rollback is revert-only
```

## Rules

- Open **exactly one** PR for the task. Do not run `gh pr create` twice for the same work unless the first attempt failed before a PR existed.
- Base branch is always **`dev`** unless the user names a different base.
- If a PR for this branch already exists, report the existing PR URL instead of creating another.
- If `gh` is not installed or not authenticated, stop and say to install the GitHub CLI and run `gh auth login`, or open the compare URL on GitHub: `dev` ← `<branch-name>`.

## Before running

- Confirm the branch exists on `origin` (`git push -u origin <branch-name>` if needed).
- Optional: `gh pr view` on the branch to see if a PR is already open.
