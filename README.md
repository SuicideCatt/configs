# My configurations for zsh and Doom Emacs

For install on Arch based systems:
```sh
# pacman -Sy zsh-completions zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting pkgfile git zsh emacs
# pkgfile -u
$ git clone https://github.com/SuicideCatt/configs ~/.config/sct_config
$ cd ~/.config/sct_config
$ ./install.sh
$ chsh /usr/bin/zsh
```
For upgrade:
```sh
$ sct_cfg_upgrade
```
