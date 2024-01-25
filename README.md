# My configurations for zsh and Doom Emacs

For install on Arch based systems:
```sh
sudo pacman -Sy zsh-completions zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting pkgfile git zsh nvim python python-pynvim
yay -S glsl_analyzer 
sudo pkgfile -u
git clone https://github.com/SuicideCatt/configs ~/.config/sct_config
cd ~/.config/sct_config
./install.sh
chsh /usr/bin/zsh
```
For upgrade:
```sh
$ sct_cfg_upgrade
```
