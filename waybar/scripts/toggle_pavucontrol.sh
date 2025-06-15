#!/bin/bash

if pgrep -x "pavucontrol" > /dev/null; then
    pkill -x pavucontrol
else
    pavucontrol &

    sleep 0.3

    wid=$(hyprctl clients | grep -B1 'class: pavucontrol' | grep 'Window ID' | awk '{print $3}')

    hyprctl dispatch movewindowpixel exact $wid $(($(hyprctl monitors -j | jq -r '.[0].width') - 620)) 32
fi
