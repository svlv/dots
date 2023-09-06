#!/bin/bash

# Hide warning message on Mac
export BASH_SILENCE_DEPRECATION_WARNING=1
[ -d /opt/homebrew/bin ] && export PATH=/opt/homebrew/bin:$PATH

[ -f ${HOME}/.bashrc ] && . ${HOME}/.bashrc

[ -f ${HOME}/.priv_environment ] && . ${HOME}/.priv_environment

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export WM="awesome"

export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads;m:/mnt"
export NNN_TMPFILE=$HOME/.config/nnn/.lastd

export PATH="$HOME/.local/bin/statusbar:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# X11 autostart with login on vt1
[ -z "${DISPLAY}" ] && [ "${XDG_VTNR-0}" -eq 1 ] && exec startx ~/.xinitrc "${WM}"
