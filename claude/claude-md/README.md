# CLAUDE.md Templates

CLAUDE.md files give Claude persistent instructions that are loaded automatically at the start of every conversation. They're the primary way to shape Claude's behavior for your workflow.

## Where CLAUDE.md files live

| Location | Scope | Loaded when |
|----------|-------|-------------|
| `~/.claude/CLAUDE.md` | Global | Every conversation, in any project |
| `<project-root>/CLAUDE.md` | Project | Conversations in that project directory |
| `<subfolder>/CLAUDE.md` | Folder | Conversations whose working directory includes that folder |

Files are loaded in order: global → project root → subfolder. All are combined, so you can layer instructions.

## What to put where

### Global (`~/.claude/CLAUDE.md`)

Instructions that apply everywhere, regardless of project:

- Working style preferences (plan first, be concise, etc.)
- Git workflow conventions (branch naming, commit style)
- Review standards
- Personal rules ("never commit to main", "always run tests before suggesting done")

See [CLAUDE.md](CLAUDE.md) for the global config (installed by `scripts/install.sh`).

### Project (`<project-root>/CLAUDE.md`)

Instructions specific to one codebase:

- Tech stack and architecture overview
- Build/test/lint commands
- Key directories and their purposes
- Project-specific conventions (naming, patterns, error handling)
- Links to important docs or dashboards

See [project.example.md](project.example.md) for a starter template.

### Folder (`<subfolder>/CLAUDE.md`)

Narrow instructions for a specific area of the codebase:

- Module-specific patterns ("all handlers in this folder return Result types")
- Test conventions for a subsystem
- Generated code warnings ("don't edit files in this folder — they're auto-generated")

## Writing effective CLAUDE.md

**Do:**
- Be specific and actionable: `Run "npm test" before suggesting a task is complete`
- State conventions Claude can't infer: `We use barrel exports in src/components/index.ts`
- Include build/test commands: `Build: npm run build, Test: npm test, Lint: npm run lint`

**Don't:**
- Repeat what's obvious from the code (file structure, import patterns)
- Write essay-length instructions — Claude reads the whole file every conversation
- Include secrets or credentials
- Duplicate what's in package.json, tsconfig, etc.

## Tips

- Keep it under ~50 lines per file — shorter is better
- Update it when you notice Claude repeating mistakes
- Use it alongside hooks for defense in depth: CLAUDE.md guides behavior, hooks enforce it
- Commit project-level CLAUDE.md to the repo so the whole team benefits
