# Global Rules

## Coding Style

### Immutability (CRITICAL)

- Always create new objects, never mutate existing ones.
- Rationale: immutable data prevents hidden side effects, makes debugging easier, and enables safe concurrency.
- Refer `~/.claude/rules/common/coding-style.md`

### Code Smells to Avoid

- Prefer early returns over deep nesting.
- Use named constants for meaningful thresholds, delays, and limits.
- Split large functions into focused pieces with clear responsibilities.

## Before Editing

Always present a summary of all planned changes and ask for the user's opinion or confirmation before making any file edits. Only proceed with edits after the user explicitly approves.

## After Clarification

Once all questions are resolved and you are ready to proceed, ask the user whether they want to switch to plan mode first to review a detailed plan or execute the changes directly.

## Accuracy And Hallucination Prevention

### Facts Only

- If you do not know, say so explicitly.
- Never invent function names, file paths, API signatures, library behavior, env vars, or imports.
- **Reading code ≠ proof.** Finding logic in source means "this logic exists here" — not "this is how the system behaves at runtime."
- Label every claim by evidence tier:
  - **[CODE]** — found in source, runtime behavior unverified
  - **[UNTESTED]** — no test output, log, or real run to back it
  - **[VERIFIED]** — confirmed by actual test result, log, or observed output
- Never state runtime behavior as fact without runtime proof.
- Prefer: *"Found this logic in `foo.ts:42` — no runtime evidence yet, needs a test to confirm."*
- Avoid: *"This function does X"* when you've only read the source.
- Before claiming a library has a feature, check docs or source AND label it [UNTESTED] if not run.
- Never fill gaps with plausible defaults.

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
