# dotfiles

Personal macOS setup. Keyboard-driven, tiling, terminal-first.

**Stack:** [AeroSpace](https://github.com/nikitabobko/AeroSpace) (WM) · [SketchyBar](https://github.com/FelixKratz/SketchyBar) (bar) · [JankyBorders](https://github.com/FelixKratz/JankyBorders) (focus border) · [Kitty](https://sw.kovidgoyal.net/kitty/) (terminal) · [LazyVim](https://www.lazyvim.org/) (editor) · [tmux](https://github.com/tmux/tmux) · [Karabiner](https://karabiner-elements.pqrs.org/) (Caps→Hyper) · zsh + [Starship](https://starship.rs/) (prompt) · [yazi](https://github.com/sxyazi/yazi) (file manager) · [btop](https://github.com/aristocratos/btop) (sysmon) · [gh](https://cli.github.com/) (GitHub CLI) · [fastfetch](https://github.com/fastfetch-cli/fastfetch)

Deployed into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).

---

## Layout

```
dotfiles/
├── .zshrc
├── bin/                       # custom scripts (on $PATH via .zshrc)
│   └── tmux-sessionizer
└── .config/
    ├── aerospace/             # tiling WM + keybinds
    ├── borders/               # JankyBorders style
    ├── btop/                  # gruvbox theme
    ├── fastfetch/
    ├── karabiner/             # Caps→Hyper, Hyper-key app launchers
    ├── kitty/                 # gruvbox theme
    ├── nvim/                  # LazyVim
    ├── sketchybar/            # sketchybarrc + items/ + plugins/
    ├── starship.toml          # zsh prompt (gruvbox)
    ├── tmux/
    └── yazi/                  # yazi.toml + theme.toml + package.toml
```

---

## Install

### 1. Homebrew + packages

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repo (needed for the Brewfile, and later for stow)
git clone https://github.com/chdrj/dotfiles.git ~/dotfiles

# Install everything — formulae, casks, and fonts — from the Brewfile
brew bundle --file=~/dotfiles/Brewfile
```

> The full package list lives in [`Brewfile`](Brewfile). Add a tool there and
> re-run `brew bundle` to keep the toolchain reproducible.

### 2. Zsh plugins

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
# zsh-autosuggestions is auto-cloned by .zshrc on first run.
# Prompt is Starship (installed via brew above); config lives at .config/starship.toml.
```

### 3. Stow the repo

```bash
# (repo already cloned in step 1)

# Back up anything that would conflict.
mkdir -p ~/dotfiles-backup
[ -f ~/.zshrc ] && mv ~/.zshrc ~/dotfiles-backup/
[ -f ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/dotfiles-backup/
for d in aerospace borders fastfetch karabiner kitty nvim sketchybar tmux; do
  [ -e ~/.config/$d ] && mv ~/.config/$d ~/dotfiles-backup/
done

stow -d ~ -t ~ -nv dotfiles    # dry-run, verify
stow -d ~ -t ~ dotfiles        # commit
```

### 4. Start services

```bash
open -a AeroSpace
brew services start sketchybar
open -a "Karabiner-Elements"   # grant Input Monitoring on first launch
exec zsh
```

### 5. One-time tool setup

```bash
# sketchybar-app-font: per-app workspace glyphs (not a brew cask).
# Download the latest sketchybar-app-font.ttf release into ~/Library/Fonts.
curl -fLo "$HOME/Library/Fonts/sketchybar-app-font.ttf" \
  https://github.com/kvndrsslr/sketchybar-app-font/releases/latest/download/sketchybar-app-font.ttf

# yazi: install the gruvbox-dark flavor declared in .config/yazi/package.toml
ya pkg install

# gh: authenticate (browser flow, picks up the token in ~/.config/gh)
gh auth login
```

---

## Day-to-day

| Action | Command / Keybind |
| --- | --- |
| Reload SketchyBar | `sketchybar --reload` |
| Reload AeroSpace | `aerospace reload-config` |
| Reload zsh | `exec zsh` |
| Hyper-key launchers | `Hyper+T` kitty · `Hyper+B` Vivaldi · `Hyper+S` Spotify |
| tmux sessionizer | `Ctrl-f` (zsh) or `prefix+f` (tmux) |
| Smart cd | `z <substring>` |
| File manager | `yy` (yazi, exits to selected dir) |
| System monitor | `top` (aliased to btop) |
| Open PR in browser | `ghpr` |

---

## Notes

- **Per-app workspace glyphs** require `icon_map_fn.sh` from <https://github.com/kvndrsslr/sketchybar-app-font>. Drop into `.config/sketchybar/plugins/` and `chmod +x`.
- **Karabiner** is symlinked per-file (only `karabiner.json`), since Karabiner writes `assets/` and `automatic_backups/` into its config dir.
- **Workspace → monitor** assignment is the `for monitor … for sid …` loop in `sketchybarrc`. Edit for your own layout.

---

## Credits

[AeroSpace](https://github.com/nikitabobko/AeroSpace) · [SketchyBar](https://github.com/FelixKratz/SketchyBar) · [JankyBorders](https://github.com/FelixKratz/JankyBorders) · [LazyVim](https://github.com/LazyVim/LazyVim) · [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font)
