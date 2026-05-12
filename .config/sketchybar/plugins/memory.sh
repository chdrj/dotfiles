#!/bin/bash

# Matches Activity Monitor / fastfetch exactly:
#   used = total_ram - (free - speculative + file_backed) * page_size
# Reference: fastfetch src/detection/memory/memory_apple.c
#
# Single pipeline (one vm_stat + one awk + one sysctl) keeps this lightweight.
# Page size is parsed from the vm_stat header so it works on both
# Apple Silicon (16 KiB pages) and Intel (4 KiB pages) Macs.

sketchybar --set "$NAME" icon="" label="$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" '
  NR == 1 { for (i = 1; i <= NF; i++) if ($i == "of") { page = $(i+1) + 0; break } }
  /^Pages free:/        { free = $3 + 0 }
  /^Pages speculative:/ { spec = $3 + 0 }
  /^File-backed pages:/ { fb   = $3 + 0 }
  END {
    used = total - (free - spec + fb) * page
    printf "%.1fGB/%.0fGB", used / 1073741824, total / 1073741824
  }
')" icon=""
