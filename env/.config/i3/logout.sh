#!/usr/bin/env bash

# After locking/suspend, xautolock locks after the set amount of time
# if no inputs, which is not nice when watching a video or something.
# Restarting it brings it back to default behaviour where it won't lock
# when watching something.
pkill xautolock

(
	while xset q | grep -q "Monitor is Off"; do
		sleep 30
	done

	xautolock -time 5 -locker "i3lock -c 191724" &

	sudo tlp power-saver
) &

options="Lock & Screen Off
Lock & Suspend
Shutdown
Reboot"

selection=$(echo "$options" | rofi -i -show -dmenu)

if [[ "$selection" == "Lock & Screen Off" ]]; then
	sudo tlp power-saver
	i3lock -c 191724
	xset dpms force off
elif [[ "$selection" == "Lock & Suspend" ]]; then
	i3lock -c 191724
	systemctl suspend
elif [[ "$selection" == "Shutdown" ]]; then
	systemctl poweroff
elif [[ "$selection" == "Reboot" ]]; then
	systemctl reboot
fi
