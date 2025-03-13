# My configurations

For install on Arch based systems:
```sh
sudo pacman -Sy zsh-completions \
	zsh-autosuggestions zsh-syntax-highlighting pkgfile \
	git zsh neovim python-gobject python-pynvim \
	qt5ct qt6ct glib2 \
	hyprland waybar wofi hyprlock hyprpaper hypridle \
	xdg-desktop-portal-hyprland wl-clipboard kitty pcmanfm-qt swaync \
	lua-language-server clang
yay -S hyprshot hyprpicker glsl_analyzer cmake-language-server
sudo pkgfile -u
git clone https://github.com/SuicideCatt/configs ~/.config/sct_config
cd ~/.config/sct_config
./first_install.sh
chsh -s /usr/bin/zsh
```

For upgrade:
```sh
sct_cfg_update
```

Wallpapers
- [Next](https://invent.kde.org/plasma/breeze/tree/Plasma/6.1/wallpapers/Next)
- morian\_224\_013.png - IDK, Hakurei Reimu from TouHou Project

Cursor
- [cz-Hickson-Black](https://github.com/charakterziffer/cursor-toolbox)

Icons
- [Papirus icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) generated on [oomox](https://github.com/themix-project)

Themes
- Qt: Krita Darker theme but NO BLUE COLOR
- GTK: Wery bad(maybe) port of a Qt theme on [oomox](https://github.com/themix-project)
- ZSH: [subnixr/minimal](https://github.com/subnixr/minimal)
