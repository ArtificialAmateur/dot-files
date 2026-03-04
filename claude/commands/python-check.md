# Lint and Fix Python Project

@description Run ruff format, ruff check, and ty check on the Python project, then fix all errors.
@arguments $PATH: Optional path to check (default: current directory)

Run the Python quality toolchain on `$PATH` (or `.` if not provided),
then fix every error reported by the linter and type checker.

Execute every step below sequentially. Do not stop or ask for
confirmation between steps.

IMPORTANT — tool resolution: Before running any commands, check
whether `ruff` and `ty` are available directly:

```
which ruff && ruff --version; which ty && ty --version
```

If both are installed, use them directly (e.g. `ruff format $PATH`).
If either is missing, use `uvx` with sandbox workarounds — prefix
every `uvx` command with:

```
UV_CACHE_DIR=/tmp/claude/uv-cache UV_TOOL_DIR=/tmp/claude/uv-tools UV_TOOL_BIN_DIR=/tmp/claude/uv-bin UV_INDEX_URL=https://pypi.org/simple/ UV_CONFIG_FILE=/dev/null
```

All command blocks below use the direct binary form. Add the `uvx`
prefix only if the binary is not found.

## 1. Format

Run ruff format on the target path:

```
ruff format $PATH
```

This is non-negotiable — accept all formatting changes silently.

## 2. Lint

Run ruff check on the target path:

```
ruff check $PATH
```

If there are auto-fixable violations, run:

```
ruff check --fix $PATH
```

Then re-run `ruff check $PATH` to see what remains.

## 3. Type check

Run ty check on the target path:

```
ty check $PATH
```

## 4. Fix errors

For every remaining error from steps 2 and 3:

1. Read the file at the reported location
2. Understand the error in context
3. Fix the root cause — do not add `type: ignore`, `noqa`, or
   other suppression comments unless the diagnostic is a genuine
   false positive (explain why in an inline comment if suppressed)
4. After fixing, re-run the tool that reported the error to confirm
   it is resolved

Iterate until both ruff check and ty check report zero errors.

## 5. Final verification

Run all three tools one last time to confirm a clean state:

```
ruff format --check $PATH
ruff check $PATH
ty check $PATH
```

Report the final status. If all clean, say so. If any issues remain
that cannot be fixed without changing behavior, list them with
explanations.
