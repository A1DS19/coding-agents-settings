# Claude Code Agents

Personal collection of Claude Code agents for solo developer workflows. Each agent uses multi-phase planning with checkpoints — it explores first, presents findings, and waits for approval before proceeding.

## Agents

| Agent                  | What it does                                                          |
| ---------------------- | --------------------------------------------------------------------- |
| `code-review`          | Review PRs and diffs for bugs, security, performance, maintainability |
| `write-tests`          | Add test coverage — behavior-first, matches project conventions       |
| `debug`                | Systematic root cause analysis with ranked hypotheses                 |
| `security-audit`       | OWASP-based security review of code, configs, and dependencies        |
| `refactor`             | Safe incremental restructuring with tests as safety net               |
| `pr-create`            | Create well-structured PRs with organized commits and descriptions    |
| `onboard`              | Understand unfamiliar codebases — architecture, key paths, gotchas    |
| `release-notes`        | Generate changelogs from git history, categorized by type             |
| `dependency-audit`     | Vulnerability, freshness, and license checks                          |
| `incident-response`    | Production triage — assess, investigate, mitigate, post-mortem        |
| `grill-me`             | Stress-test a plan or design through intensive interviewing           |
| `improve-architecture` | Find architectural friction and propose deep module refactors         |

## Installation

Clone into your Claude Code agents directory:

```bash
git clone <repo-url> ~/.claude/agents
```

Or if you already have a `~/.claude/` directory:

```bash
git clone <repo-url> /tmp/agents && cp /tmp/agents/*.md ~/.claude/agents/
```

## How They Work

Every agent follows the same multi-phase pattern:

```
Phase 1: Explore    → Read code, gather context, understand the problem
         Checkpoint → Present findings, wait for input
Phase 2: Analyze    → Form plan, hypotheses, or candidates
         Checkpoint → Present approach, wait for approval
Phase 3: Execute    → Do the work in small increments
Phase 4: Verify     → Confirm results, summarize
```

Agents never jump straight to execution. Each checkpoint is a gate where you can redirect, narrow scope, or ask questions before moving on.

## Customization

Each agent is a standalone markdown file with frontmatter:

```yaml
---
name: agent-name
description: When to use this agent (triggers agent selection)
---
```

The `description` field is what Claude uses to decide which agent to activate. Edit it to match your vocabulary and workflow.

## Global Config

For plan-mode-by-default and other global behaviors, add a `~/.claude/CLAUDE.md`:

```markdown
Always start in plan mode. Think through the approach before making changes.
Present a plan and wait for approval before executing.
```
