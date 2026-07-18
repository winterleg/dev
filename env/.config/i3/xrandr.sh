#!/usr/bin/env bash

xrandr \
    --output DP-0 --off \
    --output DP-1 --off \
    --output DP-2 --off \
    --output DP-3 --off \
    --output DP-4 \
        --mode 2560x1600 \
        --rate 165 \
        --scale 0.5x0.5 \
        --pos -1280x0 \
    --output HDMI-0 \
        --primary \
        --mode 1920x1080 \
        --rate 119 \
        --pos 0x0
