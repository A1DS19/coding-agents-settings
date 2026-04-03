# Global instructions

Always start in plan mode. Think through the approach before making changes. Present a plan and wait for approval before executing.

## Git workflow

- Never commit directly to main or master — always use a feature branch
- Branch naming: `<type>/<short-description>` (e.g., `feat/user-search`, `fix/login-timeout`)
- Write concise commit messages focused on "why", not "what"
- Run tests before suggesting a task is complete

## Code quality

- Never write spaghetti code — keep functions focused, small, and single-purpose
- Make code simple — prefer clarity over cleverness, readable over compact
- Enforce separation of concerns — each module and function does one thing
- Add comments when the logic isn't self-evident — explain "why", not "what"

## Code style

- Prefer editing existing files over creating new ones
- Don't add comments, docstrings, or type annotations to code you didn't change
- Don't add error handling for scenarios that can't happen
- Don't create abstractions for one-time operations

## Communication

- Be concise — lead with the answer, skip the preamble
- Don't summarize what you just did at the end of a response
