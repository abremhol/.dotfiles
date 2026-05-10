#!/bin/bash
# Get the OpenWhispr window ID
WINDOW_ID=$(xdotool search --class "open-whispr" | head -1)

if [ -n "$WINDOW_ID" ]; then
    # Activate the window and send the hotkey
    xdotool windowactivate --sync "$WINDOW_ID"
    xdotool key --clearmodifiers Super+r
else
    echo "OpenWhispr window not found"
fi
