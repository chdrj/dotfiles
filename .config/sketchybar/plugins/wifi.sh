#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# 'ipconfig getsummary' is faster than airport for status-bar polling.
SSID=$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')

if [ "$SSID" = "" ]; then
  sketchybar --set "$NAME" icon=󰖪 icon.color=$WIFI_OFF
else
  sketchybar --set "$NAME" icon=󰖩 icon.color=$WIFI_ACCENT
fi
