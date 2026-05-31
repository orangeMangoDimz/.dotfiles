---
name: feature-review
description: This skill should be used when the user invokes "/feature-review", asks to "review this feature for bugs", "analyze this feature", "check for potential bugs", "do a feature analysis", or wants a structured bug risk assessment of a codebase feature. Always use this skill for feature-level bug analysis and risk reporting.
---

# Feature Review — Bug Risk Analysis

Perform a structured bug risk analysis on a given feature. The goal is to surface potential bugs, edge cases, and vulnerabilities a senior engineer would catch in a code review — before they reach production.

## Step 1: Identify the Scope

If the user has selected code in the editor, use that as the primary input. Otherwise, ask:

> "Which feature or files should I analyze? You can share file paths, paste code, or describe the feature."

Gather enough context to understand:
- The entry point (API route, function, service, etc.)
- Any related files (services, repositories, schemas, models, middleware)
- The intended behavior (what the feature is supposed to do)

Read all relevant files before proceeding. Trace the full call chain from API layer down to the database if applicable.

## Step 2: Analyze Using the Bug Matrix

Evaluate the feature across all 10 dimensions. For each dimension, identify concrete issues — not generic observations. If a dimension is clearly not applicable, note it briefly and move on.

| Dimension      | Questions to Ask                                                        |
|----------------|-------------------------------------------------------------------------|
| Happy Path     | Does it work under normal/expected inputs?                              |
| Edge Cases     | Empty input, max values, boundary conditions?                           |
| Error Handling | What happens on invalid input, DB failure, timeout?                     |
| Auth/AuthZ     | Who can access it? Are permissions enforced correctly?                  |
| Data Integrity | Is data saved correctly? Are constraints respected?                     |
| Concurrency    | What if two requests hit simultaneously? Race conditions?               |
| Performance    | N+1 queries? Unindexed columns? Slow paths?                             |
| Security       | Injection, over-posting, exposed sensitive fields?                      |
| Contract       | Does the response schema match the spec/frontend expectation?           |
| Side Effects   | Does it trigger anything unexpected (events, emails, jobs, etc.)?      |

## Step 3: Write the Report

Create a markdown report at `report/<feature-name>-review.md` (create the `report/` directory if it doesn't exist). Use the following structure:

```
# Feature Review: <Feature Name>

**Date:** <today's date>
**Scope:** <files or entry points analyzed>

## Summary

<2–3 sentence overview of the feature and overall risk level: Low / Medium / High / Critical>

## Bug Risk Matrix

### Happy Path
<findings or "No issues found">

### Edge Cases
<findings or "No issues found">

### Error Handling
<findings or "No issues found">

### Auth / AuthZ
<findings or "No issues found">

### Data Integrity
<findings or "No issues found">

### Concurrency
<findings or "No issues found">

### Performance
<findings or "No issues found">

### Security
<findings or "No issues found">

### Contract
<findings or "No issues found">

### Side Effects
<findings or "No issues found">

## Critical Issues

List only issues that could cause data loss, security breach, incorrect behavior in production, or broken user experience. Number them. Include:
- What the bug is
- Why it matters
- A concrete fix or mitigation

## Recommendations

Numbered list of improvements beyond critical issues — things that reduce risk, improve resilience, or follow best practices.

## Verdict

**Risk Level:** Low / Medium / High / Critical
**Recommended Action:** Ship / Ship with fixes / Block
```

## Guidelines

- Be specific. Reference actual line numbers, variable names, and function names where possible.
- Don't pad the report. If a dimension has no issues, say so clearly and move on.
- Prioritize ruthlessly. Not every observation deserves a "Critical Issues" entry — only things that would cause a real problem in production.
- Think like a senior engineer doing a pre-deploy review, not a linter.
- If the feature spans multiple layers (API, service, repository, DB), trace the full flow — bugs often hide at layer boundaries.
