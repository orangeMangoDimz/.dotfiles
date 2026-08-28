#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Not my own work. This was added through Github PR. Credit to original author

#----- Optimized bars animation without much CPU usage increase --------
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create dictionary to replace char with bar
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create cava config
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
# Older systems show significant CPU use with default framerate
# Setting maximum framerate to 30  
# You can increase the value if you wish
framerate = 30
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

is_music_playing() {
    playerctl status 2>/dev/null | grep -qx 'Playing'
}

is_music_playing || exit 1

# Kill cava if it's already running
pkill -f "cava -p $config_file" 2>/dev/null || true

cleanup() {
    if [[ -n "$cava_pipeline_pid" ]]; then
        kill "$cava_pipeline_pid" 2>/dev/null || true
    fi
    pkill -f "cava -p $config_file" 2>/dev/null || true
}
trap cleanup EXIT

# Read stdout from cava and perform substitution in a single sed command
cava -p "$config_file" | sed -u "$dict" &
cava_pipeline_pid=$!

while is_music_playing; do
    sleep 1
done

exit 1
