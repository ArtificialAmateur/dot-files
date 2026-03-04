#!/usr/bin/env bash
set -euo pipefail

# PreCompact hook: outputs working state so context compaction
# preserves it. Stdout is injected into context before compaction.

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty' 2>/dev/null || true)
[[ -z "$CWD" ]] && CWD=$(pwd)
TRIGGER=$(echo "$INPUT" | jq -r '.trigger // "unknown"' 2>/dev/null || true)
CUSTOM=$(echo "$INPUT" | jq -r '.custom_instructions // empty' 2>/dev/null || true)

echo "=== CONTEXT PRESERVATION (pre-compact) ==="
echo "Working directory: $CWD"
echo "Trigger: $TRIGGER"
if [[ -n "$CUSTOM" ]]; then
    echo "Custom instructions: $CUSTOM"
fi

# User-maintained context file — write key decisions, current
# task, and anything that MUST survive compaction here.
for ctx in "$CWD/.claude/compact-context.md" \
           "$HOME/.claude/compact-context.md"; do
    if [[ -f "$ctx" ]]; then
        echo ""
        echo "--- Preserved context ---"
        cat "$ctx"
    fi
done

# Recently modified files (last 60 min)
echo ""
echo "--- Recently modified files (last 60 min) ---"
find "$CWD" -maxdepth 4 -type f \
    \( -name '*.md' -o -name '*.py' -o -name '*.c' -o -name '*.h' \) \
    -mmin -60 ! -path '*/.obsidian/*' 2>/dev/null \
    | head -20 || true

# Git working state if available
if git -C "$CWD" rev-parse --git-dir &>/dev/null 2>&1; then
    echo ""
    echo "--- Git working state ---"
    git -C "$CWD" status --short 2>/dev/null | head -20 || true
fi

echo "=== END CONTEXT PRESERVATION ==="
exit 0
