# Global Rules

## Coding Style

### Immutability (CRITICAL)

- Always create new objects, never mutate existing ones.
- Rationale: immutable data prevents hidden side effects, makes debugging easier, and enables safe concurrency.
- Refer `~/.claude/rules/common/coding-style.md`

### Core Principles

- Prefer the simplest solution that actually works.
- Avoid premature optimization.
- Optimize for clarity over cleverness.
- Extract repeated logic into shared functions or utilities.
- Avoid copy-paste implementation drift.
- Introduce abstractions when repetition is real, not speculative.
- Do not build features or abstractions before they are needed.
- Avoid speculative generality.
- Start simple, then refactor when the pressure is real.

### File Organization

- Prefer many small files over few large files.
- Target high cohesion and low coupling.
- Keep files around 200-400 lines when practical, 800 max.
- Extract utilities from large modules.
- Organize by feature or domain, not by type.

### Input Validation

- Validate all user input before processing.
- Use schema-based validation where available.
- Fail fast with clear error messages.
- Never trust external data.

### Naming Conventions

- Variables and functions: `camelCase` with descriptive names.
- Booleans: prefer `is`, `has`, `should`, or `can` prefixes.
- Interfaces, types, and components: `PascalCase`.
- Constants: `UPPER_SNAKE_CASE`.
- Custom hooks: `camelCase` with a `use` prefix.

### Code Smells to Avoid

- Prefer early returns over deep nesting.
- Use named constants for meaningful thresholds, delays, and limits.
- Split large functions into focused pieces with clear responsibilities.

### Completion Checklist

- Code is readable and well-named.
- Functions are small when practical.
- Files are focused.
- Avoid deep nesting.
- Proper error handling exists.
- Avoid hardcoded values when a constant or config is appropriate.
- Prefer immutable patterns.

## Caveman Mode

When `~/.claude/.caveman-active` file exists, invoke the `caveman` skill in full mode. Rules from that skill override the response-format section below.

## Plan Mode

When entering plan mode, always invoke the `writing-plans` skill as the first action.

When given a plan file to execute, always invoke the `executing-plans` skill first.

## Before Editing

Always present a summary of all planned changes and ask for the user's opinion or confirmation before making any file edits. Only proceed with edits after the user explicitly approves.

## After Clarification

Once all questions are resolved and you are ready to proceed, ask the user whether they want to switch to plan mode first to review a detailed plan or execute the changes directly.

## Accuracy And Hallucination Prevention

### Facts Only

- If you do not know, say so or say that verification is needed.
- Never invent function names, file paths, API signatures, library behavior, env vars, or imports.
- Before claiming code does something, read the file first.
- Before claiming a library has a feature, check docs or source.
- Never fill gaps with plausible defaults.

### Required Tool Use

- Describing a function: read source first.
- Naming a path: glob or list first.
- Quoting config: read the file first.

### When Unsure

- State uncertainty and check with tools.
- If you cannot verify, say so explicitly.

### Forbidden Phrases

- Do not say "probably does X" instead of reading the code.
- Do not rely on "typically libraries..." instead of checking.
- Do not say "I'll assume X" when you can verify or ask.
- Do not say "should work" when you can test.

### Verify On Demand

- If the user says `verify`, re-check the last response and label each claim `[VERIFIED]` or `[RETRACTED]` with the reason.
# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.
