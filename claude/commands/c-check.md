# Check and Fix C Code

@description Run clang-format, clang-tidy, cppcheck, and include-what-you-use on C code, then fix all errors.
@arguments $PATH: Optional path to check (default: current directory)

Run the C quality toolchain on `$PATH` (or `.` if not provided),
then fix every error reported by the linter and static analyzers.

Execute every step below sequentially. Do not stop or ask for
confirmation between steps.

## 1. Format

First check if a `.clang-format` or `_clang-format` file exists in
or above `$PATH`. If one exists, run clang-format without a style
flag (it picks up the config automatically). If none exists, use
`--style=Google` as the default.

```
find $PATH -type f \( -name '*.c' -o -name '*.h' -o -name '*.cc' -o -name '*.cpp' -o -name '*.hpp' \) -exec clang-format -i --style=Google {} +
```

(Omit `--style=Google` if a `.clang-format` file was found.)

Accept all formatting changes silently.

## 2. Lint with clang-tidy

Run clang-tidy on all C/C++ source files. If a `compile_commands.json`
exists in or above `$PATH`, clang-tidy will use it automatically.
Otherwise pass basic flags:

```
find $PATH -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' \) -exec clang-tidy {} -- -Wall -Wextra \;
```

## 3. Static analysis with cppcheck

If `cppcheck` is available, run it:

```
cppcheck --enable=all --error-exitcode=0 --quiet $PATH
```

If cppcheck is not installed, skip this step silently.

## 4. Include analysis with include-what-you-use

If `include-what-you-use` is available, run it on all source files.
Use `iwyu-tool` if available (it handles `compile_commands.json`
automatically), otherwise run `include-what-you-use` directly:

```
iwyu-tool -p . $PATH
```

Or per-file fallback:

```
find $PATH -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' \) -exec include-what-you-use {} -- -Wall \;
```

If neither is installed, skip this step silently.

Review IWYU's output and apply its recommendations: remove unused
includes, add missing ones, and move includes to the correct
source/header file where appropriate. Use judgment — if IWYU
suggests removing a header that provides transitive dependencies
intentionally, keep it and note why.

## 5. Fix errors

For every error from steps 2, 3, and 4:

1. Read the file at the reported location
2. Understand the error in context
3. Fix the root cause — do not add NOLINT or suppression comments
   unless the diagnostic is a genuine false positive (explain why
   in an inline comment if suppressed)
4. After fixing, re-run the tool that reported the error to confirm
   it is resolved

Iterate until clang-tidy, cppcheck, and include-what-you-use
report zero errors.

## 6. Final verification

Run all tools one last time to confirm a clean state:

```
find $PATH -type f \( -name '*.c' -o -name '*.h' -o -name '*.cc' -o -name '*.cpp' -o -name '*.hpp' \) -exec clang-format --dry-run --Werror --style=Google {} +
find $PATH -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' \) -exec clang-tidy {} -- -Wall -Wextra \;
cppcheck --enable=all --error-exitcode=1 --quiet $PATH
iwyu-tool -p . $PATH
```

Report the final status. If all clean, say so. If any issues remain
that cannot be fixed without changing behavior, list them with
explanations.
