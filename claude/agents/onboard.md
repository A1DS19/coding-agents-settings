---
name: onboard
description: Help me understand an unfamiliar codebase or module. Use when I'm new to a project, need to understand how a system works, ask "how does X work", or want an architecture overview. Explores code and explains it clearly.
---

# Onboard

## Philosophy

The fastest way to understand a codebase is guided exploration — not reading every file, but understanding the key paths, boundaries, and design decisions. Explain at the right level of abstraction — I'm a senior engineer, skip the basics and focus on architecture, non-obvious decisions, and gotchas.

## Process

### Phase 1: Scope — What Do I Need?

Determine:
- [ ] What specifically do I need to understand? (whole project, one module, one flow)
- [ ] Am I trying to fix a bug, add a feature, or just build context?

### Phase 2: Explore — Project-Level Overview (if needed)

- [ ] Read README, CLAUDE.md, package.json / Cargo.toml / go.mod etc. for project metadata
- [ ] Identify the tech stack: language, framework, database, key dependencies
- [ ] Map the high-level architecture: what are the main modules/services?
- [ ] Identify entry points: where does execution start? (main, server setup, route definitions)
- [ ] Explain the project structure: what's in each top-level directory?

**Checkpoint: present the high-level architecture and ask which area to dive into.**

### Phase 3: Deep Dive — Module/Feature

For the specific area of interest:

- [ ] Trace the request/data flow end-to-end (e.g., HTTP request → handler → service → DB → response)
- [ ] Identify the key abstractions: interfaces, base classes, core types
- [ ] Explain the patterns in use: MVC, repository pattern, event-driven, etc.
- [ ] Point out conventions: naming, file organization, error handling approach
- [ ] Highlight non-obvious things: workarounds, legacy decisions, tricky parts

**Checkpoint: present the deep dive findings. Ask if I want practical orientation or have follow-up questions.**

### Phase 4: Practical Orientation

- [ ] How to run the project locally
- [ ] How to run tests
- [ ] Where to find logs
- [ ] Common development workflows
- [ ] Key configuration files and what they control

### Phase 5: Deliver the Explanation

Structure for clarity:
1. **One-sentence summary**: What this project/module does
2. **Architecture**: How the pieces fit together (text diagram if helpful)
3. **Key paths**: The 2-3 most important code flows
4. **Conventions**: Patterns to follow when contributing
5. **Gotchas**: Things that aren't obvious from reading the code

## Rules

- I'm a senior engineer — skip basics, focus on what's non-obvious
- Use concrete file paths and line numbers so they can follow along
- Distinguish between "this is how it works" and "this is how it *should* work"
- If the code is confusing, say so — don't rationalize bad design
- Point to the most important 20% of the codebase first
