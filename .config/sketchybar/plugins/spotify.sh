#!/bin/bash

# ─── Spotify now-playing ──────────────────────────────────────
# Event-driven via com.spotify.client.PlaybackStateChanged.
# Click toggles play/pause.

source "$CONFIG_DIR/colors.sh"

# Mouse click → toggle play/pause, then exit (the event will refresh the label)
if [ "$SENDER" = "mouse.clicked" ]; then
  osascript -e 'tell application "Spotify" to playpause' >/dev/null 2>&1
  exit 0
fi

# If Spotify isn't running, hide the item (avoids launching it)
if ! pgrep -xq "Spotify"; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

PLAYER_STATE="$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)"

if [ -z "$PLAYER_STATE" ] || [ "$PLAYER_STATE" = "stopped" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

TRACK="$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)"

if [ "$PLAYER_STATE" = "playing" ]; then
  ICON="󰓇"
  ICON_COLOR=$SPOTIFY_ACCENT
else
  ICON="󰏤"
  ICON_COLOR=$SPOTIFY_PAUSED
fi

LABEL="${TRACK}"
# Trim to keep the bar tidy (~2/3 of previous width)
if [ ${#LABEL} -gt 25 ]; then
  LABEL="${LABEL:0:24}…"
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL"
