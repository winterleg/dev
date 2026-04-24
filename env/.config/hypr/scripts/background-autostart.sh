#!/usr/bin/env bash

mime=$(file --mime-type -b -L "$HOME/.current.wall")

case "$mime" in
video/*)
  mpvpaper \
    '*' \
    -o "--panscan=1.0 vf-add=fps=10:round=near no-audio --loop-file=inf" \
    "$HOME/.current.wall"
  ;;
image/*)
  awww-daemon
  ;;
*) ;;
esac
