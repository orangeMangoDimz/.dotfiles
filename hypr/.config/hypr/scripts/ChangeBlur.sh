#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images"

hyprctl keyword decoration:blur:enabled false
notify-send -e -u low -i "$notif/note.png" " Blur disabled"
