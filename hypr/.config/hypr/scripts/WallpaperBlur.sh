#!/bin/bash
# Blur wallpaper on workspaces that have open windows

BLUR_STRENGTH="0x1"
CACHE_DIR="$HOME/.cache/swww"
BLUR_CACHE="$HOME/.cache/hypr-wallblur"
SOURCE_CACHE="$BLUR_CACHE/sources"
mkdir -p "$BLUR_CACHE" "$SOURCE_CACHE"

get_wallpaper() {
    local monitor="$1"
    local source_file="$SOURCE_CACHE/$monitor"
    local wallpaper

    if [ -s "$source_file" ]; then
        cat "$source_file"
        return
    fi

    wallpaper=$(grep -v 'Lanczos3' "$CACHE_DIR/$monitor" 2>/dev/null | head -n 1)
    if [ -z "$wallpaper" ]; then
        wallpaper=$(swww query --json 2>/dev/null | jq -r --arg monitor "$monitor" \
            '.[] | .[] | select(.name == $monitor) | .displaying.image // empty')
    fi

    [ -n "$wallpaper" ] && [ -f "$wallpaper" ] || return

    printf '%s\n' "$wallpaper" > "$source_file"
    printf '%s\n' "$wallpaper"
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
    hash=$(printf '%s\0%s' "$original" "$BLUR_STRENGTH" | md5sum | cut -d' ' -f1)
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

runtime_socket="${XDG_RUNTIME_DIR:+$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock}"
legacy_socket="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

if [ -n "$runtime_socket" ] && [ -S "$runtime_socket" ]; then
    event_socket="$runtime_socket"
else
    event_socket="$legacy_socket"
fi

listen_for_events() {
    if command -v nc >/dev/null 2>&1; then
        nc -U "$event_socket"
        return
    fi

    if command -v socat >/dev/null 2>&1; then
        socat -u "UNIX-CONNECT:$event_socket" -
        return
    fi

    printf '%s\n' "WallpaperBlur.sh: nc or socat is required for event updates." >&2
    return 1
}

listen_for_events | while IFS= read -r event; do
    case "$event" in
        openwindow*|closewindow*|workspace*|movewindow*)
            sleep 0.15
            update_wallpapers
            ;;
    esac
done
