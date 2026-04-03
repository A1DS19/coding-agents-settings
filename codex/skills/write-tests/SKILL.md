---
name: write-tests
description: Write comprehensive tests for existing code. Use when I want to add test coverage, mention testing, or ask for unit/integration/e2e tests. Analyzes code to identify critical paths and writes meaningful tests that verify behavior, not implementation.
---

# Write Tests

## Philosophy

Tests exist to catch regressions and document behavior. A test suite should let someone refactor internals confidently without touching tests. Test **what** the code does through its public interface, not **how** it does it internally.

## Process

### Phase 1: Explore — Understand What to Test

- [ ] Read the code to understand what it does
- [ ] Identify the public interface (exported functions, API endpoints, class methods)
- [ ] Map out behaviors: happy paths, error paths, edge cases
- [ ] Check existing tests — don't duplicate coverage
- [ ] Identify the testing framework and patterns already used in the project

**Checkpoint: present the list of behaviors to test, prioritized. Ask which to prioritize if scope is large. Wait for approval before writing code.**

### Phase 2: Plan — Discover Conventions

- [ ] Find existing test files to match naming patterns (`*.test.ts`, `*_test.go`, `test_*.py`, etc.)
- [ ] Match import style, assertion library, and test runner already in use
- [ ] Follow existing patterns for mocking, fixtures, and test data
- [ ] Place test files where the project convention expects them

### Phase 3: Execute — Write Tests, Behavior First

For each behavior:

```
1. Describe the behavior in plain language (test name)
2. Set up the minimal preconditions
3. Execute through the public interface
4. Assert on observable outcomes
```

**Priority order:**
1. Happy path — does the core feature work?
2. Error handling — does it fail gracefully?
3. Edge cases — empty input, boundaries, concurrency
4. Integration points — does it work with real dependencies?

**Checkpoint: after writing each test, run it to confirm it passes before moving to the next.**

### Phase 4: Verify — Quality Checklist

Each test should pass this:

- [ ] Test name describes a behavior ("creates user with valid email"), not an implementation ("calls save method")
- [ ] Test would survive an internal refactor
- [ ] Test has exactly one reason to fail
- [ ] Setup is minimal — no irrelevant data
- [ ] No mocking of internals — only external boundaries (network, filesystem, clock)
- [ ] Assertions verify outcomes, not call counts

### Phase 5: Confirm — Run and Verify

- [ ] All new tests pass
- [ ] All existing tests still pass
- [ ] New tests actually fail when the behavior breaks (flip the logic to verify)

## Anti-Patterns to Avoid

- **Testing implementation**: Asserting that internal method X was called Y times
- **Excessive mocking**: If everything is mocked, you're testing the mocks
- **Snapshot abuse**: Snapshots that nobody reads or updates thoughtfully
- **Test-per-method**: Test behaviors, not functions — one function may have multiple behaviors
- **Copy-paste tests**: Extract shared setup into fixtures or helpers
- **Ignoring flaky tests**: Fix or remove them — a flaky test erodes trust
