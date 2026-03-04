# Global Development Standards

Global instructions for all projects. Project-specific CLAUDE.md files override these defaults.

## Domain

Android security research and exploit engineering. Primary languages: C and Python. Language-specific conventions (toolchains, linters, build flags) are in `~/.claude/rules/`.

## Philosophy

- **No speculative features** — Don't add features, flags, or configuration unless actively needed
- **No premature abstraction** — Don't create utilities until you've written the same code three times
- **Clarity over cleverness** — Prefer explicit, readable code over dense one-liners
- **Justify new dependencies** — Each dependency is attack surface and maintenance burden
- **Replace, don't deprecate** — Remove old implementations entirely. No backward-compatible shims or dual config formats. Flag dead code.
- **Verify at every level** — Prefer structure-aware tools (ast-grep, LSPs, compilers) over text pattern matching. Review your own output critically.
- **Bias toward action** — Decide and move for anything easily reversed; state your assumption. Ask before committing to interfaces, data models, or destructive operations.
- **Finish the job** — Handle edge cases you can see. Clean up what you touched. But don't invent new scope.
- **Research before building** — Before starting a new project, tool, or feature, search for existing solutions (GitHub, package registries, prior research). If something exists: prefer using it over building your own; integrate it if it complements your tool; or study its architecture and salvage the best ideas. Don't reinvent what's already been solved well.
- **Agent-native by default** — Design so agents can achieve any outcome users can. Use skills proactively when they match the task. Prefer file-based state for transparency and portability.

## Code Quality

### Hard limits

1. ≤100 lines/function, cyclomatic complexity ≤8
2. ≤5 positional params
3. 100-char line length
4. Absolute imports only — no relative (`..`) paths
5. Doc comments required (language-specific format in `~/.claude/rules/`) — no file-level comments

### Zero warnings policy

Fix every warning from every tool — linters, type checkers, compilers, tests. If a warning truly can't be fixed, add an inline ignore with a justification comment. Never leave warnings unaddressed; a clean output is the baseline, not the goal.

### Comments

Code should be self-documenting. No commented-out code—delete it. If you need a comment to explain WHAT the code does, refactor the code instead. Comments explain "why" not "what". Use `// NOTE:` for non-obvious constraints, `// TODO:` for known limitations.

### Over-engineering guards

- Solve the problem in front of you, not the general case. If the requirement says "parse X," don't build a pluggable parser framework.
- Three concrete uses before any abstraction — interfaces, factories, registries, and plugin systems all require justification from real, current callers.
- One layer of indirection maximum. If you need a second, the design is wrong.
- No configuration for things that have one value. Constants are fine.
- Delete scaffolding that "might be useful later." Later never comes, and if it does, writing it fresh with real requirements produces better code.
- If the simple version works and the clever version is "more extensible," ship the simple version.

### Error handling

- Fail fast with clear, actionable messages
- Never swallow exceptions silently
- Include context (what operation, what input, suggested fix)

### Reviewing code

Evaluate in order: architecture → code quality → tests → performance. Before reviewing, sync to latest remote (`git fetch origin`).

For each issue: describe concretely with file:line references, present options with tradeoffs when the fix isn't obvious, recommend one, and ask before proceeding.

### Testing

**Test behavior, not implementation.** Tests should verify what code does, not how. If a refactor breaks your tests but not your code, the tests were wrong.

**Test edges and errors, not just the happy path.** Empty inputs, boundaries, malformed data, missing files, network failures — bugs live in edges. Every error path the code handles should have a test that triggers it.

**Mock boundaries, not logic.** Only mock things that are slow (network, filesystem), non-deterministic (time, randomness), or external services you don't control.

**Verify tests catch failures.** Break the code, confirm the test fails, then fix. Use mutation testing (`mutmut`) to verify systematically. Use property-based testing (`hypothesis`) for parsers, serialization, and algorithms.

## Problem Solving & Debugging

- Before proposing solutions or theories, read the actual codebase and understand existing implementation constraints. Do not suggest generic approaches or guess at root causes — read the relevant code, configs, and logs first. Ask clarifying questions about constraints (language, build system, platform, what's already been ruled out) before starting work.
- When the user asks where a setting/variable is being set in their environment, start by tracing the shell init chain (`.zshrc` → sourced files → plugin managers) rather than guessing common locations.
- When multiple theories exist, use parallel read-only sub-agents to investigate each one independently rather than guessing linearly. Each agent examines specific files/commands for its theory, then synthesize findings before proposing a solution.

## Development

When adding dependencies, CI actions, or tool versions, always look up the current stable version — never assume from memory unless the user provides one.

### CLI tools

| tool | replaces | usage |
|------|----------|-------|
| `rg` (ripgrep) | grep | `rg "pattern"` - 10x faster regex search |
| `fd` | find | `fd "*.py"` - fast file finder |
| `ast-grep` | - | `ast-grep --pattern '$FUNC($$$)' --lang py` - AST-based code search |
| `shellcheck` | - | `shellcheck script.sh` - shell script linter |
| `shfmt` | - | `shfmt -i 2 -w script.sh` - shell formatter |
| `actionlint` | - | `actionlint .github/workflows/` - GitHub Actions linter |
| `zizmor` | - | `zizmor .github/workflows/` - Actions security audit |
| `prek` | pre-commit | `prek run` - fast git hooks (Rust, no Python) |
| `wt` | git worktree | `wt switch branch` - manage parallel worktrees |
| `trash` | rm | `trash file` - recoverable delete. **Never use `rm -rf`** |

Prefer `ast-grep` over ripgrep when searching for code structure (function calls, class definitions, imports, pattern matching across arguments). Use ripgrep for literal strings and log messages.

## Build & Deploy

Before iterating on any fix, verify the build system picks up source changes. Confirm the workspace is the actual build location and that edited files are what gets compiled/deployed. For Android/embedded work, ask the user to confirm the build source location matches the editing location.

Projects use git submodules for dependencies — run `git submodule update --init` if builds fail on missing headers. Build outputs include `.so` binaries, `.syms` symbol files, and `.tar` archives.

## MCP & Integrations

For MCP server integrations: always test the connection end-to-end after setup. Verify the server appears in `claude mcp list` and that tool calls return data. Common issues: MCP-over-MCP indirection causing hangs, missing timeouts, incorrect registration syntax.

## Workflow

**Before committing:**

1. Re-read your changes for unnecessary complexity, redundant code, and unclear naming
2. Run relevant tests — not the full suite
3. Run linters and type checker — fix everything before committing

**Commits:**

- Imperative mood, lowercase, short and direct (aim for ≤50 chars), one logical change per commit
- Subject only — no body unless the change needs a brief explanation
- Never amend/rebase commits already pushed to shared branches
- Never push directly to main — use feature branches and PRs
- Never commit secrets, API keys, or credentials — use `.env` files (gitignored) and environment variables

**Hooks and worktrees:**

- Install prek in every repo (`prek install`). Run `prek run` before committing. Configure auto-updates: `prek auto-update --cooldown-days 7`
- Parallel subagents require worktrees. Each subagent MUST work in its own worktree (`wt switch <branch>`), not the main repo. Never share working directories.

**Plan execution:**

Plan-then-execute is the default workflow for any non-trivial task. Before writing any code: 1) read existing plan/design docs, 2) produce a numbered task list with acceptance criteria for each task, 3) wait for approval before starting implementation.

Always use sub-agent driven plan execution (sequential, one agent at a time). Never use parallel agents for *implementation* — sequential execution keeps state coherent, avoids merge conflicts, and lets each step build on verified results. Parallel read-only agents for *investigation* and *analysis* are fine (see Debugging and Refactors below).

Execute the plan as written. Do not deviate, expand scope, or re-architect unless explicitly asked. If a step seems wrong, flag it and ask before changing course.

**Autonomous bug fix loops:**

When a test is failing, run an autonomous red-green loop: run the failing test, read the output, identify root cause by reading source, make the minimal fix, re-run the test, repeat until green, then run the full suite for regressions. Don't ask questions during the loop — use best judgment and keep iterating.

**Parallel investigation for refactors:**

For multi-file refactors or architectural changes, spawn parallel read-only sub-agents to independently investigate different approaches before editing anything. Each agent analyzes from a different angle (minimal change, consistency with existing patterns, cleanest architecture). Synthesize proposals and get approval before making any edits.

**Pull requests:**
Describe what the code does now — not discarded approaches, prior iterations, or alternatives. Only describe what's in the diff.

Use plain, factual language. A bug fix is a bug fix, not a "critical stability improvement." Avoid: critical, crucial, essential, significant, comprehensive, robust, elegant.
