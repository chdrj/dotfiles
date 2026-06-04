#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# Read battery state once, then parse both fields from it.
BATT="$(pmset -g batt)"
PERCENTAGE="$(printf '%s\n' "$BATT" | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(printf '%s\n' "$BATT" | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON="󰁹" ;;
  [6-8][0-9]) ICON="󰂁" ;;
  [3-5][0-9]) ICON="󰁾" ;;
  [1-2][0-9]) ICON="󰁻" ;;
  *)          ICON="󰂎" ;;
esac

if [ "$PERCENTAGE" -le 20 ]; then
  COLOR=$BAT_LOW
elif [ "$PERCENTAGE" -le 50 ]; then
  COLOR=$BAT_WARN
else
  COLOR=$BAT_OK
fi

if [ "$CHARGING" != "" ]; then
  ICON="󰂄"
  COLOR=$BAT_CHARGE
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
