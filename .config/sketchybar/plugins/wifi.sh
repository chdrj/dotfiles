#!/bin/sh
# Get the current WiFi SSID
SSID=$(networksetup -getairportnetwork en0 | sed 's/^Current Wi-Fi Network: //')
if [ "$SSID" = "Wi-Fi power is currently off." ] || [ "$SSID" = "You are not associated with an AirPort network." ]; then
  sketchybar --set $NAME label="Disconnected" icon=󰖪
else
  sketchybar --set $NAME label="$SSID" icon=󰖩
fi
