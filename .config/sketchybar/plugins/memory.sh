#!/bin/bash

# Memory Used = App Memory + Wired + Compressed (matches Activity Monitor)
# Single awk pass: parses vm_stat and computes used GB in one shot
USED_GB=$(vm_stat | awk '
  /Anonymous pages/              { anon = $3 + 0 }
  /Pages purgeable/              { purg = $3 + 0 }
  /Pages wired down/             { wired = $4 + 0 }
  /Pages occupied by compressor/ { comp = $5 + 0 }
  END { printf "%.1f", (anon - purg + wired + comp) * 16384 / 1073741824 }
')

TOTAL_RAM_GB=$(sysctl -n hw.memsize | awk '{printf "%.1f", $1 / 1073741824}')

sketchybar --set $NAME label="${USED_GB}GB/${TOTAL_RAM_GB}GB" icon=""


