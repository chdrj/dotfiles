#!/bin/sh

# Day + 12-hour clock. The CONFIG_DIR-aware items file (sketchybarrc)
# owns the icon/font/colors — this script only sets the live label.
# %-d drops the leading-space/zero padding so single-digit days
# (e.g. "1") don't render as " 1" and misalign the separator.
sketchybar --set "$NAME" label="$(date '+%-d · %I:%M')"
