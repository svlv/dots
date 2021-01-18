#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="nvim"
export TERMINAL="termite"
export BROWSER="google-chrome-stable"

export PATH="$HOME/.cargo/bin:$PATH"

[[ $(tty) == "/dev/tty1" ]] && startx

