#!/bin/bash

# ─────────────────────────────────────────────
#  Neon Glass Terminal — Dracula-leaning palette
# ─────────────────────────────────────────────

# Base
export WHITE=0xfff8f8f2          # Cream foreground (Dracula fg)
export DIM=0x66f8f8f2            # Dim foreground for separators / inactive labels
export GHOST=0x33ffffff          # Ghost glass for borders / very subtle fills

# Bar
export BAR_COLOR=0xc8101218      # Smoked-glass charcoal
export BAR_BORDER=0x22ffffff     # Hairline border

# Capsule (item background) tones
export ITEM_BG_COLOR=0x22ffffff           # Subtle glass capsule
export ITEM_BG_STRONG=0x33ffffff          # Slightly more prominent capsule
export ITEM_BORDER=0x1affffff             # Whisper border on capsules

# Workspace states
export WS_ACTIVE_BG=0xfff8f8f2            # Solid cream when focused
export WS_ACTIVE_FG=0xff0d0f14            # Near-black icon on active
export WS_INACTIVE_BG=0x22ffffff
export WS_INACTIVE_FG=0xfff8f8f2

# Per-metric accents (Dracula palette)
export APP_ACCENT=0xff50fa7b              # Mint — front app
export CLOCK_ACCENT=0xfff8f8f2            # Cream — clock
export MEM_ACCENT=0xffffb86c              # Amber — memory
export WIFI_ACCENT=0xff8be9fd             # Cyan — wifi connected
export WIFI_OFF=0xff6272a4                # Comment-blue — wifi off
export VOL_ACCENT=0xffbd93f9              # Violet — volume
export VOL_MUTE=0xff6272a4                # Muted volume

# Battery thresholds
export BAT_OK=0xff50fa7b                  # Mint  > 50
export BAT_WARN=0xfff1fa8c                # Yellow 21–50
export BAT_LOW=0xffff5555                 # Red    ≤ 20
export BAT_CHARGE=0xff8be9fd              # Cyan when plugged in

# Memory thresholds
export MEM_OK=0xffffb86c                  # Amber default
export MEM_HIGH=0xffff79c6                # Pink when pressure is high

# Spotify (brand green)
export SPOTIFY_ACCENT=0xff1ed760
export SPOTIFY_PAUSED=0xff6272a4

# Legacy variable kept for any item still referencing it
export ACCENT_COLOR=0xff8be9fd
