#!/bin/bash

# v0.55: misc:cursor_zoom_factor was renamed to cursor:zoom_factor
# Get current zoom factor
current_factor=$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2}')

# Toggle between 1.0 and 2.0
if (( $(echo "$current_factor == 1.0" | bc -l) )); then
    hyprctl keyword cursor:zoom_factor 2.0
    # notify-send "Cursor Zoom" "Enabled (2.0x)" -i mouse
else
    hyprctl keyword cursor:zoom_factor 1.0
    # notify-send "Cursor Zoom" "Disabled" -i mouse
fi
