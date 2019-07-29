export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git vi-mode zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

bindkey -v

# User configs

DEFAULT_USER=`whoami`

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
