#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

utils=$HOME/.config/shell/utils
[ -f $utils ] && source $utils

numlockx on &
picom &
nm-applet &

if ! am_i_resting_now; then
    for app in teams gpclient prospect-mail; do
        launch_if_exists $app
    done
fi

# Setting keyboard repeat rate
xset r rate 200 25

session="${1:awesome}"
case $session in
  awesome         ) exec awesome;;
  xmonad          ) exec xmonad;;
  *               ) exec $session;;
esac

