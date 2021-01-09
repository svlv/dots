# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# configure history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# sets readline variables
insert_line() {
     READLINE_LINE=${1}
     READLINE_POINT=${#1}
}
bind -x '"\C-N": insert_line "ninja run_tests"'

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Returns git or mercurial branch
git_branch() {
  branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
  if [ -z "${branch}" ]; then
    branch=$(hg branch 2>/dev/null)
  fi

  if [ -z "${branch}" ]; then
    echo ""
  else
    echo " ${branch}"
  fi
}

COLOR1="\033[38;5;14m"
COLOR2="\033[38;5;1m"
COLOR3="\033[38;5;3m"
RESET="\033[00m"
PS1="\
\[${COLOR1}\][\u@\h \
\[${COLOR2}\]\w\
\[${COLOR3}\]\$(git_branch)\
\[${COLOR1}\]]\$\
\[${RESET}\] "

set_title() {
  echo -ne "\033]0;${TERM}\007"
}
PROMPT_COMMAND=set_title

# load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#set -o vi # enable vi mode

