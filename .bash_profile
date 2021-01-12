#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

if [[ $(tty) == "/dev/tty1" ]]; then
  startx
fi

