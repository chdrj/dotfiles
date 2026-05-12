#!/bin/sh

# Day + 12-hour clock. The CONFIG_DIR-aware items file (sketchybarrc)
# owns the icon/font/colors — this script only sets the live label.
sketchybar --set "$NAME" label="$(date '+%e · %I:%M')"
