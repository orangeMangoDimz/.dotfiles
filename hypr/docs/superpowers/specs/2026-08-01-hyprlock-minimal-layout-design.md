# Minimal Hyprlock Layout Design

## Goal

Make every lock-screen entry point show only the current wallpaper, a time
clock, and the password field.

## Current state

`configs/Keybinds.conf` maps `CTRL ALT L` to `scripts/LockScreen.sh`. The same
script is used by Hypridle for automatic and suspend-related locks, so one
shared Hyprlock layout controls all of those paths. There are separate
layouts for standard and 2K monitor resolutions.

Both layouts currently include the wallpaper, date, time, username, password
field, uptime, and weather.

## Design

Update both `hyprlock.conf` and `hyprlock-2k.conf` in place:

- Keep the existing `background` block and current-wallpaper path.
- Keep the hour, minute, and seconds labels as the clock.
- Keep the `input-field` password prompt and its current styling.
- Remove the date, username, uptime, and weather label blocks.
- Leave the keybind and `LockScreen.sh` unchanged so manual, idle, and suspend
  locks all use the same simplified layout.

No new dependencies, scripts, or runtime branching are needed.

## Alternatives considered

1. Edit both existing layouts in place: recommended because it is the smallest
   change and keeps standard/2K styling intact.
2. Add a separate minimal Hyprlock config and select it from `LockScreen.sh`:
   preserves the old layout but adds another config to maintain.
3. Add a shortcut-only layout: would leave automatic locks inconsistent with
   the requested lock-screen appearance.

## Validation

- Confirm both edited configs retain exactly the background, clock labels, and
  password input blocks.
- Search the active configs for unwanted date, username, uptime, and weather
  widgets.
- Check the diff to ensure the keybind and lock script were not changed.
- Run Hyprlock's available config validation or launch check if supported by
  the installed version.
