#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations

notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"


HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
		keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
	
	hyprctl keyword "windowrule opacity 1.0 override 1.0 override 1.0 override, match:class .*"
	hyprctl keyword "windowrule opaque on, match:class .*"
	hyprctl keyword "windowrule force_rgbx on, match:class .*"
	hyprctl keyword "windowrule no_blur on, match:class .*"
    swww kill 
    notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
    exit
else
	# Game Mode uses runtime-only keywords and rules. Reload the source config
	# first so animations, blur, rounding, and liquid-glass window properties
	# are restored and the temporary opaque/no_blur rules are discarded.
	hyprctl reload

	swww-daemon --format xrgb && swww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	${SCRIPTSDIR}/WallustSwww.sh
	sleep 0.5
	${SCRIPTSDIR}/Refresh.sh	 
    notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
    exit
fi
hyprctl reload
