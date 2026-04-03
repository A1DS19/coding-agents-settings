# Security Baseline

## Secrets
- Never hardcode secrets or tokens.
- Use environment variables or secret managers.

## Dependencies
- Prefer pinned versions for critical dependencies.
- Review advisories before upgrades in sensitive services.

## Review Checklist
- Input validation present
- Authz/authn boundaries preserved
- No sensitive data in logs
