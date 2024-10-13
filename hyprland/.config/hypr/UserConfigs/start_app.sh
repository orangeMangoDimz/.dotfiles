#!/bin/bash

~/.config/hypr/UserConfigs/start_brave.sh
if [ $? -eq 0 ]; then
    echo "Brave started successfully. Running Kitty..."
    ~/.config/hypr/UserConfigs/start_kitty.sh

    if [ $? -eq 0 ]; then
        echo "Kitty started successfully. Running Discord..."
        ~/.config/hypr/UserConfigs/start_discord.sh

        if [ $? -eq 0 ]; then
            echo "All apps started successfully."
        else
            echo "Failed to start Discord."
        fi

    else
        echo "Failed to start Kitty. Discord will not be started."
    fi

else
    echo "Failed to start Brave. Kitty and Discord will not be started."
fi


# # BRAVE
# brave-browser &
# sleep 2
# ydotool key Super_L+Shift_L+1
#
# sleep 1
#
# # KITTY
# kitty &
# sleep 2
# ydotool type tmux && ydotool key enter && ydotool key ctrl+s && ydotool key ctrl+r 
#
# sleep 1
#
# # DISCORD
# flatpak run com.discordapp.Discord --ozone-platform=x11 --enable-features=WaylandWindowDecorations &
# sleep 2
# ydotool key Super_L+Shift_L+3
