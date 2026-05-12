#!/bin/bash

# Background helper that turns the clock into an event-driven item.
# Triggers the `clock_update` custom event exactly on each minute boundary,
# so the clock script only runs when it actually needs to (instead of every
# 10s via update_freq). Exits cleanly if sketchybar is no longer running.
#
# Started (and re-started) from sketchybarrc; a single instance is enforced
# there by pkill before spawning this script.

while :; do
  # Sleep until the next minute boundary. 10# forces base-10 so leading
  # zeros in seconds (e.g. "08", "09") don't get parsed as octal.
  sleep $(( 60 - 10#$(date +%S) ))
  sketchybar --trigger clock_update 2>/dev/null || exit 0
done
