# dotfiles

Personal macOS setup centered around a keyboard-driven tiling workflow:
[AeroSpace](https://github.com/nikitabobko/AeroSpace) as the window
manager, [SketchyBar](https://github.com/FelixKratz/SketchyBar) as the
status bar, [JankyBorders](https://github.com/FelixKratz/JankyBorders)
around the focused window, and [Kitty](https://sw.kovidgoyal.net/kitty/)
as the terminal. Shell is zsh via
[Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k),
and [fastfetch](https://github.com/fastfetch-cli/fastfetch) is printed on
every new shell.

Everything here is intended to be symlinked into `$HOME` with
[GNU Stow](https://www.gnu.org/software/stow/).

---

## Repository layout

```
dotfiles/
├── .zshrc                        # Shell config (Oh My Zsh + p10k)
└── .config/
    ├── aerospace/
    │   └── aerospace.toml        # Tiling WM config + keybindings
    ├── borders/
    │   └── bordersrc             # JankyBorders style (borders CLI)
    ├── fastfetch/
    │   └── config.jsonc          # fastfetch layout
    ├── kitty/
    │   ├── kitty.conf            # Terminal config (Tokyo Night Moon)
    │   └── current-theme.conf    # Color palette (included by kitty.conf)
    └── sketchybar/
        ├── sketchybarrc          # Bar entrypoint (bar + items)
        ├── colors.sh             # Theme palette used by every plugin
        ├── items/
        │   └── front_app.sh      # "Focused app" indicator definition
        └── plugins/              # Scripts executed by each bar item
            ├── aerospace.sh      # Per-workspace icon + state
            ├── battery.sh
            ├── clock.sh          # Renders the time (event-driven)
            ├── clock_updater.sh  # Minute-boundary trigger for the clock
            ├── front_app.sh      # Updates the focused-app label
            ├── load_spaces.sh    # (unused) initial workspace bootstrap
            ├── memory.sh         # Matches Activity Monitor / fastfetch
            ├── space.sh
            ├── space_windows.sh  # App icons under each workspace number
            ├── update_workspace_icons.sh
            ├── volume.sh
            └── wifi.sh
```

---

## Dependencies

Everything below is installable through [Homebrew](https://brew.sh). If
you do not have brew, install it first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Core tools

| Package | What it is | Install |
| --- | --- | --- |
| **AeroSpace** | i3-style tiling window manager for macOS. Drives workspaces 1–7 + `A`, binds `alt+{h,j,k,l}` for focus, `alt+shift+{h,j,k,l}` for move, `alt+1..7` / `alt+a` to switch workspace. | `brew install --cask nikitabobko/tap/aerospace` |
| **SketchyBar** | Scriptable status bar. Draws the top bar; items are defined in `sketchybarrc` and updated by the scripts under `plugins/`. | `brew tap FelixKratz/formulae && brew install sketchybar` |
| **JankyBorders** (`borders`) | Adds a colored border around the focused window. Invoked at AeroSpace startup from `aerospace.toml`. | `brew tap FelixKratz/formulae && brew install borders` |
| **Kitty** | GPU-accelerated terminal, configured with semi-transparent background + Tokyo Night Moon theme. | `brew install --cask kitty` |
| **fastfetch** | System info shown on every new shell (see the last line of `.zshrc`). | `brew install fastfetch` |
| **GNU Stow** | Symlink farm manager used to deploy this repo into `$HOME`. | `brew install stow` |
| **Git** | Needed to clone this repo and the zsh plugins below. | `brew install git` (or use Apple's CLT) |

One-liner for the core stack:

```bash
brew tap FelixKratz/formulae
brew install sketchybar borders fastfetch stow
brew install --cask nikitabobko/tap/aerospace kitty
```

### Fonts

Every font referenced by the configs (kitty, sketchybar icons + labels,
aerospace icons). Install them all via brew's font cask tap:

```bash
brew install --cask \
  font-caskaydia-cove-nerd-font \
  font-hack-nerd-font \
  font-cascadia-code \
  sbarlv/sketchybar-app-font/sketchybar-app-font
```

| Font | Used by |
| --- | --- |
| **CaskaydiaCove Nerd Font Mono** | Kitty terminal font (`kitty.conf`). |
| **CaskaydiaCove Nerd Font** | SketchyBar default icon + label font (`sketchybarrc`). |
| **Cascadia Code** | Focused-app label (`items/front_app.sh`). |
| **Hack Nerd Font** | Workspace icons + front-app glyph (`plugins/aerospace.sh`, `items/front_app.sh`). |
| **sketchybar-app-font** | Per-app icons shown under each workspace (via `icon_map_fn.sh`, rendered at `label.font="sketchybar-app-font:Regular:16.0"` in `sketchybarrc`). |

> `icon_map_fn.sh` is pulled from the sketchybar-app-font repo. If you
> want the per-app glyphs next to each workspace number, drop the
> latest `icon_map_fn.sh` into `~/.config/sketchybar/plugins/` and
> `chmod +x` it. Grab it from
> <https://github.com/kvndrsslr/sketchybar-app-font/blob/main/icon_map_fn.sh>.

### Zsh stack

`.zshrc` uses Oh My Zsh with Powerlevel10k and three plugins:

| Component | Install |
| --- | --- |
| **Oh My Zsh** | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| **Powerlevel10k** theme | `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k` |
| **zsh-autosuggestions** | Auto-cloned by `.zshrc` into `~/zsh-autosuggestions` on first run. |
| **zsh-syntax-highlighting** | `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting` |
| **web-search** | Bundled with Oh My Zsh (no install step). |


---

## Initial setup

### 1. Clone this repo

```bash
git clone https://github.com/chdrj/dotfiles.git ~/dotfiles
```

Stow expects the repo to live directly under your home directory (or
anywhere, as long as you pass the right `-d`), so `~/dotfiles` is the
simplest spot.

### 2. Back up anything you already have

Stow refuses to overwrite existing files. If you already have a
`.zshrc`, `~/.config/kitty/`, etc., move them aside first:

```bash
mkdir -p ~/dotfiles-backup
[ -f ~/.zshrc ] && mv ~/.zshrc ~/dotfiles-backup/
for d in aerospace borders fastfetch kitty sketchybar; do
  [ -e ~/.config/$d ] && mv ~/.config/$d ~/dotfiles-backup/
done
```

### 3. Stow the dotfiles

From `$HOME`, treat `dotfiles` as a single Stow package and link its
contents into `$HOME`:

```bash
stow -d ~ -t ~ dotfiles
```

What this does:

- `-d ~` — look for packages inside `~` (so it sees the `dotfiles`
  directory as a package).
- `-t ~` — create the symlinks inside `~`.
- `dotfiles` — the package name (the subdirectory).

Result:

```
~/.zshrc                 -> ~/dotfiles/.zshrc
~/.config/aerospace      -> ~/dotfiles/.config/aerospace
~/.config/borders        -> ~/dotfiles/.config/borders
~/.config/fastfetch      -> ~/dotfiles/.config/fastfetch
~/.config/kitty          -> ~/dotfiles/.config/kitty
~/.config/sketchybar     -> ~/dotfiles/.config/sketchybar
```

Stow uses *tree folding* — if `~/.config` already exists it descends
into it and links individual subdirectories instead of replacing the
whole thing.

**Dry run first** to see exactly what stow will do without changing
anything:

```bash
stow -d ~ -t ~ -n -v dotfiles
```

**Remove the symlinks** at any time with:

```bash
stow -d ~ -t ~ -D dotfiles
```

### 4. Start the services

```bash
# AeroSpace — will also run at login thanks to start-at-login = true
open -a AeroSpace

# SketchyBar as a launchd service (keeps it running and auto-starts on login)
brew services start sketchybar
```

Borders does not need a service — AeroSpace launches it from
`after-startup-command` inside `aerospace.toml`.

### 5. Reload your shell

```bash
exec zsh
```

On first run, `.zshrc` will clone `zsh-autosuggestions` for you and
print `installing zsh-autosuggestions ...`. That's expected.

### 6. (Optional) Configure Powerlevel10k

```bash
p10k configure
```

The prompt wizard writes `~/.p10k.zsh`, which is then sourced by
`.zshrc`. That file is intentionally **not** tracked here so your prompt
stays personal.

---

## Day-to-day commands

- **Reload SketchyBar** after editing any of its files:
  `sketchybar --reload`
- **Reload AeroSpace** after editing `aerospace.toml`:
  `aerospace reload-config` (or press `alt+shift+;` to enter service
  mode, then `esc`).
- **Reload zsh** after editing `.zshrc`: `sourcezs` (alias) or
  `exec zsh`.
- **Edit zshrc**: `openzs` (alias for `nvim ~/.zshrc`).

---

## Design notes

A few things worth knowing if you plan to tweak this setup:

- **Memory widget** (`sketchybar/plugins/memory.sh`) replicates the
  exact formula used by fastfetch / Activity Monitor
  (`total − (free − speculative + file_backed) × page_size`) in a single
  `vm_stat | awk` pipeline. Page size is parsed from the `vm_stat`
  header, so the plugin works unchanged on both Apple Silicon (16 KiB
  pages) and Intel (4 KiB pages). Refresh rate: 30 s.
- **Clock** is fully event-driven. `plugins/clock_updater.sh` runs in
  the background, sleeps until the next minute boundary, then fires a
  custom `clock_update` event that the `clock` item is subscribed to.
  The runner is killed and re-spawned by `sketchybarrc` on every
  reload, so there's never more than one instance alive.
- **Workspace → monitor** assignment lives inside `sketchybarrc` (the
  `for monitor in … for sid …` loop). Workspaces 8–10 are pinned to
  display 2, everything else to display 1. Edit that block to match
  your own monitor layout.
- **Theme** uses a blue-ish SketchyBar palette (`colors.sh`) + Tokyo
  Night Moon in Kitty. Swap themes by uncommenting a different
  `BAR_COLOR`/`ITEM_BG_COLOR`/`ACCENT_COLOR` block in
  `.config/sketchybar/colors.sh`.

---

## Credits

- <https://github.com/nikitabobko/AeroSpace>
- <https://github.com/FelixKratz/SketchyBar>
- <https://github.com/FelixKratz/JankyBorders>
- <https://github.com/kvndrsslr/sketchybar-app-font>
- <https://github.com/folke/tokyonight.nvim> (Kitty theme)
- <https://github.com/romkatv/powerlevel10k>
- <https://github.com/fastfetch-cli/fastfetch>
