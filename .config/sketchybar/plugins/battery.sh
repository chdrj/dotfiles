#!/bin/sh

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

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
