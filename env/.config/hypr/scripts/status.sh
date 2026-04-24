#!/usr/bin/env bash

# battery() {
#   upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
#     awk '/state:/ { s=$2 } /percentage:/ { p=$2 } END { print p " (" s ")" }'
# }

# dunstify "$(wpctl get-volume @DEFAULT_SINK@) | $(date) | $(battery)"
dunstify "$(wpctl get-volume @DEFAULT_SINK@) | $(date)"
