# Brewfile — reproducible toolchain for these dotfiles.
#
#   brew bundle --file=~/dotfiles/Brewfile     # install everything
#   brew bundle check --file=~/dotfiles/Brewfile   # what's missing?
#   brew bundle cleanup --file=~/dotfiles/Brewfile # list extras (add --force to remove)
#
# Add a tool here whenever you add one, so the repo stays the source of truth.

# ── Taps ─────────────────────────────────────────────────────
tap "felixkratz/formulae"          # sketchybar, borders
tap "nikitabobko/tap"              # aerospace

# ── CLI tools ────────────────────────────────────────────────
brew "stow"          # symlink manager for this repo
brew "tmux"
brew "starship"      # prompt
brew "fzf"           # fuzzy finder
brew "fd"            # fast find (fzf backend)
brew "ripgrep"       # fast grep
brew "zoxide"        # smart cd
brew "eza"           # modern ls
brew "bat"           # cat with syntax highlighting
brew "lazygit"
brew "yazi"          # terminal file manager
brew "btop"          # system monitor
brew "gh"            # GitHub CLI
brew "fastfetch"
brew "imagemagick"   # image previews (yazi / kitty)

# ── Bar / WM / borders ───────────────────────────────────────
brew "sketchybar"
brew "borders"

# ── Casks ────────────────────────────────────────────────────
cask "aerospace"             # tiling WM (nikitabobko/tap)
cask "kitty"                 # terminal
cask "karabiner-elements"    # Caps → Hyper

# ── Fonts ────────────────────────────────────────────────────
cask "font-caskaydia-cove-nerd-font"   # kitty UI font
cask "font-hack-nerd-font"             # sketchybar icons
cask "font-cascadia-code"              # sketchybar labels

# sketchybar-app-font (per-app workspace glyphs) is NOT a brew cask — install
# the .ttf directly into ~/Library/Fonts. See README "One-time tool setup".
