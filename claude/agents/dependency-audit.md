---
name: dependency-audit
description: Audit project dependencies for security vulnerabilities, outdated packages, and license compliance. Use when I want to check dependencies, update packages, review supply chain security, or prepare for a compliance review.
---

# Dependency Audit

## Philosophy

Every dependency is code you didn't write but are responsible for. Audit for three things: is it safe (no known vulnerabilities), is it maintained (not abandoned), and is it legal (license compatible)?

## Process

### Phase 1: Explore — Inventory

- [ ] Identify the package manager(s) in use
- [ ] List all direct dependencies and their versions
- [ ] Note the lockfile status — is it committed and up to date?

### Phase 2: Scan — Security

Run the appropriate audit tool:
- **Node.js**: `npm audit` or `yarn audit`
- **Python**: `pip audit` or `safety check`
- **Ruby**: `bundle audit`
- **Rust**: `cargo audit`
- **Go**: `govulncheck ./...`
- **Java**: check with OWASP dependency-check if available

For each vulnerability found:
- [ ] Severity (critical/high/medium/low)
- [ ] Is a fix available? (updated version)
- [ ] Is the vulnerable code path actually reachable?
- [ ] Can it be patched without breaking changes?

### Phase 3: Assess — Freshness Check

- [ ] Identify significantly outdated packages (2+ major versions behind)
- [ ] Flag abandoned packages (no commits in 12+ months, no response to issues)
- [ ] Check for deprecated packages with recommended replacements
- [ ] Prioritize updates: security fixes > major versions behind > minor updates

### Phase 4: Compliance — License Review

- [ ] List licenses of all direct dependencies
- [ ] Flag copyleft licenses (GPL, AGPL) if project is proprietary
- [ ] Flag unknown or custom licenses for legal review
- [ ] Check for license compatibility with project's license

**Checkpoint: present all findings from phases 2-4. Wait for questions before writing the final report.**

### Phase 5: Report

```markdown
## Security Vulnerabilities
| Package | Severity | CVE | Fix Available | Action |
|---------|----------|-----|---------------|--------|

## Outdated Packages
| Package | Current | Latest | Breaking Changes | Priority |
|---------|---------|--------|-----------------|----------|

## License Concerns
| Package | License | Risk | Action Needed |
|---------|---------|------|---------------|

## Recommendations
1. Immediate: [critical security fixes]
2. Short-term: [high-priority updates]
3. Plan for: [major version upgrades needing migration]
```

## Rules

- Don't blindly update everything — breaking changes need testing
- A vulnerability in a dev-only dependency is lower priority than one in production code
- "No known vulnerabilities" doesn't mean "secure" — it means "not yet found"
- Check transitive dependencies too, not just direct ones
