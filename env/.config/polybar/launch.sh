#!/bin/bash

killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

cfg="$(dirname "$(readlink -f "$0")")/config.ini"

# Launch a bar for each [bar/*] section whose monitor is currently connected
for bar in main secondary; do
    monitor="$(sed -n "/^\[bar\/$bar\]/,/^\[/p" "$cfg" | sed -n 's/^monitor = //p' | head -1)"
    if [ -n "$monitor" ] && polybar --list-monitors 2>/dev/null | grep -q "^${monitor}:"; then
        polybar "$bar" &
    fi
done
