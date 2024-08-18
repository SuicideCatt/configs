#!/usr/bin/bash

echo "Specific configs: pc laptop"
printf "Select specific config: "
read CFG

./select.sh $CFG

./install.sh

gsettings set org.gnome.desktop.interface gtk-theme oomox-sct_krita_darker
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface icon-theme oomox-sct_papirus

chch -s /usr/bin/zsh
