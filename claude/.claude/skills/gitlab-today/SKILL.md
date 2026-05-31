---
name: gitlab-today
description: Fetch and format today's GitLab activity into the daily progress structure
origin: custom
---

# GitLab Today Activity

Fetches today's GitLab events and formats them as a daily progress report.

## Steps

1. Get today's date in `YYYY-MM-DD` format from the system, then subtract 1 day to get yesterday's date
2. Call `mcp__gitlab-events__get_gitlab_events` with:
   - `after`: yesterday's date (YYYY-MM-DD) — use day-1 so today's events are included
   - `per_page`: 100
3. Filter the returned events to only those where `created_at` starts with today's date (YYYY-MM-DD)
4. Format and display the result using the rules below

## Output Format

```
This is my today progress project
Save it

<project-name>

1. <Feature title>
- <What changed or was added>
- <Why it matters or what it replaces/fixes>

2. <Next feature title>
- <What changed>
- <Why it matters>
```

## Formatting Rules

- Group all events by project name (`target_title` on the project or MR's project)
- **Deduplicate**: opened + approved + merged for the same MR = 1 item only
- **Strip** conventional commit prefixes: `feat(x):`, `fix:`, `chore:`, `refactor:`, etc.
- **Capitalize** the first letter of each title
- Write bullets in plain English — not commit message style
- First bullet: what was done / what the user now sees
- Second bullet: what it replaces, fixes, or why it matters
- Skip branch deletions/creations that have no associated MR
- MRs that were **closed** (not merged) go at the bottom under `Closed (not merged)`
- **No emojis** anywhere in the output
- If activity spans multiple projects, repeat the block for each project
- If no activity found, output: `No GitLab activity found for today.`
