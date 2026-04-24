#!/usr/bin/env bash

# kitty --class="kittynvimscratch" nvim $HOME/personal/zxcv.md
#
if [ "$1" == "zxcv" ]; then
  alacritty --class="alacritty.scratch" -e nvim -c "cd $HOME/notes" zxcv.txt
else
  if [ "$1" == "faire" ]; then
    alacritty --class="alacritty.scratch" -e nvim $HOME/notes/todo.txt
  fi
fi
