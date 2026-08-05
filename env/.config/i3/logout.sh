#!/usr/bin/env bash

pkill xautolock

(
	while xset q | grep -q "Monitor is Off"; do
		sleep 1
	done

	xautolock -time 5 -locker "i3lock -c 191724" &
) &

options="Lock & DPMS
Lock & Suspend
Suspend
Shutdown"

selection=$(echo "$options" | rofi -i -show -dmenu)

if [[ "$selection" == "Lock & DPMS" ]]; then
	i3lock -c 191724
	xset dpms force off
elif [[ "$selection" == "Lock & Suspend" ]]; then
	i3lock -c 191724
	systemctl suspend

elif [[ "$selection" == "Suspend" ]]; then
	systemctl suspend

elif [[ "$selection" == "Shutdown" ]]; then
	systemctl poweroff
fi
