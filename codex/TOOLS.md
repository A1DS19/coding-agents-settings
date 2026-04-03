# Codex Tooling Policy

## Shell
- Prefer `rg` / `rg --files` for search.
- Use non-interactive commands when possible.
- Use scripts for repeatable sync/setup operations.

## Git
- Avoid `git reset --hard`, `git checkout --`, force pushes unless explicitly requested.
- Do not amend commits unless requested.

## Validation
- Run the smallest useful test set first, then broaden as needed.
- If tests cannot run, report exactly why.
