#!/bin/bash

ZOOM_STATE="$HOME/.cache/hypr_zoom_state"

if [ -f "$ZOOM_STATE" ]; then
    hyprctl keyword cursor:zoom_factor 1.000001
    rm "$ZOOM_STATE"
else
    hyprctl keyword cursor:zoom_factor 2.0
    touch "$ZOOM_STATE"
fi
