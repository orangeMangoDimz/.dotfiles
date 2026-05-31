---
description: Create and push semver git tag (production or release candidate)
---

# Git tagging

## Tag patterns

| Type | Pattern | Example |
| ---- | ------- | ------- |
| Production | `v{major}.{minor}.{patch}` | `v1.2.3` |
| Release candidate | `v{major}.{minor}.{patch}-rc{n}` | `v1.3.0-rc1` |

Tags must start with `v` followed by a valid semantic version string. Do not create tags that already exist locally or on `origin`.

## Tag message

Use an **annotated** tag (`git tag -a`) with this structured message:

```
Release <tag>

Highlights:
- <capability/flow change>
- <capability/flow change>

Notes: <breaking change, migration, rollback — optional, omit if none>
```

### Seed highlights from previous relevant tag

Run `git log <previous-relevant-tag>..<commit> --pretty=format:'- %s'` and use the output as a starting point. Rewrite at **business/behavior level** (not raw commit subjects) before finalizing. Present the draft to the user for confirmation or edit.

**Previous relevant tag** rule:

- **Production** (`vX.Y.Z`): previous production tag (exclude `-rc*`). Find with `git tag --list 'v*' --sort=-version:refname | grep -v -- '-rc' | head -1`.
- **Release candidate** (`vX.Y.Z-rcN`): previous tag on the same line — latest RC for this version, or the prior production tag if this is `-rc1`. Find with `git tag --list 'v*' --sort=-version:refname | head -1`.

If no previous relevant tag exists (first release), use `git log --pretty=format:'- %s'` scoped to the release branch and say so to the user.

## When the user specifies the tag

If the prompt includes an explicit tag (e.g. `v1.4.0`, `tag v2.0.0-rc1`):

1. `git fetch --tags` (or `git fetch origin tag <name>` if only one tag matters).
2. Verify the tag does not exist: `git rev-parse -q --verify "refs/tags/<tag>"` and `git ls-remote --tags origin "refs/tags/<tag>"`.
3. Resolve the commit: default `HEAD`; use a SHA or ref from the user if given.
4. Build the message from the **Tag message** template above (seed highlights from previous relevant tag; show draft to user; accept edits). Create the annotated tag: `git tag -a <tag> -F <message-file> [<commit>]` (or `-m` with the full string).
5. Push: `git push origin <tag>` unless the user asked for local-only.

## When the user does not specify the tag

**Stop and ask once** before creating anything. Do not pick a version without the user's choice.

1. `git fetch --tags`.
2. Latest version tag (prefer semver ordering):

    ```bash
    git tag --list 'v*' --sort=-version:refname | head -1
    ```

    If none exist, say there are no `v*` tags and suggest starting with `v0.1.0` or `v1.0.0` per user preference.

3. Parse the latest tag (strip leading `v` for mental math). Present **numbered options** derived from that tag, for example if latest is `v1.2.3`:

    | Option | Tag | Typical use |
    | ------ | --- | ----------- |
    | 1 | `v1.2.4` | Patch (fixes) |
    | 2 | `v1.3.0` | Minor (features, compatible) |
    | 3 | `v2.0.0` | Major (breaking) |
    | 4 | `v1.3.0-rc1` | First RC toward next minor (adjust base if user is on a patch line) |
    | 5 | Custom | User types the exact tag |

    If latest is `v1.3.0-rc2`, include incrementing to `v1.3.0-rc3` and promoting to `v1.3.0` as separate options.

4. After the user picks an option or gives a custom tag, follow **When the user specifies the tag** from validation onward.

## Branch guidance (non-blocking)

- **Production-style tags** (`vX.Y.Z` with no prerelease suffix): prefer creating from `main` or `master` unless the user explicitly wants another ref.
- **Release candidate** (`-rcN`): acceptable from `dev` or `release/*` when that matches team process; still honor the user's chosen commit or branch.

If the working tree is dirty and the user did not ask to tag a specific commit, mention it and either tag `HEAD` as-is only if they confirm, or wait until they specify a commit SHA.

## Safety

- Never delete or move tags (`git tag -d`, `git push --delete origin <tag>`, force-push tags) unless the user explicitly orders it in the same conversation.
- Never overwrite an existing tag.
- If `git push` of the tag fails (network, permissions), report the error and leave the local tag in place unless the user asks to remove it.
