# GitLab Activity Response Structure

When formatting GitLab activity results, always use this structure:

## Output Format

```
This is my today progress project
Save it

<project-name>

1. <Feature title — clean, human-readable, no conventional commit prefix>
- <What changed or was added — user-facing or system-facing description>
- <Why it matters or what it replaces/fixes>

2. <Next feature title>
- <What changed>
- <Why it matters>
```

## Rules

- Group events by project name.
- One numbered item per unique MR (deduplicate: opened + approved + merged = 1 item).
- Strip conventional commit prefixes (`feat(x):`, `fix:`, etc.) from the title.
- Capitalize the first letter of the title.
- Write bullets in plain English, not commit message style.
- First bullet: what was done / what the user now sees.
- Second bullet: what it replaces, fixes, or why it matters.
- If only a branch was deleted with no MR data, skip it.
- If an MR was closed (not merged), note it separately at the bottom under "⚠️ Closed (not merged)".
- If multiple projects have activity, repeat the block for each project.
