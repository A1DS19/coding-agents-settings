---
name: pr-create
description: Create well-structured pull requests with clear descriptions. Use when I want to open a PR, submit code, or push changes upstream. Handles branch creation, commit organization, and PR description writing.
---

# PR Create

## Philosophy

A good PR tells a story: what changed, why, and how to verify it. The description should stand on its own so future-me (or anyone) understands the change without reading every line. Small, focused PRs get reviewed faster and merged sooner.

## Process

### Phase 1: Explore — Assess the Changes

- [ ] Run `git status` and `git diff` to understand what's changed
- [ ] Check if changes are on the right branch (not main/master)
- [ ] Verify all tests pass
- [ ] Check for accidental files: `.env`, debug logs, `console.log`, TODO hacks

**Checkpoint: present a summary of what's staged, any issues found (wrong branch, failing tests, accidental files). Wait before organizing.**

### Phase 2: Organize — Commits

If commits are messy:
- [ ] Consider squashing fixup commits
- [ ] Ensure each commit has a meaningful message
- [ ] Logical ordering: schema changes before code that uses them, etc.

If working from uncommitted changes:
- [ ] Group related changes into logical commits
- [ ] Separate refactoring commits from feature commits

**Checkpoint: present the commit plan and draft PR description. Wait for approval before pushing or creating.**

### Phase 3: Create the PR

Branch naming: `{type}/{short-description}` (e.g., `feat/user-search`, `fix/login-timeout`)

PR description structure:
```markdown
## Summary
- What this PR does in 1-3 bullet points

## Motivation
Why this change is needed — link to issue/ticket if applicable

## Changes
- Specific technical changes made
- Organized by area/concern

## Test Plan
- How to verify this works
- What tests were added/modified
- Manual testing steps if applicable

## Notes
- Alternative approaches considered
- Known limitations or follow-up work
```

### Phase 4: Pre-Submit Checklist

- [ ] PR title is concise and descriptive (under 70 chars)
- [ ] Description is complete
- [ ] No unrelated changes included
- [ ] Tests pass in CI
- [ ] No secrets or credentials in the diff
- [ ] Breaking changes are called out
- [ ] Documentation updated if public API changed

## Rules

- One concern per PR — don't mix features with refactors
- If a PR is too large (>500 lines), consider splitting it
- Draft PRs are fine for work-in-progress — mark them as such
- Link related issues so they auto-close on merge
