# Codex Configuration

This folder contains Codex-specific configuration assets for your coding agents repo.

## Core Files

- `SYSTEM.md`: baseline behavior and guardrails
- `WORKFLOWS.md`: bugfix/feature/review execution flows
- `TOOLS.md`: command and safety conventions
- `MODELS.md`: model and reasoning selection guidance
- `CODE_STYLE.md`: code style baseline
- `TESTING.md`: testing policy
- `SECURITY.md`: security baseline
- `PR_TEMPLATE.md`: pull request structure

## Install

Install skills from this repo into `~/.codex/`:

```bash
./codex/scripts/install.sh
```

## Export

Capture local skills back into the repo:

```bash
./codex/scripts/export.sh
```

## Skills

- `skills/`: mirrored copy of local Codex skills from `~/.codex/skills`
- `skills.manifest.txt`: current inventory of skills

## Additional Assets

- `scripts/bootstrap.sh`: quick setup helper
- `examples/`: prompt examples
- `checklists/`: execution checklists
- `mcp/`: MCP config templates
- `templates/`: project-specific overrides
