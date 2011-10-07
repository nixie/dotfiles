# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000


setopt autocd extendedglob
#bindkey -v
# End of lines configured by zsh-newuser-install

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-keymap-select
setopt prompt_subst

RED='\e[0;31m'
GREEN='\e[0;32m'

PROMPT="%? %B%~> %b"

#RPS1='%B%@ %l%b%S${VIMODE}%s'

autoload -U compinit
compinit

setopt CORRECTALL
setopt NO_LIST_AMBIGUOUS

source ~/.bash_aliases.cfg

export PYTHONPATH=${PYTHONPATH}:/home/collodi/fit/speech@fit/rrslib
export PATH=$PATH:/mnt/external_hdd2/matlab/bin

export PATH="/usr/lib/colorgcc/bin:$PATH"

bindkey "^R" history-incremental-search-backward

bindkey "^[[3~" delete-char
bindkey "^[3;5~"    delete-char

bindkey -e

export SVN_SSH="ssh -q -i $HOME/.ssh/svn_key"
export PAGER=most
export EDITOR="vim"
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

eval `keychain --quiet --eval --agents ssh id_rsa svn_key`
