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
# Install skills into ~/.codex/
./codex/scripts/install.sh
```

### Export (capture local changes back into repo)

```bash
./claude/scripts/export.sh    # Claude: agents, settings, CLAUDE.md
./codex/scripts/export.sh     # Codex: skills
```

## What's configured

### Claude

| Feature | Description | Docs |
|---------|-------------|------|
| **Agents** | 12 task-specific agents (code review, debug, testing, security audit, etc.) | [claude/agents/](claude/agents/README.md) |
| **Hooks** | Global safety guardrails + per-project templates (JS, Python, Go, Rust) | [claude/hooks/](claude/hooks/README.md) |
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
│   ├── hooks/           # Hook reference, examples, and per-project templates
│   │   └── templates/   # Ready-to-copy .claude/settings.json (JS, Python, Go, Rust)
│   ├── settings/        # settings.json schema + canonical config
│   ├── claude-md/       # CLAUDE.md templates (global + per-project)
│   └── scripts/         # install.sh + export.sh
├── codex/
│   ├── skills/          # Mirrored Codex skills
│   ├── scripts/         # install.sh, export.sh, bootstrap.sh
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
