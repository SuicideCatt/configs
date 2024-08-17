# My configurations

For install on Arch based systems:
```sh
sudo pacman -Sy zsh-completions \
	zsh-autosuggestions zsh-syntax-highlighting pkgfile \
	git zsh neovim python-gobject python-pynvim \
	qt5ct qt6ct glib2 \
	hyprland waybar wofi hyprlock hyprpaper hypridle \
	xdg-desktop-portal-hyprland wl-clipboard kitty swaync \
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

Themes
- [Catppuccin GTK](https://github.com/catppuccin/gtk)
- [Catppuccin qtXct](https://github.com/catppuccin/qt5ct)
