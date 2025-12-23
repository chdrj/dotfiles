#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  #sketchybar --set $NAME background.color=0xff003547 label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2
  sketchybar --set $NAME icon="" \
  background.drawing=on label.drawing=off background.color=0xffffffff icon.color=0xff000000 \
  background.corner_radius=4 icon.padding_left=8 \
  icon.padding_right=8 background.border_width=0 \
  icon.shadow.drawing=off label.shadow.drawing=off drawing=on
else
  sketchybar --set $NAME background.drawing=on \
  background.corner_radius=4 icon.padding_left=8 \
  icon.padding_right=8 background.border_width=0 \
  icon.shadow.drawing=off label.shadow.drawing=off \
  icon="" label.drawing=off background.color=0x44ffffff \
  icon.color=0xffffffff drawing=on
fi


# $1 is the workspace name passed from the item

# Define the box style
# corner_radius=0 makes it a sharp rectangle. Change to 4 or 5 for slightly rounded corners.
# BOX_CONFIG="background.drawing=on background.corner_radius=4 icon.padding_left=8 icon.padding_right=8 background.border_width=0 icon.shadow.drawing=off label.shadow.drawing=off"

# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#   # Focused Workspace: brighter box, show number ($1)
#   sketchybar --set $NAME \
#     $BOX_CONFIG \
#     icon="$1" \
#     label.drawing=off \
#     background.color=0xffffffff \
#     icon.color=0xff000000 \
#     drawing=on
# else
#   # Unfocused Workspace
  
#   # Check if workspace is empty
#   WINDOW_COUNT=$(aerospace list-windows --workspace "$1" | wc -l)
  
#   if [ "$WINDOW_COUNT" -gt 0 ]; then
#     # Has windows: dimmed box, show number
#     sketchybar --set $NAME \
#       $BOX_CONFIG \
#       icon="$1" \
#       label.drawing=off \
#       background.color=0x44ffffff \
#       icon.color=0xffffffff \
#       drawing=on
#   else
#     # Empty: hide it
#     sketchybar --set $NAME drawing=off
#   fi
# fi