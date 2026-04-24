#!/usr/bin/env bash

options="Suspend & Lock
Suspend
Shutdown"

selection=$(echo "$options" | rofi -i -show -dmenu)

cleanup() {
  pkill hyprsunset || true
}

if [[ "$selection" == "Suspend" ]]; then
  cleanup
  systemctl suspend
elif [[ "$selection" == "Suspend & Lock" ]]; then
  hyprlock &
  cleanup
  systemctl suspend
elif [[ "$selection" == "Shutdown" ]]; then
  systemctl poweroff
fi
