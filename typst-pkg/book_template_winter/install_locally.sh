#! /usr/bin/bash

directory="$HOME/.local/share/typst/packages/local/book_template_winter/0.1.0"

mkdir -p "$directory"
rm "$directory"/* -rf
cp ./* "$directory" -r
