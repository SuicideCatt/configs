# My configurations for zsh and LunarVim

For install on Arch based systems:
```sh
sudo pacman -Sy zsh-completions \
    zsh-autosuggestions zsh-syntax-highlighting pkgfile \
    git zsh npm xclip neovim python python-pynvim \
    hyprland waybar wofi hyprlock hyprpaper hypridle \
    xdg-desktop-portal-hyprland wl-clipboard lua-language-server clang
yay -S hyprshot hyprpicker glsl_analyzer cmake-language-server
sudo pkgfile -u
git clone https://github.com/SuicideCatt/configs ~/.config/sct_config
cd ~/.config/sct_config
./install.sh
chsh -s /usr/bin/zsh
```

For upgrade:
```sh
$ sct_cfg_update
```
