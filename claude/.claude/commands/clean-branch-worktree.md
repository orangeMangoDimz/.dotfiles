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

### 3.5. Map worktrees to branches
```bash
git worktree list --porcelain
```
Parse output blocks. For each worktree:
- Skip the main worktree (first entry)
- Skip entries with `detached` (no branch linked)
- Extract `worktree <path>` and `branch refs/heads/<name>` → build map: `branch → path`

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

WORKTREES TO REMOVE:
  /path/to/worktree   (branch: feature/old-stuff)
```

If no worktrees are linked to deleted branches, omit the WORKTREES TO REMOVE section.

If DELETE list is empty, report "Nothing to clean." and stop.

### 8. Ask for confirmation
Ask the user: "Delete these branches? (yes/no)"
Do NOT proceed without explicit "yes" or "y".

### 9. Execute deletions
For each branch in DELETE list:
1. If a worktree is linked to this branch:
   - Check for uncommitted changes: `git -C <worktree-path> status --porcelain`
   - If dirty: warn "Skipping worktree removal for <branch>: uncommitted changes at <path>" and skip worktree removal (still delete the branch)
   - If clean: `git worktree remove <path>`
2. Delete local branch: `git branch -D <branch>`
3. If also marked for remote deletion: `git push origin --delete <branch>`

Report each action as it happens. Summarize total deleted at the end.
