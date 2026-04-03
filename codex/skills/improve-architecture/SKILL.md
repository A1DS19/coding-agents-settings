---
name: improve-architecture
description: Explore codebase to find architectural improvements and propose deep module refactors. Use when I want to improve code structure, reduce coupling, make code more testable, or make the codebase easier to navigate and work with.
---

# Improve Codebase Architecture

Explore the codebase to identify architectural friction and propose refactors toward **deep modules** — small interfaces hiding large implementations (from John Ousterhout's "A Philosophy of Software Design").

The friction you encounter while exploring IS the signal. If understanding a feature requires bouncing between many small files, that's a candidate.

## Process

### Phase 1: Explore Organically

Navigate the codebase without a rigid checklist. Note friction as you go:

- **Shallow modules**: Files that are mostly boilerplate, delegating to other shallow modules
- **Shotgun surgery**: Changing one behavior requires touching many files across directories
- **Excessive file-bouncing**: Understanding a single flow requires opening 8+ files
- **Leaky abstractions**: Internal details exposed through interfaces
- **Test brittleness**: Tests that break when internals change but behavior doesn't

Don't apply heuristics mechanically — feel the codebase and notice where it resists understanding.

**Checkpoint: present friction points found before formalizing candidates.**

### Phase 2: Present Candidates

List 3-5 deepening opportunities. For each:

```markdown
### Candidate: [Name]
- **Cluster**: [files/modules involved]
- **Coupling**: [why these are tangled — shared state, circular deps, etc.]
- **Symptom**: [what makes this painful — hard to test, hard to change, hard to understand]
- **Potential**: [what a deep module here could look like — one sentence]
```

Don't propose interfaces yet — just identify the opportunities.

### Phase 3: I Choose a Candidate

Wait for me to pick which one to explore.

### Phase 4: Frame the Problem

Before designing, explain:
- What constraints exist (backwards compat, performance, existing consumers)
- What dependencies are involved
- Illustrative code sketches showing the current pain (not proposals)

### Phase 5: Design Multiple Interfaces

Explore 3+ radically different designs, each under a different constraint:

| Design | Constraint |
|--------|-----------|
| A | Minimize surface area — smallest possible interface |
| B | Maximize flexibility — most extensible design |
| C | Optimize for the common case — 80/20 rule |
| D | (optional) Ports & adapters — maximum testability |

For each design, produce:
- **Signatures**: The public interface (types, functions, methods)
- **Usage example**: How calling code looks
- **What's hidden**: Complexity moved behind the interface
- **Trade-offs**: What you gain and what you lose
- **Migration path**: How to get from current to proposed

### Phase 6: I Choose a Design

Present a recommendation with rationale, then wait for my decision.

### Phase 7: Create the Refactor Plan

Produce a concrete plan:

```markdown
## Refactor: [Name]

### Goal
[One sentence — what this achieves]

### Design
[The chosen interface with signatures]

### Migration Steps
1. [Small, incremental step — tests pass after each]
2. ...

### Files Affected
- [file]: [what changes]

### Risks
- [What could go wrong, what to watch for]

### Definition of Done
- [ ] New module passes all tests
- [ ] Old consumers migrated
- [ ] Old code removed
- [ ] No behavior changes
```

## What Makes a Deep Module

```
Shallow (bad):          Deep (good):
┌─────────────────┐    ┌─────────────────┐
│   wide interface │    │ narrow interface │
├─────────────────┤    ├─────────────────┤
│ thin impl       │    │                 │
└─────────────────┘    │  deep impl      │
                       │                 │
                       │                 │
                       └─────────────────┘
```

A deep module:
- Has a small, simple interface
- Hides significant complexity behind it
- Can be tested through its interface without mocking internals
- Can be understood without reading its implementation
- Makes the codebase easier to navigate — fewer files to bounce between
