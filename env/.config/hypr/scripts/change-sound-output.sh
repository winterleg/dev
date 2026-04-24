#!/usr/bin/env bash

output_devices=$(wpctl status | awk '
  /^Audio/ {a=1; next}
  /^Video/ {a=0}
  a && /Sinks:/ {d=1; next}
  d && /^[[:space:]]*├─/ {d=0}
  d && /^[[:space:]]*│/ {
    sub(/^[[:space:]]*│[[:space:]]*/, "")
    id=$1; sub(/\.$/, "", id)
    $1=""
    sub(/^[[:space:]]*/, "")
    print id, $0
}' | head -n -1)

choice=$(echo "$output_devices" | rofi -config ~/.config/rofi/config-copy.rasi -dmenu -p "Sorties audio" -i -no-fixed-num-lines -lines 20)
if [ -z "$choice" ]; then
  echo "No choice provided"
  exit 0
fi
if [[ "$choice" =~ \* ]]; then
  echo "Already default sink"
  exit 0
fi

device_id=$(echo "$choice" | awk '{print $1}')

echo "$device_id"
wpctl set-default "$device_id"
