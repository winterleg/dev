#!/usr/bin/env bash

FORCE_DISABLE_LAPTOP=false
FORCE_DISABLE_MONITOR=false

LAPTOP_CONFIG="laptopv3"
MONITOR_CONFIG="monitorv3"

LAPTOPNAME="eDP-1"
MONITORNAME="HDMI-A-1"

has_monitor() {
  hyprctl monitors -j >/dev/null 2>&1 &&
    hyprctl monitors -j | jq -e --arg name "$1" \
      '.[] | select(.name == $name)' >/dev/null
}

LAPTOP=$(has_monitor "$LAPTOPNAME" && echo true || echo false)
MONITOR=$(has_monitor "$MONITORNAME" && echo true || echo false)

$FORCE_DISABLE_LAPTOP && LAPTOP=false
$FORCE_DISABLE_MONITOR && MONITOR=false

echo -e "gotten:"
echo -e "\tCOMPOSITOR: $COMPOSITOR"
echo -e "\tLAPTOP: $LAPTOP ($LAPTOPNAME)"
echo -e "\tMONITOR: $MONITOR ($MONITORNAME)"

laptop() {
  waybar \
    -c "$HOME/.config/waybar/$LAPTOP_CONFIG/config.jsonc" \
    -s "$HOME/.config/waybar/$LAPTOP_CONFIG/style.css" &
}

monitor() {
  waybar \
    -c "$HOME/.config/waybar/$MONITOR_CONFIG/config.jsonc" \
    -s "$HOME/.config/waybar/$MONITOR_CONFIG/style.css" &
}

start-bars() {
  if $LAPTOP; then laptop; fi
  if $MONITOR; then monitor; fi
}

pkill waybar || start-bars
