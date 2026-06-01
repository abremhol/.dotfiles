#!/bin/bash
state_dir="/tmp/tmux-copilot-alerts-$(id -u)"
mkdir -p "$state_dir"

for session in $(tmux list-sessions -F '#S'); do
  flags=$(tmux list-windows -t "$session" -F '#{window_flags}')
  if echo "$flags" | grep -q '!'; then
    touch "$state_dir/$session"
  fi
done

current_session=$(tmux display-message -p '#S' 2>/dev/null)
alerts=""
for flag in "$state_dir"/*; do
  [[ -f "$flag" ]] || continue
  session_name=$(basename "$flag")
  [[ "$session_name" == "$current_session" ]] && { rm -f "$flag"; continue; }
  alerts+=" 🔔 ${session_name}"
done

tmux set -g @copilot_alerts "$alerts"
