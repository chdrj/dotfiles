#!/usr/bin/env bash

case "$1" in
  1) ICON="󰖟" ;; # Browser
  2) ICON="" ;; # Terminal
  3) ICON="" ;; # Code
  4) ICON="" ;; # Spotify
  5) ICON="" ;; # Discord
  6) ICON="" ;; # Random
  7) ICON="" ;; # Random
  A) ICON="󰍡" ;; #messages
  *) ICON="$1" ;;
esac

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  #sketchybar --set $NAME background.color=0xff003547 label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2
  sketchybar --set $NAME icon="$1" \
  background.drawing=on label.drawing=off background.color=0xffffffff icon.color=0xff000000 \
  background.corner_radius=4 icon.padding_left=8 \
  icon.padding_right=8 background.border_width=0 \
  icon.shadow.drawing=off label.shadow.drawing=off drawing=on icon="$ICON"
else
  sketchybar --set $NAME background.drawing=on \
  background.corner_radius=4 icon.padding_left=8 \
  icon.padding_right=8 background.border_width=0 \
  icon.shadow.drawing=off label.shadow.drawing=off \
  icon="$1" label.drawing=off background.color=0x44ffffff \
  icon.color=0xffffffff drawing=on icon="$ICON"
fi