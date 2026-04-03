# Hooks

Hooks are shell commands that Claude Code executes automatically in response to events. They enforce guardrails, run linters, trigger notifications, and automate repetitive steps — without relying on Claude remembering instructions.

## How hooks work

Hooks are configured in `~/.claude/settings.json` (global) or `.claude/settings.json` (per-project) under the `hooks` key. Each hook specifies:

- **Event**: When to run (before/after a tool call, on conversation start, etc.)
- **Matcher**: Optional filter to narrow which tool calls trigger the hook
- **Command**: The shell command to execute

## Hook events

| Event | Fires when | Common use |
|-------|-----------|------------|
| `PreToolUse` | Before a tool is executed | Block dangerous commands, validate inputs |
| `PostToolUse` | After a tool completes | Lint after edits, run tests after writes |
| `Notification` | Claude sends a notification | Forward to Slack, desktop alert, sound |
| `Stop` | Claude finishes a response | Auto-review, summary logging |

## Matcher syntax

Matchers filter by tool name. Available tool names include:

- `Bash` — shell commands
- `Edit` — file edits
- `Write` — file creation/overwrite
- `Read` — file reads

Example: a `PostToolUse` hook with matcher `Edit` only fires after file edits, not after bash commands.

## Hook configuration format

```json
{
  "hooks": {
    "<Event>": [
      {
        "matcher": "<ToolName>",
        "hooks": [
          {
            "type": "command",
            "command": "your-shell-command"
          }
        ]
      }
    ]
  }
}
```

### Blocking vs non-blocking

- **PreToolUse** hooks can block the action. If the command exits with a non-zero status, Claude will not execute the tool and will see the hook's stderr output as feedback.
- **PostToolUse** hooks run after the fact. A non-zero exit is reported to Claude but doesn't undo the action.

## Global vs per-project

| Scope | Where | Best for |
|-------|-------|----------|
| Global | `~/.claude/settings.json` | Safety guardrails that apply everywhere (block main commits, block force push, block secrets) |
| Per-project | `.claude/settings.json` in repo | Language-specific linting, formatting, project-specific checks |

Per-project hooks **extend** global hooks — both run. You don't need to repeat global hooks in per-project settings.

**Rule of thumb**: if the hook is about safety or workflow, make it global. If it's about a specific language or toolchain, make it per-project.

## Active global hooks

These are configured in [settings.json](../settings/settings.json) and installed by `scripts/install.sh`:

| Hook | Event | What it does |
|------|-------|-------------|
| Block main commits | `PreToolUse` | Prevents git commit/push on main/master |
| Block force push | `PreToolUse` | Prevents `git push --force` |
| Block secret commits | `PreToolUse` | Prevents `git add` of .env/credentials/secrets |
| Test reminder | `PostToolUse` | Reminds to update tests when source files are written |

## Per-project examples

Add these to a specific repo's `.claude/settings.json`. See [examples.json](examples.json) for all examples.

### ESLint on edit (JS/TS projects)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [{"type": "command", "command": "npx eslint --fix $CLAUDE_FILE_PATH 2>&1 || true"}]
      }
    ]
  }
}
```

### Ruff on edit (Python projects)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [{"type": "command", "command": "if echo \"$CLAUDE_FILE_PATH\" | grep -qE '\\.py$'; then ruff check --fix $CLAUDE_FILE_PATH 2>&1 || true; fi"}]
      }
    ]
  }
}
```

## Per-project templates

Ready-to-copy `.claude/settings.json` files for common project types in [templates/](templates/):

| Template | Tools | File |
|----------|-------|------|
| JavaScript/TypeScript | ESLint + Prettier | [`javascript.json`](templates/javascript.json) |
| Python | ruff (lint + format) | [`python.json`](templates/python.json) |
| Go | gofmt + go vet | [`go.json`](templates/go.json) |
| Rust | cargo fmt + clippy | [`rust.json`](templates/rust.json) |

To use: copy the template into your project root as `.claude/settings.json`:

```bash
mkdir -p .claude
cp /path/to/coding-agents-config/claude/hooks/templates/python.json .claude/settings.json
```

## Environment variables available in hooks

| Variable | Description |
|----------|-------------|
| `CLAUDE_TOOL_NAME` | Name of the tool being called |
| `CLAUDE_TOOL_INPUT` | JSON string of the tool's input parameters |
| `CLAUDE_FILE_PATH` | File path (for Edit/Write/Read tools) |
| `CLAUDE_SESSION_ID` | Current session identifier |

## Tips

- Keep hooks fast — they run synchronously and slow hooks degrade the experience
- Use `|| true` on PostToolUse hooks if you don't want failures to distract Claude
- Test hooks outside Claude first: `CLAUDE_FILE_PATH=test.ts bash -c 'your-command'`
- Combine with CLAUDE.md instructions for defense in depth (hooks enforce, instructions guide)
