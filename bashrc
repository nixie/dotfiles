# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export EDITOR="vim"

[ -z "$DISPLAY" ] || export TERM=rxvt-color

export GREP_COLOR="1;33"
export LANG=en_US.utf8
export PAGER=most
export PATH=$PATH:/usr/local/bin:/home/collodi/fit/fitkit/Xilinx/ISE/bin/lin

# lincense file for modelSIM
export LM_LICENSE_FILE=/home/collodi/fit/fitkit/modelsim/license.dat

# database files for cscope for linux
export CSCOPE_DB=/home/collodi/.cscope/linux/


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# for every file in curr. dir print filename and its contents
. /etc/rc.conf
. /etc/rc.d/functions

cata(){
   for i in `ls`; do
      printf "${C_BUSY}file: ${C_OTHER}$i${C_CLEAR} (`wc -l $i | cut -d' ' -f1`L)\n"
      cat $i
      echo
   done
}


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color)
	color_prompt=yes;;
	rxvt-unicode)
	color_prompt=yes;;
   xterm-256color)
   color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

#'\[\e[1;33m\]ahoj\[\e[m\]'
if [ "$color_prompt" = yes ]; then
	PS1='\[\e[0;38m\][\u@\H\[\e[m\] \[\e[0;33m\]\w\[\e[m\]\[\e[m\]\[\e[0;32m\]]\$\[\e[m\] '
else
	PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# set PS1, last exit code if != 0, and PWD, with colors
#PRE='\[\033['
#POST='m\]'
#COL_LASTEXIT="${PRE}01;41;37${POST}" # last command exit value
#COL_PWD="${PRE}00;01;36${POST}" # current directory
#COL_DEFAULT="${PRE}00${POST}" # back to default colors
#export PS1="$COL_LASTEXIT\${?#0}$COL_PWD \w$COL_DEFAULT\\n\\\$ "

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#   PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# set PATH so it includes user's scripts if it exists
if [ -d "$HOME/scripts" ] ; then
	PATH="$PATH:$HOME/scripts"
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# .cfg because of syntax highlighting in vim :)
if [ -f ~/.bash_aliases.cfg ]; then
    . ~/.bash_aliases.cfg
fi



# variables for avrlib
if [ -d "$HOME/avr/avrlib" ] ; then
	export AVRLIB="/home/collodi/avr/avrlib"
fi

if [ -d "/usr/avr" ] ; then
	export AVR="/usr/avr" 
fi

# show return value of previous command
#export PROMPT_COMMAND='RET=$?; if [[ $RET != 0 ]]; then echo -ne "\033[0;31m$RET\033[0m"; fi; echo -n'

function prompt {
  local BLUE="\[\033[0;34m\]"
  local DARK_BLUE="\[\033[1;34m\]"
  local RED="\[\033[0;31m\]"
  local DARK_RED="\[\033[1;31m\]"
  local NO_COLOR="\[\033[0m\]"
  case $TERM in
    xterm*|rxvt*)
      TITLEBAR='\[\033]0;\u@\h:\w\007\]'
      ;;
    *)
      TITLEBAR=""
      ;;
  esac
  PS1="\u@\h [\t]> "
  PS1="${TITLEBAR}\
  $BLUE\u@\h $RED[\t]>$NO_COLOR "
  PS2='continue-> '
  PS4='$0.$LINENO+ '
}
