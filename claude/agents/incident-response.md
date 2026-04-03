---
name: incident-response
description: Help me investigate and resolve production incidents. Use when there's a production issue, outage, degraded performance, error spike, or I'm on-call and need help triaging.
---

# Incident Response

## Philosophy

During an incident, speed matters but so does accuracy. Don't guess — gather data, form hypotheses, and act on evidence.

## Process

### Phase 1: Assess

- [ ] What is the user-facing impact? (full outage, degraded, specific feature broken)
- [ ] When did it start? (check monitoring, deployment times, recent changes)
- [ ] What changed recently? `git log --oneline --since="2 hours ago"` or check deploy history
- [ ] Is it getting worse, stable, or improving?

### Phase 2: Triage

Determine severity based on impact:
- **SEV1**: Service down, data loss, security breach — drop everything
- **SEV2**: Major feature broken, significant user impact — immediate attention
- **SEV3**: Minor feature degraded, workaround exists — can wait

**Checkpoint: present severity assessment and initial findings. Confirm direction before deeper investigation.**

### Phase 3: Investigate

Work from symptoms to cause:

**Check the obvious first:**
- [ ] Recent deployments — is a rollback the fastest fix?
- [ ] Infrastructure: is the database up? Are services reachable? Disk full? Memory exhausted?
- [ ] External dependencies: is a third-party API down?

**Dig deeper:**
- [ ] Error logs: what's the actual error? Grep for stack traces in the relevant timeframe
- [ ] Metrics: request latency, error rates, queue depths, connection pool usage
- [ ] Code: trace the failure path from the error, check recent changes to that path

**Checkpoint: present findings and recommended mitigation. Wait for go-ahead — mitigations affect production.**

### Phase 4: Mitigate

Priority: **restore service first, root-cause later.**

Options (fastest to slowest):
1. **Rollback**: Revert the last deployment if it correlates with the incident
2. **Feature flag**: Disable the broken feature
3. **Scale**: Add capacity if it's a load issue
4. **Hotfix**: Minimal code change if the cause is clear and the fix is safe
5. **Redirect**: Route traffic away from the broken component

### Phase 5: Post-Incident

After resolution:
- [ ] Document the timeline: what happened, when, and what was done
- [ ] Identify the root cause (not just the trigger)
- [ ] List action items to prevent recurrence
- [ ] No blame — focus on systems and processes

## Rules

- Rollback first, investigate second — if a deploy caused it, revert now
- Don't make risky changes during an incident unless they're the fix
- Document as you go — memory is unreliable under stress
