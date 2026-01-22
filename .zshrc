# If not in tmux, start tmux: reads from and writes to the TTY.
#if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
  #exec tmux
#fi

# Clone git repos that don't exist: prints and may take unpredictably long time to execute.
if [[ ! -e ~/zsh-autosuggestions ]]; then
  print -r -- 'installing zsh-autosuggestions ...'
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/zsh-autosuggestions
fi

# Prints.
cowsay -f sus "Hello Choidorj"

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

