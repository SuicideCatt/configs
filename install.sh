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
THEMES="$SHARE/themes"
QT_COLORS="$SHARE/color-schemes"

mkdir -p $FONTS
mkdir -p $WALLPAPERS
mkdir -p $ICONS
mkdir -p $THEMES
mkdir -p $QT_COLORS

llinking zshrc
link_file zshrc "$HOME/.zshrc"

llinking "Hyprland config"
link_dir hypr "$UCONFIG/hypr"

llinking "Waybar config"
link_dir waybar "$UCONFIG/waybar"

llinking "NeoVim config"
link_dir nvim "$UCONFIG/nvim"

llinking "PCManFM-QT config"
link_dir pcmanfm-qt "$UCONFIG/pcmanfm-qt"

llinking "Kitty config"
link_dir kitty "$UCONFIG/kitty"

llinking "XDG-Mime config"
link_file mimeapps.list "$UCONFIG/mimeapps.list"

llinking "GTK theme"
link_dir theme/oomox-sct_krita_darker "$THEMES/oomox-sct_krita_darker"

llinking "Icons theme"
link_dir theme/oomox-sct_papirus "$ICONS/oomox-sct_papirus"

llinking "Cursor"
link_dir theme/cz-Hickson-Black "$ICONS/cz-Hickson-Black"

llinking "qtXct config"
link_dir_ret theme/qtXct "$UCONFIG/qt5ct" && \
	link_dir_ret theme/qtXct "$UCONFIG/qt6ct" && ldone \
	|| lskip

llinking "Qt color scheme"
link_file theme/sct_krita_darker.colors "$QT_COLORS/sct_krita_darker.colors"

llinking "Hack Nerd Font"
link_dir fonts/Hack "$FONTS/Hack"

linstaling "Wallpapers"
link_file_ret "wallpapers/morian_224_013.png" \
		"$WALLPAPERS/morian_224_013.png" && \
	link_dir_ret "wallpapers/Next" "$WALLPAPERS/Next" && ldone \
	|| lskip

fc-cache -f -v
