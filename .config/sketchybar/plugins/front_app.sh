#!/bin/sh

# Updates the front_app label when the focused app changes.
# Font/color are owned by items/front_app.sh and don't need to be reset here.

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO"
fi
