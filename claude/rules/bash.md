---
globs: ["*.sh", "*.bash"]
---

## Bash Conventions

All scripts must start with `set -euo pipefail`.
Lint: `shellcheck script.sh && shfmt -d script.sh`
