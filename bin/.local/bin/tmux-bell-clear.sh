#!/bin/bash
state_dir="/tmp/tmux-copilot-alerts-$(id -u)"
current_session=$(tmux display-message -p '#S' 2>/dev/null)

rm -f "$state_dir/$current_session" 2>/dev/null

alerts=""
for flag in "$state_dir"/*; do
  [[ -f "$flag" ]] || continue
  session_name=$(basename "$flag")
  alerts+=" 🔔 ${session_name}"
done

tmux set -g @copilot_alerts "$alerts"
