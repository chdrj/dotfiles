#!/bin/sh

# 1. Get the Wi-Fi interface
DEVICE=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/ {getline; print $2}')

# 2. Get the prompt
NET=$(networksetup -getairportnetwork "$DEVICE")

# 3. Check exact status
# Case A: "Current Wi-Fi Network: MyWifiName"
if [[ "$NET" == "Current Wi-Fi Network"* ]]; then
  SSID="${NET#Current Wi-Fi Network: }"
  sketchybar --set $NAME label="$SSID" 

# Case B: "You are not associated with an AirPort network." or "Wi-Fi Power is off"
else
  sketchybar --set $NAME label="Disconnected"
fi