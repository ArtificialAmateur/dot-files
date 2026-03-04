#!/bin/bash
set -euo pipefail
# Strip ANSI escape sequences and OSC shell integration markers
sed -e $'s/\x1b\\[[0-9;]*[mKHJ]//g' \
    -e $'s/\x1b\\][^\x07]*\x07//g' \
    -e $'s/\x1b\\][^\x1b]*\x1b\\\\//g' \
    -e $'s/\x1b\\[\\?[0-9;]*[hl]//g' |
  less -R +G
