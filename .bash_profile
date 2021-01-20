#!/bin/bash

[ -f ~/.bashrc ] && . ~/.bashrc

[ -f ~/.priv_environment ] && . ~/.priv_environment

export EDITOR="nvim"
export TERMINAL="termite"
export BROWSER="google-chrome-stable"
export WM="awesome"

export PATH="$HOME/.cargo/bin:$PATH"

[ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && exec startx ~/.xinitrc "${WM}"

