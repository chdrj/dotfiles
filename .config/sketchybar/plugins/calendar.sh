#!/bin/bash

# ─── Calendar dropdown ────────────────────────────────────────
# Triggered as the clock's click_script. Populates 8 popup line
# items with the current month's `cal` output and toggles the
# popup attached to the clock.

source "$CONFIG_DIR/colors.sh"

# Capture up to 8 lines of `cal` output (header + day-name row + up to 6 weeks).
CAL_LINES=()
while IFS= read -r line; do
  CAL_LINES+=("$line")
done < <(cal)

# Pad to 8 entries so trailing blank rows still render cleanly.
while [ ${#CAL_LINES[@]} -lt 8 ]; do
  CAL_LINES+=("")
done

# Push each line into its corresponding popup item.
for i in 1 2 3 4 5 6 7 8; do
  sketchybar --set cal.line.$i label="${CAL_LINES[$((i-1))]}"
done

# Toggle visibility of the clock's popup.
sketchybar --set clock popup.drawing=toggle
