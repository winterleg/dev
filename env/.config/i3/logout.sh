#!/usr/bin/env bash

options="Lock
Suspend
Shutdown"

selection=$(echo "$options" | rofi -i -show -dmenu)

if [[ "$selection" == "Lock" ]]; then
  i3lock -c 191724
elif [[ "$selection" == "Suspend" ]]; then
  i3lock -c 191724 &
  systemctl suspend
elif [[ "$selection" == "Shutdown" ]]; then
  systemctl poweroff
fi
