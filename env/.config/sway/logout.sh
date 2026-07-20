#!/usr/bin/env bash

options="Suspend & Lock
Suspend
Shutdown
Reboot"

selection=$(echo "$options" | rofi -i -show -dmenu)

cleanup() {
  if [[ "$XDG_SESSION_DESKTOP" == "hyprland" ]]; then
    pkill hyprsunset || true
  fi
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
elif [[ "$selection" == "Reboot" ]]; then
  systemctl reboot
fi
