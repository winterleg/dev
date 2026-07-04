#!/usr/bin/env bash

FORCE_DISABLE_LAPTOP=true
FORCE_DISABLE_MONITOR=false

LAPTOP_CONFIG="laptopv3"
MONITOR_CONFIG="monitorv3"

LAPTOPNAME="eDP-1"
MONITORNAME="HDMI-A-1"

detect_compositor() {
  if command -v hyprctl &>/dev/null && hyprctl monitors -j &>/dev/null; then
    COMPOSITOR="hyprland"
  elif command -v labwc &>/dev/null && pgrep -x labwc &>/dev/null; then
    COMPOSITOR="labwc"
  elif command -v wlr-randr &>/dev/null; then
    COMPOSITOR="labwc"
  fi
}

has_monitor() {
  local name="$1"
  case "$COMPOSITOR" in
  hyprland)
    hyprctl monitors -j 2>/dev/null | jq -e --arg name "$name" \
      '.[] | select(.name == $name)' >/dev/null 2>&1
    ;;
  labwc)
    wlr-randr 2>/dev/null | grep -q "^$name "
    ;;
  *)
    return 1
    ;;
  esac
}

detect_compositor

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
