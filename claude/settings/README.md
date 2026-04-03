# Settings

Claude Code settings are stored in JSON files that control model selection, permissions, MCP servers, hooks, and environment.

## Settings locations

| File | Scope | Typical use |
|------|-------|-------------|
| `~/.claude/settings.json` | Global (all projects) | Model preference, global hooks, MCP servers, plugins |
| `.claude/settings.json` | Per-project (repo root) | Project-specific permissions, hooks, MCP servers |

Per-project settings are merged on top of global settings. Project-level hooks and permissions extend (not replace) global ones.

## Schema reference

### `model`

Set the default model.

```json
{
  "model": "opus"
}
```

Options: `"opus"`, `"sonnet"`, `"haiku"`

### `permissions`

Control which tools and commands are auto-allowed without prompting.

```json
{
  "permissions": {
    "allow": [
      "Bash(git status)",
      "Bash(git diff)",
      "Bash(npm test)",
      "Read",
      "Glob",
      "Grep"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force)"
    ]
  }
}
```

- `allow`: Tool calls matching these patterns run without asking
- `deny`: Tool calls matching these patterns are always blocked
- Patterns support wildcards: `Bash(npm *)` allows any npm command

### `hooks`

Shell commands triggered by events. See [hooks/README.md](../hooks/README.md) for full documentation.

```json
{
  "hooks": {
    "PreToolUse": [...],
    "PostToolUse": [...],
    "Notification": [...],
    "Stop": [...]
  }
}
```

### `mcpServers`

Connect external tool servers to extend Claude's capabilities.

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name"],
      "env": {
        "API_KEY": "..."
      }
    }
  }
}
```

Common MCP servers:
- **Filesystem** — read/write files outside the project
- **PostgreSQL / SQLite** — query databases directly
- **GitHub** — interact with issues, PRs, repos
- **Slack** — send/read messages
- **Puppeteer** — browser automation

### `enabledPlugins`

Enable built-in or community plugins.

```json
{
  "enabledPlugins": {
    "clangd-lsp@claude-plugins-official": true
  }
}
```

### `env`

Set environment variables available to Claude's tools.

```json
{
  "env": {
    "NODE_ENV": "development",
    "DATABASE_URL": "postgresql://localhost:5432/dev"
  }
}
```

## Example

See [settings.json](settings.json) — this is the canonical config installed by `scripts/install.sh`.

## Tips

- Start minimal — only add settings you actually need
- Use project-level settings for repo-specific tools and permissions
- Keep secrets out of committed settings files — use `env` references or `.env` files
- Test permission patterns incrementally: add one, verify it works, then add more
