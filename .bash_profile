#!/bin/bash

#[[ -f $HOME/.config/shell/utils ]] && . $HOME/.config/shell/utils
#[[ -f $HOME/.config/shell/aliases ]] && . $HOME/.config/shell/aliases

[ -f ~/.bashrc ] && . ~/.bashrc

[ -f ~/.priv_environment ] && . ~/.priv_environment

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export WM="awesome"
export MANPAGER="nvim -c 'set ft=man' -"

export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads;m:/mnt"
export NNN_TMPFILE=$HOME/.config/nnn/.lastd

export PATH="$HOME/.local/bin/statusbar:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

[ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && exec startx ~/.xinitrc "${WM}"

