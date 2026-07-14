#!/bin/sh

hyprlock &

sleep 3

swaymsg "output * dpms off"

swayidle -w \
  timeout 999999 'true' \
  resume 'swaymsg "output * dpms on"'

pkill swayidle
