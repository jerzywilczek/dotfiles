#!/bin/bash

CONFIG_LOC="/home/jerzywilczek/dotfiles/dot-config/waybar"

trap "killall waybar" EXIT

while true; do
  waybar &
  inotifywait -e create,modify $CONFIG_LOC
  killall waybar
done
