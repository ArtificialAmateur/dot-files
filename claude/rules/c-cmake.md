---
globs: ["*.c", "*.h", "CMakeLists.txt", "*.cmake"]
---

## C / CMake Conventions

C code must be C-only (no C++). Android targets use aarch64.
Always verify target architecture before providing assembly,
intrinsics, or low-level code.

**Toolchain:**

| component | path |
|-----------|------|
| CMake build files | `~/Projects/graykey_applogic/build_tools/cmake/` |
| Clang 14.0.5 (ARM cross) | `~/Projects/graykey_applogic/build_tools/tools/extracted/clang-llvm-14.0.5-arm-linux-gnueabihf-linux-x86_64/` |
| Android NDK r21d | `~/Projects/graykey_applogic/build_tools/tools/extracted/android-ndk-r21d-linux-x86_64/` |

**Build system:** CMake 3.23+, Ninja only (no Make). Default
build type: Release.

**Android targets:** `arm` (ARMv7a) and `arm64` (AArch64), API
level 30. Default flags: `-Os -Wall -fvisibility=hidden -DNDEBUG`.
Shellcode targets add `-fno-stack-protector -fomit-frame-pointer
-fno-builtin -nostdlib`.

**Lint:** `-Wall -Werror` for production. Use `clang-tidy` when
available.

**Docs:** Doxygen `@brief`/`@param`/`@return` for all functions.
No file-level comments.

**Comments:** Brief, practical, explain "why" not "what". Use
`// NOTE:` for non-obvious constraints, `// TODO:` for known
limitations. Tone is direct and informal.

**Binary formats:** Double-check exact field offset and meaning
against the format specification before extracting values. Read
the actual header definition — do not assume field positions.
