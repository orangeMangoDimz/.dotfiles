#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

LOCK_DIR="$HOME/.config/hypr/wallpaper_effects"
LOCK_WALLPAPER="$LOCK_DIR/.wallpaper_current"
SOURCE_CACHE="$HOME/.cache/hypr-wallblur/sources"
HYPRLOCK_USER_BIN="$HOME/.local/bin/hyprlock"

prepare_lock_wallpaper() {
    local monitor source

    mkdir -p "$LOCK_DIR"
    monitor=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused == true) | .name' | head -n 1)

    # WallpaperBlur.sh keeps the unblurred source for each monitor here.
    if [ -n "$monitor" ] && [ -s "$SOURCE_CACHE/$monitor" ]; then
        source=$(head -n 1 "$SOURCE_CACHE/$monitor")
    fi

    # Fall back to the image currently displayed by swww.
    if [ ! -f "$source" ] && [ -n "$monitor" ]; then
        source=$(swww query --json 2>/dev/null | jq -r --arg monitor "$monitor" \
            '.[] | .[] | select(.name == $monitor) | .displaying.image // empty' | head -n 1)
    fi

    # Last fallback: the wallpaper selector's current image.
    if [ ! -f "$source" ] && [ -e "$HOME/.config/rofi/.current_wallpaper" ]; then
        source=$(readlink -f "$HOME/.config/rofi/.current_wallpaper")
    fi

    if [ -f "$source" ]; then
        ln -sfn -- "$source" "$LOCK_WALLPAPER"
    fi
}

prepare_lock_wallpaper

if [ "${1:-}" = "--prepare-only" ]; then
    exit 0
fi

# Hypridle uses this mode so the wallpaper is prepared for idle/suspend locks.
if [ "${1:-}" = "--direct" ]; then
    if [ -x "$HYPRLOCK_USER_BIN" ]; then
        exec "$HYPRLOCK_USER_BIN" -q
    fi

    exec hyprlock -q
fi

loginctl lock-session
