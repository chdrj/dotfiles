#!/bin/bash

# Calculate used memory
# Active($3) + Wired($4) + Compressed($5)
# vm_stat output format:
# "Pages active: 123." ($3)
# "Pages wired down: 456." ($4)
# "Pages occupied by compressor: 789." ($5)

PAGE_SIZE=$(sysctl -n hw.pagesize)
VM_STAT=$(vm_stat)

# Extract pages correctly
PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | tr -d '.')
PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')
PAGES_COMPRESSED=$(echo "$VM_STAT" | grep "Pages occupied by compressor" | awk '{print $5}' | tr -d '.')

# Calculate total used pages
TOTAL_USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))

# Convert to GB
USED_GB=$(awk -v pages="$TOTAL_USED_PAGES" -v size="$PAGE_SIZE" 'BEGIN { printf "%.1f", (pages * size) / 1024 / 1024 / 1024 }')

sketchybar --set $NAME label="${USED_GB}GB/18.0GB" icon=""