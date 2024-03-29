#!/usr/bin/bash

. ./log.sh

link_file()
{
	if [ ! -f "$2" ]; then ln -s "$PWD/$1" "$2"; ldone; else lskip; fi;
}
link_dir()
{
	if [ ! -d "$2" ]; then ln -s "$PWD/$1" "$2"; ldone; else lskip; fi;
}

llinking zshrc
link_file zshrc "$HOME/.zshrc"

llinking "P10K theme"
link_file p10k.normal.zsh "$HOME/.p10k.normal.zsh"

llinking "P10K theme for TTY"
link_file p10k.tty.zsh "$HOME/.p10k.tty.zsh"

llinking "LunarVim config"
if [ ! -d "$HOME/.config/lvim" ]
then
	ln -s "$PWD/lvim" "$HOME/.config/lvim"
	if [ ! -f "$HOME/.local/bin/lvim" ]
	then
		linstaling "LunarVim"
		export LV_BRANCH="release-1.3/neovim-0.9"
		export LV_URL_BEG="https://raw.githubusercontent.com/LunarVim/LunarVim"
		export LV_URL_END="utils/installer/install.sh"
		export LV_INSTALLER="$LV_URL_BEG/$LV_BRANCH/$LV_URL_END"
		bash <(curl -s "$LV_INSTALLER")
	fi

	export FONTS="$HOME/.local/share/fonts"
	if [ ! -d "$FONTS/Hack" ];
	then
		llinking "Hack Nerd Font"
		if [ ! -d "$FONTS" ];
		then
			mkdir -p "$FONTS"
		fi
		ln -s "$PWD/fonts/Hack" "$FONTS/Hack"
		fc-cache -f -v
	fi

	ldone
else
	lskip
fi
