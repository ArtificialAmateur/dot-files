# {{PROJECT_NAME}}

## Installation

### MCP Server

```bash
claude mcp add-json -s user {{PROJECT_NAME}} \
  '{"command":"uv","args":["run","--directory","{{PROJECT_PATH}}","python","-m","mcp_server"],"env":{"PYTHONPATH":"{{PROJECT_PATH}}","UV_INDEX_URL":"https://pypi.org/simple"}}'
```

### Subagent

```bash
ln -sf {{PROJECT_PATH}}/agents/{{AGENT_NAME}}.md ~/.claude/agents/{{AGENT_NAME}}.md
```

## Workflow Defaults

- **Stage implementation:** Run all tasks to completion without
  pausing for feedback between batches.
- **Branch completion:** Merge to main locally, verify tests, delete
  the branch. Don't ask which option.

## Git Commits

- Never include `Co-Authored-By` trailers
- Use local git config for author identity
- Imperative mood, lowercase, short subject line
- One logical change per commit

## Progress Tracking

`PROGRESS.md` records current project state. Keep compact:

- One row per completed stage in the summary table
- Current state sections updated in place (not appended)
- No per-stage snapshots — that detail lives in git history

## Stage Planning

Use `/stage-plan`. Produces two documents in `docs/plans/`:

- **Design doc** (`*-stageN-design.md`): interfaces, data flow,
  decisions. No implementation code.
- **Implementation plan** (`*-stageN-plan.md`): TDD tasks with
  copy-paste-ready code blocks.

## Context Management

Plan files are large (40-90KB). Minimize context usage:

1. **Start with `PROGRESS.md`** — always first, has full state
2. **Active stage plan by task offset** — never load wholesale
3. **Design doc only if task needs architectural context**
4. **`STAGES.md` only when planning a new stage**
5. **Master design doc by line offset** for interface lookups only

**Never load wholesale:** master design doc, completed stage plans.
Their useful content is in `PROGRESS.md` and the codebase.

## Test & Lint

```bash
uv run pytest tests/ -q
uv run ruff check .
```

## Do NOT

- Add RAG/vector DB without evidence >10% of queries need semantic
  search
- Switch to TypeScript/Node.js
- Commit `data/*.db`, `.venv/`, or generated files
