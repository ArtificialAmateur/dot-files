# {{PROJECT_NAME}}

## What This Does

{{ONE_LINE_DESCRIPTION}}

## Development

```bash
uv sync
uv run pytest tests/ -q
uv run ruff check .
```

## Git Commits

- Never include `Co-Authored-By` trailers
- Imperative mood, lowercase, short subject line
- One logical change per commit

## Architecture

{{BRIEF_DESCRIPTION — 3-5 lines max. Move detailed design to
docs/ if it grows beyond a paragraph.}}

## Do NOT

- {{PROJECT_SPECIFIC_CONSTRAINT}}
- Commit `.venv/`, `*.db`, or `.env` files
