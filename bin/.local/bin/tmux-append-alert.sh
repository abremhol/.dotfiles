#!/bin/bash
current=$(tmux show-option -gv status-right)
if [[ "$current" != *"copilot_alerts"* ]]; then
  tmux set -g status-right "${current}#[fg=yellow,bg=red,bold]#{E:@copilot_alerts}"
fi
tmux set -g @copilot_alerts ""
tmux set-hook -g alert-bell 'run-shell "~/.local/bin/tmux-bell-fired.sh"'
tmux set-hook -g client-session-changed 'run-shell "~/.local/bin/tmux-bell-clear.sh"'
