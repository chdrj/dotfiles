# dotfiles

Personal macOS setup. Keyboard-driven, tiling, terminal-first.

**Stack:** [AeroSpace](https://github.com/nikitabobko/AeroSpace) (WM) · [SketchyBar](https://github.com/FelixKratz/SketchyBar) (bar) · [JankyBorders](https://github.com/FelixKratz/JankyBorders) (focus border) · [Kitty](https://sw.kovidgoyal.net/kitty/) (terminal) · [LazyVim](https://www.lazyvim.org/) (editor) · [tmux](https://github.com/tmux/tmux) · [Karabiner](https://karabiner-elements.pqrs.org/) (Caps→Hyper) · zsh + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) · [fastfetch](https://github.com/fastfetch-cli/fastfetch)

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
    ├── fastfetch/
    ├── karabiner/             # Caps→Hyper, Hyper-key app launchers
    ├── kitty/                 # gruvbox theme
    ├── nvim/                  # LazyVim
    ├── sketchybar/            # sketchybarrc + items/ + plugins/
    └── tmux/
```

---

## Install

### 1. Homebrew + packages

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap FelixKratz/formulae
brew install sketchybar borders fastfetch stow tmux \
             fd ripgrep zoxide eza bat fzf lazygit imagemagick
brew install --cask nikitabobko/tap/aerospace kitty karabiner-elements

brew install --cask \
  font-caskaydia-cove-nerd-font \
  font-hack-nerd-font \
  font-cascadia-code \
  sbarlv/sketchybar-app-font/sketchybar-app-font
```

### 2. Zsh plugins

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
# zsh-autosuggestions is auto-cloned by .zshrc on first run.
```

### 3. Stow the repo

```bash
git clone https://github.com/chdrj/dotfiles.git ~/dotfiles

# Back up anything that would conflict.
mkdir -p ~/dotfiles-backup
[ -f ~/.zshrc ] && mv ~/.zshrc ~/dotfiles-backup/
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
p10k configure                 # optional, writes ~/.p10k.zsh (untracked)
```

---

## Day-to-day

| Action | Command / Keybind |
| --- | --- |
| Reload SketchyBar | `sketchybar --reload` |
| Reload AeroSpace | `aerospace reload-config` |
| Reload zsh | `exec zsh` |
| Hyper-key launchers | `Hyper+T` kitty · `Hyper+B` Brave · `Hyper+W` Windsurf · `Hyper+S` Spotify |
| tmux sessionizer | `Ctrl-f` (zsh) or `prefix+f` (tmux) |
| Smart cd | `z <substring>` |
| Calendar dropdown | click the clock pill |

---

## Notes

- **Per-app workspace glyphs** require `icon_map_fn.sh` from <https://github.com/kvndrsslr/sketchybar-app-font>. Drop into `.config/sketchybar/plugins/` and `chmod +x`.
- **Karabiner** is symlinked per-file (only `karabiner.json`), since Karabiner writes `assets/` and `automatic_backups/` into its config dir.
- **Workspace → monitor** assignment is the `for monitor … for sid …` loop in `sketchybarrc`. Edit for your own layout.

---

## Credits

[AeroSpace](https://github.com/nikitabobko/AeroSpace) · [SketchyBar](https://github.com/FelixKratz/SketchyBar) · [JankyBorders](https://github.com/FelixKratz/JankyBorders) · [LazyVim](https://github.com/LazyVim/LazyVim) · [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) · [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
