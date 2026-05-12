#!/bin/bash

# Matches Activity Monitor / fastfetch exactly:
#   used = total_ram - (free - speculative + file_backed) * page_size
# Single pipeline keeps this lightweight; page size is parsed from the
# vm_stat header so it works on both Apple Silicon and Intel Macs.

source "$CONFIG_DIR/colors.sh"

read used total <<<"$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" '
  NR == 1 { for (i = 1; i <= NF; i++) if ($i == "of") { page = $(i+1) + 0; break } }
  /^Pages free:/        { free = $3 + 0 }
  /^Pages speculative:/ { spec = $3 + 0 }
  /^File-backed pages:/ { fb   = $3 + 0 }
  END {
    used_bytes = total - (free - spec + fb) * page
    printf "%.2f %.0f", used_bytes / 1073741824, total / 1073741824
  }
')"

# Pressure threshold: shift to pink when usage crosses 80%.
PRESSURE=$(awk -v u="$used" -v t="$total" 'BEGIN { printf "%.0f", (u/t)*100 }')
if [ "${PRESSURE:-0}" -ge 80 ]; then
  COLOR=$MEM_HIGH
else
  COLOR=$MEM_OK
fi

LABEL=$(printf "%.1fGB/%sGB" "$used" "$total")

sketchybar --set "$NAME" icon="" icon.color=$COLOR label="$LABEL"
