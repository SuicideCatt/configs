autoload -U compinit

path+=("$HOME/.local/bin")

compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
setopt completealiases

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=25000
setopt sharehistory
setopt histignoredups

# Theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
if [ "${$(tty):0:8}" = "/dev/tty" ]
then
 	source ~/.p10k.tty.zsh;
else
 	source ~/.p10k.normal.zsh;
fi

# Plugins
ZSH_PLUGINS=/usr/share/zsh/plugins
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Dirs
setopt AUTO_PUSHD
setopt auto_cd

# Config
CONFIG_DIRECTORY=$(dirname $(readlink -f $HOME/.zshrc))

sct_launch_in_cfg_dir()
{
	OLD_DIR=$(pwd)
	cd $CONFIG_DIRECTORY
	$1
	cd $OLD_DIR
}

alias sct_cfg_update="sct_launch_in_cfg_dir \"./update.sh\""
alias sct_lvim_in_cfg_dir="sct_launch_in_cfg_dir lvim"
alias sct_zsh_in_cfg_dir="sct_launch_in_cfg_dir zsh"

# ZSH
ZSH_CONFIG=$CONFIG_DIRECTORY/zshrc
alias zsh_cfg_reload=". $ZSH_CONFIG"
alias zsh_cfg_edit="lvim $ZSH_CONFIG"

# Other
alias prt_get_editorconfig="cp $CONFIG_DIRECTORY/editorconfig .editorconfig"

# Alias's
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
