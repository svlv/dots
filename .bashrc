#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load utils
[ -f "${HOME}/.config/shell/utils" ] && source "${HOME}/.config/shell/utils"

# Load aliases
source_if_exists ${HOME}/.config/shell/aliases

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
# Currently it is not used anywhere
insert_line() {
     READLINE_LINE=${1}
     READLINE_POINT=${#1}
}

# Bind Ctrl-N to call ninja
bind '"\C-N":"ninja\C-m"'

# Set colorful bash prompt in the folowing way:
#     [time name@host ~ branch]
#     $
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

# The content of PROMPT_COMMAND is executed as a bash command
# just before bash displays a prompt. Here Operating System Command
# is used to set the window title
PROMPT_COMMAND='echo -ne "\033]0;${TERM}\007"'

# Load completions
source_if_exists /usr/share/fzf/completion.bash
source_if_exists /usr/share/fzf/key-bindings.bash
source_if_exists /usr/share/bash-completion/completions/pass

# Custom completions:
complete -W 'user1@host1 user2@host2' ssh

set -o emacs # enable vi mode

