#!/usr/bin/env bash

programName="$1"

[[ -z "$programName" ]] && exit 1

# check seulement si une fenêtre existe et non si le programme existe en
# background, mais bon... pas si important...
is_running() {
  hyprctl clients -j |
    jq -r ".[] | select(.class | test(\"$programName\"; \"i\")) | .class" |
    grep -q .
}

if ! is_running "$programName"; then
  "$programName" &
  disown
fi
