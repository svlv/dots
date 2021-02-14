#!/bin/bash

[ -f ~/.bashrc ] && . ~/.bashrc

[ -f ~/.priv_environment ] && . ~/.priv_environment

export XDG_CONFIG_HOME="$HOME/.config"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export EDITOR="nvim"
export TERMINAL="termite"
export BROWSER="google-chrome-stable"
export WM="awesome"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

[ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && exec startx ~/.xinitrc "${WM}"

