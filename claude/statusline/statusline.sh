#!/usr/bin/env bash
set -euo pipefail

input=$(cat)

# Single jq call to extract all fields
eval "$(echo "$input" | jq -r '
  @sh "MODEL_ID=\(.model.id // "")",
  @sh "MODEL=\(.model.display_name // "Claude")",
  @sh "CWD=\(.workspace.current_dir // .cwd // "")",
  @sh "PROJECT_DIR=\(.workspace.project_dir // "")",
  @sh "COST=\(.cost.total_cost_usd // 0)",
  @sh "DURATION_MS=\(.cost.total_duration_ms // 0)",
  @sh "API_MS=\(.cost.total_api_duration_ms // 0)",
  @sh "LINES_ADD=\(.cost.total_lines_added // 0)",
  @sh "LINES_DEL=\(.cost.total_lines_removed // 0)",
  @sh "TOTAL_IN=\(.context_window.total_input_tokens // 0)",
  @sh "TOTAL_OUT=\(.context_window.total_output_tokens // 0)",
  @sh "CTX_SIZE=\(.context_window.context_window_size // 200000)",
  @sh "USED_PCT=\(.context_window.used_percentage // 0)",
  @sh "CUR_IN=\(.context_window.current_usage.input_tokens // 0)",
  @sh "CUR_OUT=\(.context_window.current_usage.output_tokens // 0)",
  @sh "CUR_CACHE_W=\(.context_window.current_usage.cache_creation_input_tokens // 0)",
  @sh "CUR_CACHE_R=\(.context_window.current_usage.cache_read_input_tokens // 0)",
  @sh "VERSION=\(.version // "")",
  @sh "SESSION_ID=\(.session_id // "")",
  @sh "AGENT=\(.agent.name // "")",
  @sh "WORKTREE=\(.worktree.name // "")"
')"

# Colors
RST='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
RED='\033[31m'
GRN='\033[32m'
YLW='\033[33m'
BLU='\033[34m'
MAG='\033[35m'
CYN='\033[36m'
WHT='\033[37m'
BRED='\033[1;31m'
BGRN='\033[1;32m'
BYLW='\033[1;33m'
BCYN='\033[1;36m'
BWHT='\033[1;37m'
DGRY='\033[90m'

# Shorten home dir
cwd="${CWD/#$HOME/\~}"

# Detect model tier from model ID
tier=""
case "$MODEL_ID" in
  *max*|*200k*) tier="Max" ;;
esac

# Context bar (20 chars wide)
pct_int=${USED_PCT%.*}
pct_int=${pct_int:-0}
ctx_k=$((CTX_SIZE / 1000))
bar_w=20
filled=$((pct_int * bar_w / 100))
empty=$((bar_w - filled))

# Bar color shifts at thresholds
if ((pct_int >= 80)); then
  bar_color="$BRED"
elif ((pct_int >= 50)); then
  bar_color="$BYLW"
else
  bar_color="$BGRN"
fi

bar=""
((filled > 0)) && bar=$(printf "%${filled}s" | tr ' ' '#')
((empty > 0)) && bar="${bar}$(printf "%${empty}s" | tr ' ' '-')"

# Cost formatting
cost_fmt=$(printf '%.2f' "$COST")

# Duration formatting (wall clock)
dur_s=$((DURATION_MS / 1000))
dur_m=$((dur_s / 60))
dur_h=$((dur_m / 60))
dur_rm=$((dur_m % 60))
dur_rs=$((dur_s % 60))
if ((dur_h > 0)); then
  dur_str="${dur_h}h${dur_rm}m"
else
  dur_str="${dur_m}m${dur_rs}s"
fi

# API duration
api_s=$((API_MS / 1000))
api_m=$((api_s / 60))
api_rs=$((api_s % 60))
api_str="${api_m}m${api_rs}s"

# Token counts (k)
total_tok=$((TOTAL_IN + TOTAL_OUT))
total_tok_k=$(awk "BEGIN{printf \"%.0f\", $total_tok/1000}")
in_k=$(awk "BEGIN{printf \"%.0f\", $TOTAL_IN/1000}")
out_k=$(awk "BEGIN{printf \"%.0f\", $TOTAL_OUT/1000}")

# Burn rate ($/h) — only if we have duration
burn=""
if ((dur_s > 60)); then
  burn=$(awk "BEGIN{printf \"%.1f\", $COST / ($dur_s / 3600.0)}")
fi

# Git status (run in cwd)
git_info=""
if git -C "$CWD" rev-parse --git-dir &>/dev/null; then
  branch=$(git -C "$CWD" branch --show-current 2>/dev/null || echo "detached")
  git_info=" ${DIM}${branch}${RST}"
fi

# Build model label
model_label="${BCYN}${MODEL}"
[[ -n "$tier" ]] && model_label="${model_label}${DIM}·${tier}"
model_label="${model_label}${RST}"

# Line 1: Model · progress bar · context% · cost
line1="${model_label} "
line1+="${bar_color}${bar}${RST} "
line1+="${pct_int}%/${ctx_k}k"
line1+=" ${DGRY}|${RST} "
line1+="${BWHT}\$${cost_fmt}${RST}"

# Line 2: tokens · duration · burn rate · lines changed
line2="${DIM}D:${RST}${total_tok_k}k "
line2+="${DIM}i:${RST}${in_k}k${DIM}/${RST}o:${out_k}k"
line2+=" ${DGRY}|${RST} "
line2+="${dur_str}"
if [[ -n "$burn" ]]; then
  # Color burn rate
  burn_int=${burn%.*}
  if ((burn_int >= 15)); then
    line2+=" ${DGRY}|${RST} ${BRED}🔥 \$${burn}/h${RST}"
  elif ((burn_int >= 5)); then
    line2+=" ${DGRY}|${RST} ${YLW}🔥 \$${burn}/h${RST}"
  else
    line2+=" ${DGRY}|${RST} ${GRN}\$${burn}/h${RST}"
  fi
fi
line2+=" ${DGRY}|${RST} "
line2+="${BGRN}+${LINES_ADD}${RST}/${BRED}-${LINES_DEL}${RST}"
line2+=" ${DGRY}|${RST} "
line2+="${BLU}${cwd}${RST}"
[[ -n "$git_info" ]] && line2+="${git_info}"

# Agent/worktree indicator
extra=""
[[ -n "$AGENT" ]] && extra+=" ${MAG}⚙ ${AGENT}${RST}"
[[ -n "$WORKTREE" ]] && extra+=" ${CYN}⎇ ${WORKTREE}${RST}"

printf '%b\n' "$line1${extra}"
printf '%b\n' "$line2"
