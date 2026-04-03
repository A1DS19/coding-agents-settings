# Coding Agents Config

Central configuration repository for coding agent prompts, settings, hooks, and workflows. Edit configs here, run the install script, and your local agent setup stays in sync.

## Agents

| Folder | Agent | What's inside |
|--------|-------|---------------|
| [`claude/`](claude/README.md) | [Claude Code](https://claude.ai/code) | 12 custom agents, global hooks, settings.json, CLAUDE.md templates |
| [`codex/`](codex/README.md) | Codex | System prompts, workflows, tools, skills, code style, testing & security policies |
| [`gemini/`](gemini/README.md) | Gemini | *(scaffold — config pending)* |

## Quick start

### Claude Code

```bash
# Install agents, settings, hooks, and CLAUDE.md into ~/.claude/
./claude/scripts/install.sh
```

This copies everything from `claude/` into your local `~/.claude/` directory. The repo is the single source of truth — edit here, re-run to apply.

### Codex

```bash
# Sync skills from ~/.codex/ into the repo (backup direction)
./codex/scripts/sync_skills.sh
```

## What's configured

### Claude

| Feature | Description | Docs |
|---------|-------------|------|
| **Agents** | 12 task-specific agents (code review, debug, testing, security audit, etc.) | [claude/agents/](claude/agents/README.md) |
| **Hooks** | Global safety guardrails — block main commits, force push, secret leaks; test reminders | [claude/hooks/](claude/hooks/README.md) |
| **Settings** | Model selection, tool permissions, MCP servers, environment variables | [claude/settings/](claude/settings/README.md) |
| **CLAUDE.md** | Global instructions (plan-first workflow, code quality rules, git conventions) | [claude/claude-md/](claude/claude-md/README.md) |

### Codex

| Feature | Description |
|---------|-------------|
| **System prompts** | Baseline behavior, guardrails, reasoning guidance |
| **Workflows** | Bugfix, feature, and review execution flows |
| **Policies** | Code style, testing, security, PR templates |
| **Skills** | Mirrored from local Codex installation |

## Repository structure

```
.
├── claude/
│   ├── agents/          # 12 custom agent prompts
│   ├── hooks/           # Hook reference + examples (global & per-project)
│   ├── settings/        # settings.json schema + canonical config
│   ├── claude-md/       # CLAUDE.md templates (global + per-project)
│   └── scripts/         # install.sh
├── codex/
│   ├── skills/          # Mirrored Codex skills
│   ├── scripts/         # sync + bootstrap scripts
│   ├── templates/       # Prompt templates
│   └── *.md             # System, workflows, tools, style, testing, security
└── gemini/
    └── README.md        # Scaffold
```

## Design principles

- **Repo is source of truth** — don't edit `~/.claude/` directly, edit here and install
- **Global vs per-project** — safety hooks go global, language-specific tools go per-project
- **Defense in depth** — CLAUDE.md guides behavior, hooks enforce it, permissions block the worst
- **One script to install** — `./claude/scripts/install.sh` gets a new machine fully configured
