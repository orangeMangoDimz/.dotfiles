#!/bin/bash
dir="/home/dimas/Pictures/Screenshots"
file="001_$(date "+%Y%m%d_%H%M%S").png"
mkdir -p "$dir"
echo "$(date) started" >> /tmp/screenshot-debug.log
wayfreeze --after-freeze-cmd "grimblast copysave area $dir/$file" >> /tmp/screenshot-debug.log 2>&1
echo "$(date) done, exit: $?" >> /tmp/screenshot-debug.log
