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

link_file_ret()
{
	if [ ! -f "$2" ]; then ln -s "$PWD/$1" "$2"; return 0; else return 1; fi;
}
link_dir_ret()
{
	if [ ! -d "$2" ]; then ln -s "$PWD/$1" "$2"; return 0; else return 1; fi;
}

SHARE="$HOME/.local/share"
UCONFIG="$HOME/.config"

FONTS="$SHARE/fonts"
WALLPAPERS="$SHARE/wallpapers"
ICONS="$SHARE/icons"
QT_COLORS="$SHARE/color-schemes"

mkdir -p $FONTS
mkdir -p $WALLPAPERS
mkdir =p $ICONS
mkdir -p $QT_COLORS

llinking zshrc
link_file zshrc "$HOME/.zshrc"

llinking "Hyprland config"
link_dir hypr "$UCONFIG/hypr"

llinking "Waybar config"
link_dir waybar "$UCONFIG/waybar"

llinking "NeoVim config"
link_dir nvim "$UCONFIG/nvim"

llinking "Dolphin config"
link_file dolphinrc "$UCONFIG/dolphinrc"

llinking "Kitty config"
link_dir kitty "$UCONFIG/kitty"

llinking "XDG-Mime config"
link_file mimeapps.list "$UCONFIG/mimeapps.list"

llinking "GTK3 theme"
link_dir theme/gtk "$UCONFIG/gtk-3.0"

llinking "GTK4 theme"
link_dir theme/gtk "$UCONFIG/gtk-4.0"

llinking "Qt color scheme"
link_file theme/sct_krita_darker.colors "$QT_COLORS/sct_krita_darker.colors"

llinking "Hack Nerd Font"
link_dir fonts/Hack "$FONTS/Hack"

linstaling "Wallpapers"
link_file_ret "wallpapers/morian_224_013.png" \
		"$WALLPAPERS/morian_224_013.png" && \
	link_dir_ret "wallpapers/Next" "$WALLPAPERS/Next" && ldone \
	|| lskip

linstaling "Cursor"
link_dir "icons/cz-Hickson-Black" "$ICONS/cz-Hickson-Black"

fc-cache -f -v
