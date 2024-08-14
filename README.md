# My configurations

For install on Arch based systems:
```sh
sudo pacman -Sy zsh-completions \
	zsh-autosuggestions zsh-syntax-highlighting pkgfile \
	git zsh neovim python python-pynvim \
	qt5ct qt6ct \
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
- Next - KDE Plasma 6 Default
- morian\_224\_013.png - IDK

Cursor
- cz-Hickson-Black
