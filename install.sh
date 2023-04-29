#!/usr/bin/sh

. ./log.sh

link_file() { if [ ! -f $2 ]; then ln -s $PWD/$1 $2; ldone; else lskip; fi; }
link_dir()  { if [ ! -d $2 ]; then ln -s $PWD/$1 $2; ldone; else lskip; fi; }

llinking zshrc
link_file zshrc $HOME/.zshrc

llinking "P10K theme"
link_file p10k.normal.zsh $HOME/.p10k.normal.zsh

llinking "P10K theme for TTY"
link_file p10k.tty.zsh $HOME/.p10k.tty.zsh

llinking "Doom Emacs config"
if [ ! -d $HOME/.doom.d ]
then
    ln -s $PWD/doom_emacs $HOME/.doom.d
    if [ -d $HOME/.emacs.d ]
    then
        lupdating "Doom Emacs"
        $HOME/.emacs.d/bin/doom sync
    else
        linstaling "Doom Emacs"
        git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.emacs.d
        $HOME/.emacs.d/bin/doom install
    fi
    ldone
else
    lskip
fi
