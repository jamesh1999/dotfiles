#!/usr/bin/env bash

# If tmux isn't running at all, just start zsh normally
if ! command -v tmux >/dev/null || ! pgrep tmux >/dev/null; then
  exec zsh
fi

MAIN_INFO_FILE="${XDG_RUNTIME_DIR:-/tmp}/vscode-tmux/$(basename "$PWD").context"
VS_SESSION="vscode-$(basename "$PWD")"

# Only create/link once per session
if ! tmux has-session -t "$VS_SESSION" 2>/dev/null; then
  tmux new-session -d -s "$VS_SESSION" -c "$PWD"

  if [[ -f "$MAIN_INFO_FILE" ]]; then
    IFS=: read -r MAIN_SESSION MAIN_WINDOW < "$MAIN_INFO_FILE"
    echo "Linking ${VSCODE_TMUX_SESSION}:${VSCODE_TMUX_WINDOW} → ${VS_SESSION}:1" >&2
    if tmux has-session -t "$MAIN_SESSION" 2>/dev/null; then
      tmux link-window -s "${MAIN_SESSION}:${MAIN_WINDOW}" -t "${VS_SESSION}:1" -k
    fi
  fi
fi

# Clean up tmux session when this shell exits
cleanup() {
  local clients
  clients=$(tmux list-clients -t "$VS_SESSION" 2>/dev/null | wc -l)
  if [[ "$clients" -le 1 ]]; then
    tmux kill-session -t "$VS_SESSION" 2>/dev/null
  fi
}
trap cleanup EXIT

# Attach to that session
tmux attach -t "$VS_SESSION"
