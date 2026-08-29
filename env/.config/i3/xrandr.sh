#!/usr/bin/env bash

if xrandr | grep -q '^HDMI-1-0 connected'; then
    # External connected
	xrandr \
	    --output eDP-1 \
	        --mode 2560x1600 \
	        --rate 165 \
	        --scale 0.6x0.6 \
	        --pos -1536x0 \
	    --output HDMI-1-0 \
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
