#!/usr/bin/env bash

options="Lock & Suspend
Suspend
Shutdown"

selection=$(echo "$options" | rofi -i -show -dmenu)

if [[ "$selection" == "Lock & Suspend" ]]; then
  i3lock -c 191724
  systemctl suspend
elif [[ "$selection" == "Suspend" ]]; then
  systemctl suspend
elif [[ "$selection" == "Shutdown" ]]; then
  systemctl poweroff
fi
