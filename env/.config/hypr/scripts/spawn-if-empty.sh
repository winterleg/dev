#!/usr/bin/env bash

# $1 is workspace
# $2 is app to launch

hyprctl dispatch workspace "$1"
nbOfWindows=$(hyprctl activeworkspace -j | jq '.windows' -r)

if [[ "$nbOfWindows" == 0 ]]; then
  shift
  $@
fi
