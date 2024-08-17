#!/usr/bin/bash

echo "Specific configs: pc laptop"
printf "Select specific config: "
read CFG

./select.sh $CFG

./install.sh

gsettings set org.gnome.desktop.interface gtk-theme CatppuccinMacchiatoMauve
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

chch -s /usr/bin/zsh
