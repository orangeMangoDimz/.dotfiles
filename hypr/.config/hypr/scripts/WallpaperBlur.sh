#!/bin/bash
# Blur wallpaper on workspaces that have open windows

BLUR_STRENGTH="0x35"
CACHE_DIR="$HOME/.cache/swww"
BLUR_CACHE="$HOME/.cache/hypr-wallblur"
mkdir -p "$BLUR_CACHE"

get_wallpaper() {
    local monitor="$1"
    grep -v 'Lanczos3' "$CACHE_DIR/$monitor" 2>/dev/null | head -n 1
}

has_windows_on_workspace() {
    local workspace_id="$1"
    local count
    count=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $workspace_id and .mapped == true)] | length")
    [ "$count" -gt 0 ]
}

get_blurred() {
    local original="$1"
    local hash
    hash=$(echo "$original" | md5sum | cut -d' ' -f1)
    local ext="${original##*.}"
    local blurred="$BLUR_CACHE/${hash}.${ext}"
    if [ ! -f "$blurred" ]; then
        convert "$original" -blur "$BLUR_STRENGTH" "$blurred"
    fi
    echo "$blurred"
}

update_wallpapers() {
    while IFS= read -r monitor_json; do
        local monitor workspace_id original
        monitor=$(echo "$monitor_json" | jq -r '.name')
        workspace_id=$(echo "$monitor_json" | jq -r '.activeWorkspace.id')
        original=$(get_wallpaper "$monitor")

        [ -z "$original" ] || [ ! -f "$original" ] && continue

        if has_windows_on_workspace "$workspace_id"; then
            local blurred
            blurred=$(get_blurred "$original")
            swww img "$blurred" --outputs "$monitor" --transition-type fade --transition-duration 0.3 2>/dev/null
        else
            swww img "$original" --outputs "$monitor" --transition-type fade --transition-duration 0.3 2>/dev/null
        fi
    done < <(hyprctl monitors -j | jq -c '.[]')
}

update_wallpapers

nc -U "/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while IFS= read -r event; do
    case "$event" in
        openwindow*|closewindow*|workspace*|movewindow*|focusedmon*)
            sleep 0.15
            update_wallpapers
            ;;
    esac
done
