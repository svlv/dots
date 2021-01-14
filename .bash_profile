#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="nvim"
export TERMINAL="termite"

export PATH="$HOME/.cargo/bin:$PATH"

[[ $(tty) == "/dev/tty1" ]] && startx

