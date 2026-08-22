#!/usr/bin/env bash
# Power Profile OSD — notify on platform_profile change (Lenovo Fn+Q)
# sysfs has no inotify, so poll the file and fire a swaync OSD on change.

PROFILE_FILE="/sys/firmware/acpi/platform_profile"
POLL_INTERVAL=1
SYNC_TAG="powerprofile"   # swaync synchronous hint => replaces in place (OSD-style)

[ -r "$PROFILE_FILE" ] || exit 0

label_for() {
  case "$1" in
    performance) echo "Performance" ;;
    balanced)    echo "Balanced" ;;
    low-power)   echo "Quiet (low-power)" ;;
    *)           echo "$1" ;;
  esac
}

icon_for() {
  case "$1" in
    performance) echo "power-profile-performance-symbolic" ;;
    balanced)    echo "power-profile-balanced-symbolic" ;;
    low-power)   echo "power-profile-power-saver-symbolic" ;;
    *)           echo "preferences-system-power" ;;
  esac
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apply_quiet_max_epp() {
  [ "$1" = "balanced" ] || return 0
  sudo -n "$SCRIPT_DIR/SetEPP.sh" 2>/dev/null || true
}

prev="$(cat "$PROFILE_FILE")"
apply_quiet_max_epp "$prev"
while :; do
  cur="$(cat "$PROFILE_FILE")"
  if [ "$cur" != "$prev" ]; then
    apply_quiet_max_epp "$cur"
    notify-send \
      -a "Power Profile" \
      -i "$(icon_for "$cur")" \
      -t 1800 \
      -u low \
      -h "string:x-canonical-private-synchronous:$SYNC_TAG" \
      "$(label_for "$cur") Mode"
    prev="$cur"
  fi
  sleep "$POLL_INTERVAL"
done
