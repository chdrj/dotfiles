#!/bin/sh

# Get the current WiFi SSID
# We use 'ipconfig getsummary' which is faster for status bars
SSID=$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')

# Check if SSID is empty (disconnected)
if [ "$SSID" = "" ]; then
  sketchybar --set $NAME icon=󰖪
else
  sketchybar --set $NAME icon=󰖩
fi
