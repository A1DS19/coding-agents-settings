---
name: grill-me
description: Intensive interview to stress-test a plan, design, or idea. Use when I say "grill me", want to flesh out an idea, need to think through a design, or want to resolve decision branches before building.
---

# Grill Me

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk through each branch of the design tree, resolving dependencies between decisions one-by-one.

## Rules

- Ask questions **one at a time**. Wait for my answer before moving on.
- For each question, suggest what you think the best answer is and why — I can accept, reject, or modify.
- If a question can be answered by exploring the codebase, do that first instead of asking me. Only ask when the answer requires a judgment call.
- Don't accept vague answers. If I say "it depends" or "probably", push me to commit to a specific decision or define the conditions.
- Track decisions as we go. When a decision changes an earlier one, flag the conflict.
- When all branches are resolved, produce a clean summary of every decision made, organized by topic.

## Phases

### Phase 1: Broad Strokes
1. What is this? What problem does it solve? Who/what is it for?
2. What's in and what's explicitly out? What's the smallest version that's useful?

### Phase 2: Interface & Data
3. How will it be used? What does the API/UI/CLI look like?
4. What state does it manage? Where does it live? What are the invariants?

### Phase 3: Edge Cases & Dependencies
5. What happens when things go wrong? Empty state? Concurrent access? Partial failure?
6. What does this depend on? What depends on this? What changes when this ships?

### Phase 4: Implementation
7. What's the hardest part? What are you least sure about?

**Checkpoint between each phase: summarize decisions so far and flag any conflicts before moving on.**

## Output

When all phases are complete, produce:

```markdown
## Decisions

### [Topic 1]
- Decision: [what was decided]
- Rationale: [why]
- Alternatives considered: [what was rejected and why]

### [Topic 2]
...

## Open Questions
- [Anything still unresolved]

## Next Steps
- [Concrete actions to take]
```
