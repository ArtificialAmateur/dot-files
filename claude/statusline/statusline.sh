#!/usr/bin/env bash
set -euo pipefail

input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
cwd="${cwd/#$home/~}"

# Build context indicator — color shifts at 50% and 80% used
ctx_part=""
if [ -n "$used" ]; then
    used_int=${used%.*}
    if [ "$used_int" -ge 80 ]; then
        ctx_part=" \033[0;31m${used_int}%\033[0m"
    elif [ "$used_int" -ge 50 ]; then
        ctx_part=" \033[0;33m${used_int}%\033[0m"
    else
        ctx_part=" ${used_int}%"
    fi
fi

# Matches PS1: bold green user@host, plain colon, bold blue cwd
printf "\033[01;32m%s@%s\033[00m:\033[01;34m%s\033[00m" "$user" "$host" "$cwd"
[ -n "$model" ] && printf " \033[0;36m%s\033[0m" "$model"
[ -n "$ctx_part" ] && printf "%b" "$ctx_part"
printf "\n"
