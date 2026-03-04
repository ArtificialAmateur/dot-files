---
name: audit-plan
description: Plan a security audit with vulnerability patterns, tool strategy, and review checkpoints. Use when starting a code audit or vulnerability research campaign.
user_invocable: true
---

# Security Audit Plan

Create a security audit plan. Interview the user if scope is unclear —
use AskUserQuestion to gather: target codebase/component, language,
audit goals (full audit vs. targeted), prior findings, time budget.

## Required Sections

### 1. Scope Definition

- Target component/subsystem and boundaries
- Language(s) and build system
- Lines of code estimate
- Entry points (syscalls, ioctls, IPC, network, file ops)
- Trust boundaries and privilege transitions

### 2. Threat Model

- Attacker model (local unprivileged, app sandbox, remote)
- High-value targets (credential stores, crypto, policy checks)
- Historical vulnerability patterns in this codebase
- Related CVEs and prior audits

### 3. Static Analysis Strategy

| Tool | Target | Query/Ruleset |
|------|--------|---------------|
| Semgrep | Pattern matching | Language-specific rulesets |
| CodeQL | Data flow / taint | CWE-specific queries |
| ast-grep | Structural patterns | Custom patterns for this codebase |

For each tool: define specific queries, expected false positive rate,
and triage approach.

### 4. Manual Review Focus Areas

Prioritized list of code paths for manual review, with rationale:

1. **Authentication/authorization** — policy enforcement, capability
   checks, credential validation
2. **Memory safety** — allocator interactions, bounds checks, lifetime
   management, use-after-free patterns
3. **Concurrency** — lock ordering, TOCTOU, race conditions in
   shared state
4. **Input validation** — parsers, deserializers, format handlers
5. **Cryptographic usage** — key management, nonce reuse, algorithm
   choice, side channels

### 5. Variant Analysis Seeds

For each finding during the audit, define variant patterns:
- Structural pattern (ast-grep rule)
- Data flow pattern (CodeQL query)
- Grep pattern for quick scan

### 6. Review Checkpoints

| Checkpoint | Criteria | Deliverable |
|------------|----------|-------------|
| Scope complete | Entry points mapped | Entry point catalog |
| Static analysis done | All tools run, triaged | Finding spreadsheet |
| Manual review 50% | Priority paths reviewed | Interim findings |
| Manual review 100% | All paths reviewed | Draft report |
| Variant analysis | Seeds expanded | Variant finding list |
| Final | All findings confirmed | Final report |

### 7. Task Decomposition

Numbered tasks with:
- Estimated effort (hours)
- Acceptance criteria
- Tool requirements
- Dependencies

## Output

Write the plan to `docs/plans/<target>-audit-plan.md` in the project
root. If no project context, write to the current directory.
