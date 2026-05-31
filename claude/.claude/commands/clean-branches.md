Delete all non-protected local and remote branches, with confirmation before any deletion.

## Steps

### 1. Validate git repo
Run `git rev-parse --git-dir`. If not a repo, report error and stop.

### 2. Get current branch
```bash
git rev-parse --abbrev-ref HEAD
```
This branch is always kept (even if not in the protected list).

### 3. Get all local branches
```bash
git branch --format='%(refname:short)'
```

### 4. Fetch remote protected branches
- Check remote URL: `git remote get-url origin`
- If GitHub (`github.com`): run `gh api repos/{owner}/{repo}/branches --jq '[.[] | select(.protected) | .name]'`
- If GitLab (`gitlab.com` or self-hosted): run `glab api "projects/:id/protected_branches" --jq '[.[].name]'`
- If neither CLI is available or command fails, note it and skip (treat remote-protected list as empty).

### 5. Build the KEEP list
Keep any local branch that matches:
- `main`
- `master`
- `dev`
- `release/*` (glob pattern)
- Current HEAD branch
- Any name returned by step 4 (remote protected)

### 6. Build the DELETE list
All local branches NOT in the KEEP list.

For each branch in DELETE list, also check if a remote tracking ref exists:
```bash
git ls-remote --heads origin <branch>
```
If it exists, mark it for remote deletion too.

### 7. Show confirmation table
Print clearly:

```
BRANCHES TO KEEP:
  main          (protected name)
  dev           (protected name)
  feature/xyz   (current HEAD)
  release/1.0   (release pattern)

BRANCHES TO DELETE:
  Local + Remote:
    feature/old-stuff
    bugfix/closed-ticket
  Local only:
    wip/experiment
```

If DELETE list is empty, report "Nothing to clean." and stop.

### 8. Ask for confirmation
Ask the user: "Delete these branches? (yes/no)"
Do NOT proceed without explicit "yes" or "y".

### 9. Execute deletions
For each branch in DELETE list:
- Delete local: `git branch -D <branch>`
- If also marked for remote deletion: `git push origin --delete <branch>`

Report each deletion as it happens. Summarize total deleted at the end.
