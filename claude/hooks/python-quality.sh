#!/usr/bin/env bash
set -euo pipefail

# PostToolUse hook: runs ruff format, ruff check, and ty check
# after Edit/Write operations on Python files.
#
# Uses direct binaries when available (faster, no network needed).
# Falls back to uvx with sandbox workarounds if not installed.

FILE=$(jq -r '.tool_input.file_path // empty')

# Only run on Python files
[[ -z "$FILE" || "$FILE" != *.py ]] && exit 0

# Skip if file was deleted
[[ ! -f "$FILE" ]] && exit 0

# Prefer direct binary; fall back to uvx with sandbox-safe config.
run_tool() {
    if command -v "$1" &>/dev/null; then
        "$@"
    else
        UV_CACHE_DIR=/tmp/claude/uv-cache \
        UV_TOOL_DIR=/tmp/claude/uv-tools \
        UV_TOOL_BIN_DIR=/tmp/claude/uv-bin \
        UV_INDEX_URL=https://pypi.org/simple/ \
        UV_CONFIG_FILE=/dev/null \
        uvx "$@"
    fi
}

echo "--- ruff format ---"
run_tool ruff format "$FILE" 2>&1 || true

echo "--- ruff check ---"
run_tool ruff check "$FILE" 2>&1 || true

echo "--- ty check ---"
run_tool ty check "$FILE" 2>&1 || true

exit 0
