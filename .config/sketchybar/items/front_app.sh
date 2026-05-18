#!/bin/sh

source "$CONFIG_DIR/colors.sh"

front_app=(
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
  icon="󱓞"
  icon.font="Hack Nerd Font:Bold:14.0"
  icon.color=$APP_ACCENT
  icon.padding_left=10
  icon.padding_right=6
  label.font="Cascadia Code:Bold:13.0"
  label.color=$WHITE
  label.padding_right=12
  background.drawing=on
  background.color=$ITEM_BG_COLOR
  background.border_color=$ITEM_BORDER
  background.border_width=1
  background.corner_radius=9
  background.height=26
)
sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
