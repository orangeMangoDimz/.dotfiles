---
description: Open one release PR from `dev` into `main`/`master` covering all accumulated changes, with business-level TL;DR, Summary, Changes table, Note
---

# pr-to-main

## When to use

Apply when the user wants a **release PR** from `dev` into the production branch (`main` or `master`), capturing everything that has accumulated on `dev` since the last merge.

## Auto-detect target branch

Check which production branch exists:

```bash
git branch -r | grep -E 'origin/(main|master)$'
```

Use `main` if it exists; fall back to `master`. If neither exists, stop and ask the user.

## PR title

Shape: `release: <short description of what ships>`

Alternatives when a version tag is involved: `chore(release): v<semver>`

Examples:
- `release: user onboarding and payment improvements`
- `chore(release): v2.4.0`

## Gather changes before writing

Run these to understand the full diff:

```bash
# All commits on dev not yet in main/master
git log main..dev --oneline --no-merges

# Grouped by type for the summary
git log main..dev --oneline --no-merges | sort
```

Use this log to populate Summary (group by feat/fix/chore/etc.) and the Changes table.

## PR body structure

Describe at **business/behavior level**, not code level. Commit history already shows code-level detail.

| Section | Content |
| --- | --- |
| **TL;DR** | One sentence: what ships and why it matters. |
| **Summary** | Bullet list (3–8 items). Group by theme: features first, fixes second, infra/chore last. Each bullet one short point. Keep reviewer-scannable. |
| **Changes** | Table by capability/flow. Before/After describe **observable behavior**, not files or functions. |
| **Note** | Bullet list. Each bullet one item: `Closes #n` / `Refs #n`, migration steps, rollback plan, breaking changes, screenshots for UI. Omit section if nothing to note. |

## Command

Run from the repository root. Replace `<target>` with `main` or `master` and `<title>` with the release title.

```bash
gh pr create --base <target> --head dev --title "<title>" --body "$(cat <<'EOF'
## TL;DR

[One sentence: what ships and why it matters.]

## Summary

- [Feature or fix 1]
- [Feature or fix 2]
- [Feature or fix 3]
- [Infra or chore items if relevant]

## Changes

| Capability | Before | After |
|------------|--------|-------|
| [feature/flow] | [old behavior] | [new behavior] |

## Note

- [Closes #n / Refs #n]
- [Migration steps if any]
- [Rollback plan]
- [Breaking changes if any]
EOF
)"
```

## Example

Title: `release: self-serve CSV export and improved auth error messages`

Body:

```markdown
## TL;DR

Finance can download monthly reports as CSV and users now see actionable messages when login fails.

## Summary

- Added self-serve CSV export for monthly summary reports (finance team no longer needs to request raw data)
- Auth errors now show specific messages instead of generic "invalid credentials"
- Fixed pagination bug on the transactions list that skipped the last page
- Upgraded CI pipeline to Node 20

## Changes

| Capability | Before | After |
|------------|--------|-------|
| Monthly report export | JSON only via API | CSV download available in reports UI |
| Auth error feedback | Generic "invalid credentials" for all failures | Specific message per failure type (expired, locked, wrong password) |
| Transactions pagination | Last page silently skipped | All pages returned correctly |

## Note

- Closes #42, Closes #58, Refs #61
- No database migration needed
- Rollback: revert the merge commit and redeploy
```

## Rules

- Open **exactly one** PR. If a `dev → main/master` PR already exists, report the existing PR URL instead.
- Always gather `git log <target>..dev --oneline` before writing the body — don't guess what's in the diff.
- Base branch is `main` or `master` (auto-detected). Override only if the user explicitly names a different base.
- If `gh` is not installed or not authenticated, stop and say to install the GitHub CLI and run `gh auth login`.

## Before running

- Confirm `dev` is pushed to `origin` (`git push origin dev` if needed).
- Run `gh pr list --base main` (or `master`) to check for an existing open PR.
- Review `git log <target>..dev --oneline` to confirm the diff is what you expect.
