---
name: security-audit
description: Security review of code, configs, and dependencies. Use when I ask for a security audit, want to check for vulnerabilities, am preparing for a security review, or am working on auth/payment/data-handling code.
---

# Security Audit

## Philosophy

Security isn't a feature you add — it's a property you maintain. Review code as an attacker would: where does untrusted input enter? Where does sensitive data flow? What assumptions can be violated?

## Process

### Phase 1: Explore — Map the Attack Surface

- [ ] Identify all entry points: API endpoints, form inputs, file uploads, webhooks, CLI args
- [ ] Trace data flow from entry to storage/output
- [ ] Identify trust boundaries: where does untrusted become trusted?
- [ ] List sensitive data: credentials, PII, tokens, financial data

**Checkpoint: present the attack surface map — entry points, trust boundaries, sensitive data flows. Wait for confirmation the scope is right before deep scanning.**

### Phase 2: Scan — OWASP Top 10 Check

**Injection** (SQL, NoSQL, Command, LDAP)
- [ ] Are queries parameterized? No string concatenation with user input?
- [ ] Are shell commands built from user input? Use allow-lists, not sanitization.
- [ ] Are file paths constructed from user input? Check for path traversal (`../`)

**Broken Authentication**
- [ ] Password hashing: bcrypt/scrypt/argon2 with proper cost factor?
- [ ] Session management: secure, httpOnly, sameSite cookies?
- [ ] Rate limiting on login/reset endpoints?
- [ ] No credentials in logs, error messages, or source code?

**Sensitive Data Exposure**
- [ ] Encryption at rest and in transit (TLS)?
- [ ] No secrets in code, configs committed to git, or environment logs?
- [ ] Proper data classification — PII handled correctly?
- [ ] Secure headers: HSTS, Content-Security-Policy, X-Frame-Options?

**Broken Access Control**
- [ ] Authorization checked on every request, not just UI hiding?
- [ ] IDOR prevention: can user A access user B's resources by changing an ID?
- [ ] Principle of least privilege: minimum necessary permissions?
- [ ] CORS configured restrictively?

**Security Misconfiguration**
- [ ] Debug mode disabled in production configs?
- [ ] Default credentials changed?
- [ ] Unnecessary ports, services, or endpoints disabled?
- [ ] Error messages don't leak stack traces or internal details?

**XSS (Cross-Site Scripting)**
- [ ] Output encoding on all user-controlled data in HTML/JS context?
- [ ] Content-Security-Policy header set?
- [ ] No `dangerouslySetInnerHTML` or equivalent with user data?

**Insecure Dependencies**
- [ ] Run dependency audit (`npm audit`, `pip audit`, `cargo audit`, etc.)
- [ ] Check for known CVEs in current versions
- [ ] Are dependencies pinned to prevent supply-chain attacks?

### Phase 3: Deep Dive — Code-Level Patterns

- [ ] No hardcoded secrets (search for: password, secret, key, token, api_key)
- [ ] Cryptography: using standard libraries, not custom implementations?
- [ ] Random number generation: crypto-secure where security matters?
- [ ] File uploads: validated type, size limits, stored outside webroot?
- [ ] Deserialization: no untrusted data deserialized with unsafe methods?
- [ ] Logging: no sensitive data in logs?

**Checkpoint: present all findings organized by severity before writing the final report.**

### Phase 4: Report

Structure findings by severity:

1. **Critical**: Exploitable now, leads to data breach or system compromise
2. **High**: Exploitable with some effort, significant impact
3. **Medium**: Requires specific conditions, moderate impact
4. **Low**: Minor issues, defense-in-depth improvements
5. **Informational**: Best practices, hardening suggestions

Each finding should include:
- **What**: The vulnerability
- **Where**: File and line
- **Impact**: What an attacker could do
- **Fix**: Specific remediation steps
