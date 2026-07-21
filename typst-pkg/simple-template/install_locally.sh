#! /usr/bin/bash

directory="$HOME/.local/share/typst/packages/local/simple-template/0.1.0"

mkdir -p "$directory"
rm "$directory"/* -rf
cp ./* "$directory" -r
