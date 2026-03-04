#!/usr/bin/env bash
set -euo pipefail

# PostToolUse hook: runs clang-format, clang-tidy, cppcheck, and
# include-what-you-use after Edit/Write operations on C/C++ files.

FILE=$(jq -r '.tool_input.file_path // empty')

# Only run on C/C++ files
[[ -z "$FILE" ]] && exit 0
case "$FILE" in
    *.c|*.h|*.cc|*.cpp|*.cxx|*.hh|*.hpp|*.hxx) ;;
    *) exit 0 ;;
esac

# Skip if file was deleted
[[ ! -f "$FILE" ]] && exit 0

echo "--- clang-format ---"
STYLE_FLAG=()
DIR=$(dirname "$FILE")
while [[ "$DIR" != "/" ]]; do
    if [[ -f "$DIR/.clang-format" || -f "$DIR/_clang-format" ]]; then
        break
    fi
    DIR=$(dirname "$DIR")
done
if [[ "$DIR" == "/" ]]; then
    STYLE_FLAG=(--style=Google)
fi
clang-format --dry-run --Werror "${STYLE_FLAG[@]}" "$FILE" 2>&1 || true

echo "--- clang-tidy ---"
clang-tidy "$FILE" -- -Wall -Wextra 2>&1 || true

if command -v cppcheck &>/dev/null; then
    echo "--- cppcheck ---"
    cppcheck --enable=all --error-exitcode=0 --quiet "$FILE" 2>&1 || true
fi

if command -v include-what-you-use &>/dev/null; then
    echo "--- include-what-you-use ---"
    include-what-you-use "$FILE" -- -Wall 2>&1 || true
fi

exit 0
