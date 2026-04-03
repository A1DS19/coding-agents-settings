---
name: code-review
description: Thorough code review with actionable feedback. Use when I'm reviewing PRs, diffs, or my own code changes. Catches bugs, security issues, performance problems, and maintainability concerns. Invoke with a PR URL, branch name, or file paths.
---

# Code Review

## Philosophy

A good code review catches what tests miss: design flaws, subtle bugs, security gaps, and maintainability debt. Review the **intent**, not just the syntax. Every comment should be actionable — "this could break under concurrent access because X" beats "looks risky."

## Process

### Phase 1: Explore — Understand the Change

- [ ] Read the PR description, linked issues, or ask what the change does
- [ ] Identify the type of change: feature, bugfix, refactor, config, dependency update
- [ ] Understand the scope — what *should* have changed vs what *did* change
- [ ] Assess the overall approach: does it make sense? Are there simpler alternatives?
- [ ] Is the change complete? Missing error handling, edge cases, migrations, tests?

**Checkpoint: present a summary of what this change does and any high-level concerns before diving into line-level review.**

### Phase 2: Analyze — Line-Level Review

For each file changed, check:

**Correctness**
- Off-by-one errors, null/undefined access, race conditions
- Edge cases: empty inputs, large inputs, concurrent access, network failures
- State management: is state modified predictably?

**Security**
- User input validation and sanitization
- SQL injection, XSS, command injection vectors
- Authentication/authorization bypasses
- Secrets or credentials in code
- Unsafe deserialization

**Performance**
- N+1 queries, missing indexes, unbounded loops
- Memory leaks, large allocations in hot paths
- Missing pagination, unbounded result sets

**Maintainability**
- Naming clarity — will this still make sense in six months?
- Duplication that should be extracted
- Dead code or unnecessary changes
- Breaking changes to public APIs

**Checkpoint: present line-level findings organized by severity before finalizing.**

### Phase 3: Assess — Test Coverage & Final Verdict

- [ ] Are new behaviors covered by tests?
- [ ] Do tests verify behavior, not implementation?
- [ ] Are edge cases tested?
- [ ] Would these tests catch a regression?

### Phase 4: Deliver

Structure your review:

1. **Summary**: One paragraph — what the change does, overall assessment
2. **Must Fix**: Bugs, security issues, data loss risks — blocking
3. **Should Fix**: Design concerns, missing tests, performance issues — strong suggestions
4. **Nits**: Style, naming, minor improvements — take or leave
5. **Praise**: Call out clever solutions, good test coverage, clean abstractions

## Rules

- Never approve code you don't understand — ask questions
- Suggest fixes, don't just point out problems
- Distinguish opinion from objective issues
- If a file wasn't changed but should have been, flag it
- Check for missing changelog entries, migration files, documentation updates
