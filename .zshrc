# If not in tmux, start tmux: reads from and writes to the TTY.
#if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
  #exec tmux
#fi

# Clone git repos that don't exist: prints and may take unpredictably long time to execute.
if [[ ! -e ~/zsh-autosuggestions ]]; then
  print -r -- 'installing zsh-autosuggestions ...'
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/zsh-autosuggestions
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

#Python 3.11 PATH
export PATH="/opt/homebrew/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

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
# Override the 'clear' command to always show fastfetch at the top
# alias clear="clear && fastfetch"

# Modern CLI replacements (eza, bat, lazygit)
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -lh --icons --git --group-directories-first"
alias la="eza -lah --icons --git --group-directories-first"
alias lt="eza --tree --level=2 --icons --git"
alias cat="bat --paging=never"
alias lg="lazygit"

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

[ -f "/Users/choidorjbayarkhuu/.ghcup/env" ] && . "/Users/choidorjbayarkhuu/.ghcup/env" # ghcup-env

#prompt_context() {
  #if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    #prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"

  #fi
#}


# Added by Antigravity
export PATH="/Users/choidorjbayarkhuu/.antigravity/antigravity/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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


export PATH=$PATH:/Users/choidorjbayarkhuu/.spicetify

export PATH="$HOME/.local/bin:$PATH"

fastfetch

# Added by Windsurf
export PATH="/Users/choidorjbayarkhuu/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"

# opencode
export PATH=/Users/choidorjbayarkhuu/.opencode/bin:$PATH
