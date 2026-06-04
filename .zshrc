# If not in tmux, start tmux: reads from and writes to the TTY.
# if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
#   exec tmux
# fi

# Auto-install zsh-autosuggestions into the Oh My Zsh custom plugins dir on first run.
if [[ ! -e $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  print -r -- 'installing zsh-autosuggestions ...'
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Keep $PATH free of duplicates — this file gets re-sourced (e.g. `exec zsh`)
# and every tool below prepends. `path` is the array tied to $PATH; -U dedupes.
typeset -U path PATH

plugins=(
git 
zsh-autosuggestions 
zsh-syntax-highlighting 
web-search
)

#Aliases

#zsh
alias openzs="nvim ~/.zshrc"
alias sourcezs="source ~/.zshrc"

# bat: use the gruvbox theme to match kitty
export BAT_THEME="gruvbox-dark"

# Custom scripts live in ~/dotfiles/bin
export PATH="$HOME/dotfiles/bin:$PATH"

# zoxide: smart `cd` that learns your habits
# `z some-substring` jumps to the most-visited matching directory
# `zi` opens an interactive fzf picker over your frecency list
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Ctrl-f → tmux sessionizer (also bound to prefix+f inside tmux)
if command -v tmux-sessionizer >/dev/null 2>&1; then
  bindkey -s '^f' 'tmux-sessionizer\n'
fi

source $ZSH/oh-my-zsh.sh

# Starship prompt — initialized AFTER oh-my-zsh so it reliably owns the prompt
# regardless of any OMZ theme (OMZ would otherwise clobber it if ZSH_THEME is set).
eval "$(starship init zsh)"

# fzf: shell integration (key bindings + completion) + gruvbox palette.
# Sourced after oh-my-zsh so its ^T / ^R / Alt-C bindings aren't clobbered.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS="
    --height 60% --layout=reverse --border=rounded
    --color=bg+:#3c3836,bg:#282828,spinner:#fabd2f,hl:#83a598
    --color=fg:#ebdbb2,header:#83a598,info:#8ec07c,pointer:#fabd2f
    --color=marker:#fb4934,fg+:#ebdbb2,prompt:#fabd2f,hl+:#fb4934"
  # Use fd/eza for previews when available
  command -v fd >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:300 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --color=always {} | head -100'"
fi

# Aliases for eza + bat + lazygit
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -lh --icons --git --group-directories-first"
alias la="eza -lah --icons --git --group-directories-first"
alias lt="eza --tree --level=2 --icons --git"
alias cat="bat --paging=never"
alias lg="lazygit"

# btop: pretty system monitor (gruvbox theme via ~/.config/btop/btop.conf)
alias top="btop"

# yazi: terminal file manager. `yy` exits to the directory you last navigated
# to (the bare `yazi` command leaves you in your original cwd on quit).
if command -v yazi >/dev/null 2>&1; then
  function yy() {
    local tmp cwd
    tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# gh: GitHub CLI shortcuts
if command -v gh >/dev/null 2>&1; then
  alias ghpr="gh pr create --web"
  alias ghprs="gh pr status"
  alias ghv="gh repo view --web"
  alias ghrun="gh run watch"
fi

[ -f "/Users/choidorjbayarkhuu/.ghcup/env" ] && . "/Users/choidorjbayarkhuu/.ghcup/env" # ghcup-env

# Added by Antigravity
export PATH="/Users/choidorjbayarkhuu/.antigravity/antigravity/bin:$PATH"

# conda: lazy-loaded. The eager `conda shell.zsh hook` costs ~0.5s at EVERY
# shell startup (it spawns Python), and base doesn't auto-activate — so there's
# no reason to pay that up front. This stub runs the real init the first time
# you call `conda`, replaces itself, then re-runs your command.
#
# NOTE: the `# >>> conda initialize >>>` managed markers were removed on purpose.
# If you ever run `conda init zsh` again it will append a fresh eager block —
# just delete that block and keep this function.
conda() {
  unfunction conda
  __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  elif [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/opt/homebrew/anaconda3/bin:$PATH"
  fi
  unset __conda_setup
  conda "$@"
}

export PATH="$HOME/.local/bin:$PATH"

# Added by Windsurf
export PATH="/Users/choidorjbayarkhuu/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"

# opencode
export PATH=/Users/choidorjbayarkhuu/.opencode/bin:$PATH
