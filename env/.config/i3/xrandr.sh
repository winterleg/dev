#!/usr/bin/env bash

if xrandr | grep -q '^HDMI-0 connected'; then
    # External connected
    xrandr \
        --output DP-0 --off \
        --output DP-1 --off \
        --output DP-2 --off \
        --output DP-3 --off \
        --output DP-4 \
            --mode 2560x1600 \
            --rate 165 \
            --scale 0.6x0.6 \
            --pos -1600x0 \
        --output HDMI-0 \
            --primary \
            --mode 1920x1080 \
            --rate 119 \
            --pos 0x0
else
    # Laptop only
    xrandr \
        --output eDP-1 \
            --mode 2560x1600 \
            --rate 165 \
            --scale 0.6x0.6 \
            --pos 0x0
fi
