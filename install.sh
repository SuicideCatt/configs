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

THEME_ENGINE="minimal.zsh"
if [ ! -f "./minimal.zsh" ]
then
	linstaling "subnixr/minimal"
	URL="https://raw.githubusercontent.com/subnixr/minimal/master/minimal.zsh"
	curl "$URL" -o "$THEME_ENGINE"
fi

llinking "Hyprland"
link_dir hypr "$HOME/.config/hypr"

llinking "Waybar"
link_dir waybar "$HOME/.config/waybar"

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
	if [ ! -d "$FONTS/Hack" ]
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
