---
name: debug
description: Systematic debugging to find and fix bugs. Use when I report a bug, error, unexpected behavior, failing test, or crash. Follows a structured approach to isolate root causes rather than guessing.
---

# Debug

## Philosophy

Debugging is hypothesis testing. Don't guess and patch — understand the failure, form a hypothesis, verify it, then fix the root cause. A fix you don't understand is a time bomb.

## Process

### Phase 1: Explore — Reproduce and Gather Evidence

- [ ] Get the exact error message, stack trace, or unexpected behavior description
- [ ] Identify the expected vs actual behavior
- [ ] Determine when it started (recent change? always broken? intermittent?)
- [ ] Find the minimal reproduction — strip away unrelated complexity
- [ ] Read the stack trace — start from the bottom (root cause), not the top
- [ ] Check recent changes: `git log --oneline -20` and `git diff` on relevant files
- [ ] Search for related issues or error messages in the codebase
- [ ] Check logs, if available
- [ ] Verify assumptions: are configs loaded? Is the DB reachable? Are env vars set?

**Checkpoint: present what was found — the failure path, relevant code, and recent changes. Don't jump to a fix yet.**

### Phase 2: Diagnose — Form Hypotheses

Based on evidence, list possible causes ranked by likelihood:

```
1. Most likely: [specific hypothesis based on evidence]
2. Possible: [alternative explanation]
3. Unlikely but worth checking: [edge case]
```

**Checkpoint: present ranked hypotheses and wait for agreement before testing them.**

### Phase 3: Verify — Test Hypotheses

For each hypothesis, starting with the most likely:

- [ ] Identify the fastest way to confirm or rule it out
- [ ] Add logging, write a test, or inspect state at the critical point
- [ ] Confirm the hypothesis before writing a fix

**Checkpoint: confirm which hypothesis was validated before proceeding to fix.**

### Phase 4: Fix — Root Cause

- [ ] Fix the actual cause, not just the symptom
- [ ] Write a test that would have caught this bug
- [ ] Check for the same pattern elsewhere in the codebase
- [ ] Verify the fix doesn't break other behavior
- [ ] Run the full test suite

### Phase 5: Report

Explain:
1. **Root cause**: Why the bug happened
2. **Fix**: What was changed and why
3. **Prevention**: Test added, or suggestion to prevent recurrence

## Common Bug Categories

**State bugs**: Variable mutated unexpectedly, stale cache, race condition
- Check: shared mutable state, async operations, missing locks

**Boundary bugs**: Off-by-one, null/undefined, empty collections, integer overflow
- Check: loop bounds, optional chaining, array access, type coercions

**Integration bugs**: API contract mismatch, schema drift, config errors
- Check: request/response shapes, env vars, connection strings, versions

**Timing bugs**: Race conditions, stale data, callback ordering
- Check: async/await correctness, event ordering, cache invalidation

## Rules

- Never apply a fix you can't explain
- If the bug is intermittent, find what varies between success and failure
- If you're stuck, widen the search — the bug may not be where you think
- Check for multiple bugs — sometimes the original is masked by a second issue
