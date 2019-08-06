export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

DEFAULT_USER=`whoami`

# vim-like command line keybinds
bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# enable backwards tab completion on Shift-TAB
bindkey '^[[Z' reverse-menu-complete

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# make vim the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# dotfiles versioning
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
eval 'config config status.showUntrackedFiles no'

# ls colors
eval `dircolors ~/.dir_colors/dircolors`

# python virtual env config
VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
if [ -f $VIRTUALENVWRAPPER_SCRIPT ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export WORKON_HOME=~/.virtualenvs
    source $VIRTUALENVWRAPPER_SCRIPT
fi

# source local config if it exists
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
