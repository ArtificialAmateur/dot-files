#!/bin/bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
PREFER=""

usage() {
  cat <<'EOF'
Usage: ./sync.sh [--prefer=host|repo]

Sync dotfiles between this repo and the host system.
Each mapping is detected and handled:
  - Already symlinked: skip
  - Only in repo: symlink to host
  - Only on host: import to repo, then symlink
  - Both exist (conflict): compare and prompt (or use --prefer)
EOF
  exit 1
}

safe_remove() {
  if command -v trash >/dev/null 2>&1; then
    trash "$1"
  else
    local bak
    bak="${1}.bak.$(date +%s)"
    mv "$1" "$bak"
    echo "  (backed up to $bak)"
  fi
}

for arg in "$@"; do
  case "$arg" in
  --prefer=host) PREFER="host" ;;
  --prefer=repo) PREFER="repo" ;;
  -h | --help) usage ;;
  *)
    echo "unknown option: $arg" >&2
    usage
    ;;
  esac
done

# sync_entry <repo_rel> <host_path> [rsync_excludes...]
sync_entry() {
  local repo_rel="$1" host="$2"
  shift 2
  local excludes=("$@")
  local repo="$REPO/$repo_rel"

  local repo_exists=0 host_exists=0 is_linked=0
  [[ -e "$repo" || -L "$repo" ]] && repo_exists=1
  [[ -e "$host" || -L "$host" ]] && host_exists=1

  if [[ "$host_exists" -eq 1 && -L "$host" ]]; then
    local target
    target="$(readlink -f "$host")"
    [[ "$target" == "$(readlink -f "$repo")" ]] && is_linked=1
  fi

  # Already linked
  if [[ "$is_linked" -eq 1 ]]; then
    echo "  ok: $host (linked)"
    return
  fi

  # Both exist, not linked — conflict
  if [[ "$repo_exists" -eq 1 && "$host_exists" -eq 1 ]]; then
    resolve_conflict "$repo" "$host" "${excludes[@]+"${excludes[@]}"}"
    return
  fi

  # Only repo exists — symlink to host
  if [[ "$repo_exists" -eq 1 && "$host_exists" -eq 0 ]]; then
    mkdir -p "$(dirname "$host")"
    ln -s "$repo" "$host"
    echo " link: $host -> $repo"
    return
  fi

  # Only host exists — import to repo, then symlink
  if [[ "$repo_exists" -eq 0 && "$host_exists" -eq 1 ]]; then
    import_to_repo "$repo" "$host" "${excludes[@]+"${excludes[@]}"}"
    return
  fi

  # Neither exists
  echo " skip: $repo_rel (nothing to sync)"
}

import_to_repo() {
  local repo="$1" host="$2"
  shift 2

  if [[ -d "$host" ]]; then
    mkdir -p "$repo"
    rsync -a --delete "$@" "$host/" "$repo/"
  else
    mkdir -p "$(dirname "$repo")"
    cp -a "$host" "$repo"
  fi
  safe_remove "$host"
  ln -s "$repo" "$host"
  echo "  imp: $host -> $repo"
}

resolve_conflict() {
  local repo="$1" host="$2"
  shift 2

  # Check if contents are identical
  local identical=0
  if [[ -d "$repo" && -d "$host" ]]; then
    diff -rq "$repo" "$host" >/dev/null 2>&1 && identical=1
  elif [[ -f "$repo" && -f "$host" ]]; then
    diff -q "$repo" "$host" >/dev/null 2>&1 && identical=1
  fi

  if [[ "$identical" -eq 1 ]]; then
    safe_remove "$host"
    ln -s "$repo" "$host"
    echo "  ok: $host (identical, linked)"
    return
  fi

  # Contents differ
  case "$PREFER" in
  host)
    prefer_host "$repo" "$host" "$@"
    ;;
  repo)
    prefer_repo "$repo" "$host"
    ;;
  *)
    prompt_conflict "$repo" "$host" "$@"
    ;;
  esac
}

prefer_host() {
  local repo="$1" host="$2"
  shift 2

  if [[ -d "$host" ]]; then
    rsync -a --delete "$@" "$host/" "$repo/"
  else
    cp -a "$host" "$repo"
  fi
  safe_remove "$host"
  ln -s "$repo" "$host"
  echo " host: $host -> $repo"
}

prefer_repo() {
  local repo="$1" host="$2"

  local backup
  backup="${host}.bak.$(date +%s)"
  mv "$host" "$backup"
  ln -s "$repo" "$host"
  echo " repo: $host (backup: $backup)"
}

prompt_conflict() {
  local repo="$1" host="$2"
  shift 2

  echo ""
  echo "CONFLICT: $host"
  if [[ -d "$repo" ]]; then
    diff -rq "$repo" "$host" || true
  else
    diff --color=auto "$repo" "$host" || true
  fi
  echo ""

  while true; do
    printf "  [h]ost / [r]epo / [s]kip? "
    read -r choice
    case "$choice" in
    h)
      prefer_host "$repo" "$host" "$@"
      return
      ;;
    r)
      prefer_repo "$repo" "$host"
      return
      ;;
    s)
      echo " skip: $host (conflict unresolved)"
      return
      ;;
    *) echo "  invalid choice" ;;
    esac
  done
}

sync_all() {
  echo "==> git"
  sync_entry "git/gitconfig" "$HOME/.gitconfig"
  sync_entry "git/ignore" "$HOME/.config/git/ignore"

  echo "==> zsh"
  sync_entry "zsh" "$HOME/.zsh" \
    --exclude='.git' --exclude='*.bak' --exclude='zhistory'

  echo "==> tmux"
  sync_entry "tmux/tmux.conf" "$HOME/.tmux.conf"

  echo "==> config"
  sync_entry "config/ranger" "$HOME/.config/ranger"
  sync_entry "config/kitty" "$HOME/.config/kitty"
  sync_entry "config/nvim" "$HOME/.config/nvim" \
    --exclude='.git'
  sync_entry "config/ghostty" "$HOME/.config/ghostty"
  sync_entry "config/binwalk" "$HOME/.config/binwalk"
  sync_entry "config/uv" "$HOME/.config/uv"
  sync_entry "config/VSCodium/User/settings.json" \
    "$HOME/.config/VSCodium/User/settings.json"
  sync_entry "config/Code/User/settings.json" \
    "$HOME/.config/Code/User/settings.json"
  sync_entry "config/compton.conf" "$HOME/.config/compton.conf"
  sync_entry "config/starship.toml" "$HOME/.config/starship.toml"
  sync_entry "config/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

  echo "==> local/share"
  sync_entry "local/share/fonts" "$HOME/.local/share/fonts"
  sync_entry "local/share/icons" "$HOME/.local/share/icons"

  echo "==> ssh"
  sync_entry "ssh/config" "$HOME/.ssh/config"

  echo "==> ghidra_scripts"
  sync_entry "ghidra_scripts" "$HOME/ghidra_scripts"

  echo "==> claude"
  local claude_paths=(
    .gitignore CLAUDE.md settings.json agents commands docs
    hooks rules scripts skills statusline templates
  )
  for path in "${claude_paths[@]}"; do
    sync_entry "claude/$path" "$HOME/.claude/$path" \
      --exclude='.git'
  done
}

sync_all

echo "==> zshrc"
ln -sf ~/.zsh/zshrc ~/.zshrc

echo "==> submodules"
git -C "$REPO" submodule update --init --recursive

# Bidirectional sync for claude code marketplaces and plugins.
# Desired state lives in claude/plugins.conf; host state in ~/.claude/plugins/.

sync_claude_marketplaces() {
  local tmp="$1" conf="$2"

  while IFS= read -r repo; do
    echo "  add: marketplace $repo"
    claude plugin marketplace add "$repo" || true
  done < <(comm -23 "$tmp/want_mkts" "$tmp/have_mkts")

  while IFS= read -r repo; do
    case "$PREFER" in
    host)
      echo "  imp: marketplace $repo"
      echo "marketplace $repo" >>"$conf"
      ;;
    repo) echo " skip: marketplace $repo (host-only)" ;;
    *)
      echo ""
      echo "  HOST-ONLY marketplace: $repo"
      while true; do
        printf "    [a]dd to conf / [s]kip? "
        read -r choice
        case "$choice" in
        a)
          echo "marketplace $repo" >>"$conf" && echo "  added"
          break
          ;;
        s)
          echo "  skipped"
          break
          ;;
        *) echo "  invalid" ;;
        esac
      done
      ;;
    esac
  done < <(comm -13 "$tmp/want_mkts" "$tmp/have_mkts")

  claude plugin marketplace update 2>/dev/null || true
}

sync_claude_installs() {
  local tmp="$1" conf="$2"

  while IFS= read -r plugin; do
    echo "  install: $plugin"
    claude plugin install "$plugin" || true
  done < <(comm -23 "$tmp/want_all" "$tmp/have_all")

  while IFS= read -r plugin; do
    local prefix="plugin"
    grep -qx "$plugin" "$tmp/have_off" 2>/dev/null && prefix="!plugin"
    case "$PREFER" in
    host)
      echo "  imp: $plugin"
      echo "$prefix $plugin" >>"$conf"
      ;;
    repo) echo " skip: $plugin (host-only)" ;;
    *)
      echo ""
      echo "  HOST-ONLY plugin: $plugin (${prefix#!})"
      while true; do
        printf "    [a]dd to conf / [s]kip? "
        read -r choice
        case "$choice" in
        a)
          echo "$prefix $plugin" >>"$conf" && echo "  added"
          break
          ;;
        s)
          echo "  skipped"
          break
          ;;
        *) echo "  invalid" ;;
        esac
      done
      ;;
    esac
  done < <(comm -13 "$tmp/want_all" "$tmp/have_all")
}

sync_claude_states() {
  local tmp="$1" conf="$2"

  while IFS= read -r plugin; do
    local want="enabled" have="enabled"
    grep -qx "$plugin" "$tmp/want_off" 2>/dev/null && want="disabled"
    grep -qx "$plugin" "$tmp/have_off" 2>/dev/null && have="disabled"

    if [[ "$want" == "$have" ]]; then
      echo "  ok: $plugin ($want)"
      continue
    fi

    case "$PREFER" in
    host)
      if [[ "$have" == "disabled" ]]; then
        sed -i "s/^plugin $plugin$/!plugin $plugin/" "$conf"
      else
        sed -i "s/^!plugin $plugin$/plugin $plugin/" "$conf"
      fi
      echo " host: $plugin ($have)"
      ;;
    repo)
      if [[ "$want" == "disabled" ]]; then
        claude plugin disable "$plugin" 2>/dev/null || true
      else
        claude plugin enable "$plugin" 2>/dev/null || true
      fi
      echo " repo: $plugin ($want)"
      ;;
    *)
      echo ""
      echo "  STATE: $plugin (conf=$want host=$have)"
      while true; do
        printf "    [h]ost / [r]epo / [s]kip? "
        read -r choice
        case "$choice" in
        h)
          if [[ "$have" == "disabled" ]]; then
            sed -i "s/^plugin $plugin$/!plugin $plugin/" "$conf"
          else
            sed -i "s/^!plugin $plugin$/plugin $plugin/" "$conf"
          fi
          echo " host: $plugin ($have)" && break
          ;;
        r)
          if [[ "$want" == "disabled" ]]; then
            claude plugin disable "$plugin" 2>/dev/null || true
          else
            claude plugin enable "$plugin" 2>/dev/null || true
          fi
          echo " repo: $plugin ($want)" && break
          ;;
        s) echo "  skipped" && break ;;
        *) echo "  invalid" ;;
        esac
      done
      ;;
    esac
  done < <(comm -12 "$tmp/want_all" "$tmp/have_all")
}

sync_claude_plugins() {
  command -v claude >/dev/null 2>&1 || return 0
  echo "==> claude plugins"

  local conf="$REPO/claude/plugins.conf"
  if [[ ! -f "$conf" ]]; then
    echo "  skip: plugins.conf not found"
    return
  fi

  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN

  local mkts_json="$HOME/.claude/plugins/known_marketplaces.json"
  local inst_json="$HOME/.claude/plugins/installed_plugins.json"
  local settings="$HOME/.claude/settings.json"

  # Parse desired state from conf
  { grep '^marketplace ' "$conf" || true; } | awk '{print $2}' | sort >"$tmp/want_mkts"
  { grep '^plugin ' "$conf" || true; } | awk '{print $2}' | sort >"$tmp/want_on"
  { grep '^!plugin ' "$conf" || true; } | awk '{print $2}' | sort >"$tmp/want_off"
  sort -u "$tmp/want_on" "$tmp/want_off" >"$tmp/want_all"

  # Parse host state
  if [[ -f "$mkts_json" ]]; then
    python3 -c "
import json
for v in json.load(open('$mkts_json')).values():
    print(v['source']['repo'])" 2>/dev/null
  fi | sort >"$tmp/have_mkts"

  if [[ -f "$inst_json" ]]; then
    python3 -c "
import json
for k in json.load(open('$inst_json')).get('plugins', {}):
    print(k)" 2>/dev/null
  fi | sort >"$tmp/have_all"

  if [[ -f "$settings" ]]; then
    python3 -c "
import json
d = json.load(open('$settings')).get('enabledPlugins', {})
for k, v in d.items():
    if not v: print(k)" 2>/dev/null
  fi | sort >"$tmp/have_off"

  sync_claude_marketplaces "$tmp" "$conf"
  sync_claude_installs "$tmp" "$conf"
  sync_claude_states "$tmp" "$conf"
}

sync_claude_plugins

echo "done"
