---
name: new-project
description: Bootstrap a new project from templates with lean CLAUDE.md, proper file responsibility split, and .claude/ structure. Use when starting any new project.
user_invocable: true
---

# New Project Bootstrap

Set up a new project with the right file structure so CLAUDE.md stays
lean from day one.

## Step 1: Gather requirements

Use AskUserQuestion to collect:

1. **Project name** (kebab-case)
2. **Project type:** `mcp-plugin`, `python-tool`, or `c-exploit`
3. **One-line description**
4. **Project path** (where to create it)
5. For mcp-plugin: agent name, MCP server name
6. For c-exploit: target device, kernel version, Android version

## Step 2: Copy template

Read the matching template from `~/.claude/templates/<type>/` and
customize by replacing `{{PLACEHOLDER}}` values with the user's
answers.

**Templates available:**

| Type | Template path | Files |
|------|--------------|-------|
| `mcp-plugin` | `~/.claude/templates/mcp-plugin/` | CLAUDE.md, PROGRESS.md, STAGES.md |
| `python-tool` | `~/.claude/templates/python-tool/` | CLAUDE.md |
| `c-exploit` | `~/.claude/templates/c-exploit/` | CLAUDE.md |

## Step 3: Create project structure

For all types, create:

```
<project>/
├── CLAUDE.md              # From template (instructions only)
├── .claude/
│   └── rules/             # Empty, ready for path-scoped rules
├── docs/
│   └── plans/             # Empty, ready for design docs
└── tests/                 # Empty, ready for tests
```

Additional for `mcp-plugin`:
```
├── PROGRESS.md            # From template
├── STAGES.md              # From template (user fills in stages)
├── mcp_server/
│   └── __init__.py
├── agents/
│   └── <agent-name>.md    # Empty agent definition stub
└── pyproject.toml         # Python 3.13, mcp[cli], pytest, ruff
```

Additional for `python-tool`:
```
├── src/<package>/
│   └── __init__.py
└── pyproject.toml         # Python 3.13, pytest, ruff
```

Additional for `c-exploit`:
```
├── src/
├── include/
└── CMakeLists.txt         # Minimal CMake 3.23+ with Ninja
```

## Step 4: Initialize git

```bash
cd <project> && git init && git add -A && git commit -m "initial project structure"
```

## Step 5: Report

Tell the user:
- What was created and where
- Next step (fill in STAGES.md for mcp-plugin, or start coding)
- Remind: "Architecture and design notes go in `docs/`, not CLAUDE.md"

## File Responsibility Split

This is the core principle — enforce it in every template:

| File | Contains | Loaded |
|------|----------|--------|
| `CLAUDE.md` | Instructions for Claude (commands, rules, constraints) | Every message |
| `PROGRESS.md` | Living project state (stages, test counts, issues) | Start of session |
| `STAGES.md` | Stage scope definitions | When planning |
| `docs/plans/*.md` | Design docs and implementation plans | By task offset |
| `docs/architecture.md` | System design, component descriptions | On demand |
| `.claude/rules/*.md` | Path-scoped conventions | When editing matching files |

**CLAUDE.md must never contain:** architecture descriptions, roadmaps,
open questions, research notes, directory layouts, or anything that
is reference material rather than instructions. Those go in `docs/`.
