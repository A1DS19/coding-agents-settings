---
name: refactor
description: Safe, incremental refactoring with tests as a safety net. Use when I want to improve code structure, reduce complexity, extract modules, rename things, or clean up tech debt. Each step is a small, verifiable change.
---

# Refactor

## Philosophy

Refactoring changes structure without changing behavior. Every step must be small enough that if tests break, the cause is obvious. Never refactor and add features at the same time.

## Process

### Phase 1: Explore — Understand Before Changing

- [ ] Read the code to refactor and its callers
- [ ] Understand *why* it's structured this way — there may be hidden constraints
- [ ] Identify what tests exist (run them, confirm they pass)
- [ ] Clarify the goal: readability? Testability? Performance? Reducing duplication?
- [ ] Agree on scope — refactoring can expand endlessly without a boundary

**Checkpoint: present what was found — current structure, why it exists, what tests cover it. Wait for scope confirmation.**

### Phase 2: Plan — Small Steps

Break the refactor into atomic commits, each of which:
- Changes one thing
- Keeps tests passing
- Is independently reviewable

Common sequences:
```
Extract function → Inline callers → Rename
Extract interface → Swap implementation → Remove old
Move file → Update imports → Rename if needed
Split module → Define boundary → Wire dependencies
```

**Checkpoint: present the step-by-step plan. Wait for approval before making any code changes.**

### Phase 3: Execute — One Step at a Time

For each step:

- [ ] Make the structural change
- [ ] Run tests — they must pass
- [ ] If tests fail, the change was too big — break it down further
- [ ] Commit after each green step (if incremental commits are desired)

### Phase 4: Verify

After all steps:

- [ ] All tests pass
- [ ] Behavior is identical (no functional changes snuck in)
- [ ] The code is measurably improved against the stated goal
- [ ] No orphaned code, dead imports, or unused files left behind

## Common Refactors

**Extract function/method**: Code block does a distinct thing → give it a name
**Extract module/class**: File does too many things → split by responsibility
**Inline**: Abstraction adds indirection without value → collapse it
**Rename**: Name doesn't match what it does → fix the name everywhere
**Replace conditional with polymorphism**: Switch/if chain on type → use the type system
**Simplify interface**: Too many parameters → introduce config object or builder
**Remove duplication**: Same logic in 3+ places → extract (but not for 2 — wait for the third)

## Rules

- If there are no tests, write them *before* refactoring — they're your safety net
- Don't refactor code you don't understand yet
- Don't "improve" code that works fine and isn't in scope
- If you discover a bug during refactoring, stop, fix the bug separately, then continue
- Preserve git blame usefulness — don't reformat entire files as part of a logic refactor
