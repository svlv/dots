#!/bin/bash

# Hide warning message on Mac
# https://apple.stackexchange.com/questions/371997/suppressing-the-default-interactive-shell-is-now-zsh-message-in-macos-catalina
export BASH_SILENCE_DEPRECATION_WARNING=1

# Update PATH for macOS
[ -d /opt/homebrew/bin ] && export PATH=$PATH:/opt/homebrew/bin
[ -d /opt/local/bin ] && export PATH=$PATH:/opt/local/bin

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export EDITOR="nvim"
export TERMINAL="alacritty"
export WM="awesome"

for browser in brave google-chrome-stable; do
    if command -v ${browser} 2>&1 >/dev/null; then
        export BROWSER=${browser}
        break
    fi
done

export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads;m:/mnt"
export NNN_TMPFILE=$HOME/.config/nnn/.lastd

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/statusbar:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

[ -f ${HOME}/.bashrc ] && . ${HOME}/.bashrc

# X11 autostart with login on vt1
[ -z "${DISPLAY}" ] && [ "${XDG_VTNR-0}" -eq 1 ] && \
    exec startx ~/.xinitrc "${WM}"
