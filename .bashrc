#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases
[ -f "${HOME}/.config/shell/aliases" ] && source "${HOME}/.config/shell/aliases"

# Load utils
[ -f "${HOME}/.config/shell/utils" ] && source "${HOME}/.config/shell/utils"

# configure history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Sets readline variables
insert_line() {
     READLINE_LINE=${1}
     READLINE_POINT=${#1}
}
bind '"\C-N":"ninja\C-m"'

COLOR1="\033[38;5;14m"
COLOR2="\033[38;5;1m"
COLOR3="\033[38;5;3m"
COLOR4="\033[38;5;13m"
RESET="\033[00m"
PS1="\
\[${COLOR1}\][\
\[${COLOR4}\]\$(get_time) \
\[${COLOR1}\]\u@\h \
\[${COLOR2}\]\w\
\[${COLOR3}\]\$(git_branch)\
\[${COLOR1}\]]\n\$\
\[${RESET}\] "

PROMPT_COMMAND='echo -ne "\033]0;${TERM}\007"'

# Load fzf completion
[ -f "/usr/share/fzf/completion.bash" ] && source /usr/share/fzf/completion.bash
[ -f "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash

set -o emacs # enable vi mode

