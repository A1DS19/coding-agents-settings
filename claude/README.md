# Claude Configuration

This folder contains Claude-specific agent configuration assets.

## Structure

- `agents/` — custom agent prompts, mirrored from `~/.claude/agents` ([docs](agents/README.md))
- `hooks/` — hook event reference and ready-to-use examples ([docs](hooks/README.md))
- `settings/` — settings.json schema reference and example config ([docs](settings/README.md))
- `claude-md/` — CLAUDE.md templates for global and per-project use ([docs](claude-md/README.md))
- `scripts/install.sh` — install everything from this repo into `~/.claude/`
- `scripts/export.sh` — capture local `~/.claude/` changes back into this repo

## Agents

Each agent is a standalone markdown prompt that follows a multi-phase explore → analyze → execute → verify pattern with checkpoints between phases. See [agents/README.md](agents/README.md) for full details on phases, rules, and customization.

| Agent | What it does | When to use |
|-------|-------------|-------------|
| `code-review` | Thorough review for bugs, security, performance, and maintainability | Reviewing PRs, diffs, or your own changes |
| `debug` | Systematic root-cause analysis with ranked hypotheses | Bug reports, errors, failing tests, crashes |
| `write-tests` | Behavior-first test coverage matching project conventions | Adding unit, integration, or e2e tests |
| `security-audit` | OWASP-based review of code, configs, and dependencies | Security reviews, auth/payment/data-handling code |
| `refactor` | Safe incremental restructuring with tests as a safety net | Improving structure, reducing complexity, extracting modules |
| `pr-create` | Organized commits and well-structured PR descriptions | Opening PRs, pushing changes upstream |
| `onboard` | Architecture overview, key paths, and gotchas | New to a project, understanding how a system works |
| `release-notes` | Categorized changelogs generated from git history | Preparing releases or summarizing changes |
| `dependency-audit` | Vulnerability, freshness, and license compliance checks | Auditing or updating project dependencies |
| `incident-response` | Assess, investigate, mitigate, post-mortem | Production issues, outages, error spikes, on-call triage |
| `grill-me` | Stress-test a plan or design through one-at-a-time questioning | Fleshing out ideas, resolving design decisions before building |
| `improve-architecture` | Find architectural friction and propose deep module refactors | Reducing coupling, improving testability, simplifying navigation |

### How to use

Agents are activated by mentioning them in conversation with Claude Code:

```
"review this PR"                → code-review
"debug this failing test"       → debug
"write tests for src/auth/"     → write-tests
"grill me on this design"       → grill-me
```

You can also invoke them explicitly: *"use the security-audit agent on this repo"*.

## Hooks

Hooks are shell commands that run automatically before/after tool calls. Use them to enforce guardrails (block commits to main), automate quality checks (lint after edits), or trigger notifications.

```json
{
  "hooks": {
    "PreToolUse": [{"matcher": "Bash", "hooks": [{"type": "command", "command": "..."}]}],
    "PostToolUse": [{"matcher": "Edit", "hooks": [{"type": "command", "command": "..."}]}]
  }
}
```

See [hooks/README.md](hooks/README.md) for events, matchers, environment variables, and [examples.json](hooks/examples.json) for copy-paste configurations. Ready-to-use per-project templates are in [hooks/templates/](hooks/templates/) (JavaScript, Python, Go, Rust).

## Settings

`~/.claude/settings.json` controls model selection, tool permissions, MCP servers, hooks, and environment variables. Per-project settings in `.claude/settings.json` layer on top of global.

See [settings/README.md](settings/README.md) for the full schema and [settings.json](settings/settings.json) for the canonical config.

## CLAUDE.md Templates

CLAUDE.md files give Claude persistent instructions loaded at the start of every conversation. They can be global (`~/.claude/CLAUDE.md`), per-project, or per-folder, and are layered in that order.

See [claude-md/README.md](claude-md/README.md) for placement guidance, writing tips, and templates:
- [CLAUDE.md](claude-md/CLAUDE.md) — global config (installed to `~/.claude/CLAUDE.md`)
- [project.example.md](claude-md/project.example.md) — per-project template (copy into your repo)

## Install

Run from repo root to install everything into `~/.claude/`:

```bash
./claude/scripts/install.sh
```

This copies agents, settings.json, and CLAUDE.md from this repo into your local Claude config. The repo is the single source of truth — edit configs here, then re-run the script to apply.

## Export

Capture local changes back into the repo:

```bash
./claude/scripts/export.sh
```

Useful when you've experimented with agents or settings locally and want to save them. Review with `git diff` before committing.
