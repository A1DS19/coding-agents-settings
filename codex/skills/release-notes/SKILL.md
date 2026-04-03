---
name: release-notes
description: Generate release notes from git history. Use when I want to create a changelog, prepare release notes, or summarize changes for a version.
---

# Release Notes

## Philosophy

Release notes document what changed and why it matters. Lead with user impact for public-facing notes, lead with technical details for internal ones.

## Process

### Phase 1: Gather — Collect Changes

- [ ] Determine the range: last tag to HEAD, or between two specific refs
- [ ] Run `git log --oneline <from>..<to>` to list all commits
- [ ] Check for merged PRs: `git log --merges --oneline <from>..<to>`
- [ ] Identify linked issues if available

**Checkpoint: present the raw list of changes (commits, PRs, issues) and confirm the range is correct.**

### Phase 2: Categorize Changes

Group by type:
- **New Features**: New capabilities users can use
- **Improvements**: Enhancements to existing features
- **Bug Fixes**: Corrections to broken behavior
- **Breaking Changes**: Changes that require user action
- **Deprecations**: Features that will be removed in future
- **Performance**: Speed or resource improvements
- **Security**: Vulnerability fixes (mention CVEs if applicable)
- **Internal**: Refactors, dependency updates, CI changes (may omit for user-facing notes)

**Checkpoint: present the categorized changes. Confirm nothing is miscategorized or missing before drafting.**

### Phase 3: Draft the Notes

For each entry:
- Lead with the user impact, not the technical detail
- Link to PRs/issues where applicable
- Breaking changes get migration instructions

Format:
```markdown
# Release vX.Y.Z (YYYY-MM-DD)

## Highlights
One paragraph summary of the most important changes.

## New Features
- **Feature name**: Brief description of what users can now do (#PR)

## Improvements
- **Area**: What improved and how (#PR)

## Bug Fixes
- Fix description — what was broken and is now correct (#PR)

## Breaking Changes
- **What changed**: Migration steps (#PR)

## Security
- Description (CVE-XXXX-XXXXX if applicable)
```

### Phase 4: Review

- [ ] Every significant change is represented
- [ ] Breaking changes have clear migration paths
- [ ] Language is clear to the target audience
- [ ] No internal jargon in user-facing notes
- [ ] Version number and date are correct

## Rules

- Don't list every commit — group and summarize
- Breaking changes always go first or get their own callout
- Security fixes get credited if the reporter wants it
- If unsure about a change's impact, read the PR/diff rather than guessing from the commit message
