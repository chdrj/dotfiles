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

eval "$(starship init zsh)"

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

# fzf: shell integration (key bindings + completion) + gruvbox palette
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

source $ZSH/oh-my-zsh.sh

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.local/bin:$PATH"

# Added by Windsurf
export PATH="/Users/choidorjbayarkhuu/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"

# opencode
export PATH=/Users/choidorjbayarkhuu/.opencode/bin:$PATH
