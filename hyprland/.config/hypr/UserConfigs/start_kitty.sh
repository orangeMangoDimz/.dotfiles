#!/bin/bash
kitty &
sleep 2
ydotool key Super_L+Shift_L+2 && ydotool type tmux && ydotool key enter 
sleep 1
ydotool key ctrl+s && ydotool key ctrl+r
sleep 1
ydotool key ctrl+shift+t && ydotool key ctrl+shift+enter && ydotool key ctrl+shift+enter
sleep 1
ydotool key ctrl+shift+r 
sleep 2
ydotool key s 
ydotool key s 
ydotool key s 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key n 
ydotool key q
sleep 1
ydotool type "tty-clock" && ydotool key enter
ydotool key ctrl+shift+[ && ydotool type "cava" && ydotool key enter
ydotool key ctrl+shift+[ && ydotool type "spotify_player" && ydotool key enter
sleep 1
# ydotool key g+s && ydotool type "lofi song" && ydotool key enter
# sleep 1
# ydotool key tab && ydotool key enter
# sleep 1
