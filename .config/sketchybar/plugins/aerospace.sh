#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

case "$1" in
  1) ICON="󰖟" ;;  # Browser
  2) ICON="󰆍" ;;  # Terminal
  3) ICON="" ;;  # Code
  4) ICON="󰓇" ;;  # Spotify
  5) ICON="󱞂" ;;  # Obsidian
  6) ICON="" ;;  # Discord
  7) ICON="" ;;  # random
  A) ICON="󰍡" ;;  # Messages
  *) ICON="$1" ;;
esac

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color=$WS_ACTIVE_FG \
    icon.font="Hack Nerd Font:Bold:14.0" \
    icon.shadow.drawing=off \
    background.drawing=on \
    background.color=$WS_ACTIVE_BG \
    background.border_color=$WS_ACTIVE_BG \
    background.border_width=0 \
    background.corner_radius=8 \
    background.height=24 \
    label.drawing=off \
    drawing=on
else
  sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color=$WS_INACTIVE_FG \
    icon.font="Hack Nerd Font:Regular:14.0" \
    icon.shadow.drawing=on \
    icon.shadow.color=0x66000000 \
    icon.shadow.distance=2 \
    background.drawing=on \
    background.color=$WS_INACTIVE_BG \
    background.border_color=$ITEM_BORDER \
    background.border_width=1 \
    background.corner_radius=8 \
    background.height=24 \
    label.drawing=off \
    drawing=on
fi
