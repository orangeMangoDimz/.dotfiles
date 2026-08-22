#!/bin/bash
echo "$(date) started" >> /tmp/screenshot-debug.log
wayfreeze --after-freeze-cmd "grimblast copy area" >> /tmp/screenshot-debug.log 2>&1
echo "$(date) done, exit: $?" >> /tmp/screenshot-debug.log
