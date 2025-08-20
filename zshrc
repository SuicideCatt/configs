autoload -U compinit

path+=("$HOME/.local/bin")

compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
setopt completealiases

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=25000
setopt sharehistory
setopt histignoredups

# Plugins
ZSH_PLUGINS="/usr/share/zsh/plugins"
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/doc/pkgfile/command-not-found.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Dirs
setopt AUTO_PUSHD
setopt auto_cd

# Config
CONFIG_DIRECTORY="$(dirname $(readlink -f $HOME/.zshrc))"

# Theme
source "$CONFIG_DIRECTORY/minimal.zsh"
if [ "${$(tty):0:8}" = "/dev/tty" ]
then
	source "$CONFIG_DIRECTORY/theme.tty.zsh";
else
	source "$CONFIG_DIRECTORY/theme.normal.zsh";
fi

sct_launch_in_cfg_dir()
{
	OLD_DIR="$(pwd)"
	cd "$CONFIG_DIRECTORY"
	"$1"
	cd "$OLD_DIR"
}

alias sct_cfg_update="sct_launch_in_cfg_dir \"./update.sh\""
alias sct_nvim_in_cfg_dir="sct_launch_in_cfg_dir nvim"
alias sct_zsh_in_cfg_dir="sct_launch_in_cfg_dir zsh"

# ZSH
ZSH_CONFIG="$CONFIG_DIRECTORY/zshrc"
alias zsh_cfg_reload=". $ZSH_CONFIG"
alias zsh_cfg_edit="nvim $ZSH_CONFIG"

send_hyprnotify()
{
	hyprctl notify 3 5000 0 "$1" > /dev/null
}

# Other
alias prt_get_editorconfig="cp $CONFIG_DIRECTORY/.editorconfig ."

prt_mk_build()
{
	PRT="$(pwd)/build"
	TMP="/tmp/builds/${PWD##*/}"

	source "$CONFIG_DIRECTORY/log.sh"

	lstatus "Creating $TMP"
	if [ ! -d "/tmp/builds/${PWD##*/}" ]
	then
		mkdir -p "/tmp/builds/${PWD##*/}"
		ldone
	else
		rm -rf "$TMP/"
		mkdir -p "/tmp/builds/${PWD##*/}"
		printf "Already created, cache deleted\n"
	fi

	llinking "$PRT"
	if [ ! -d "$(pwd)/build" ]
	then
		ln -s "$TMP" "$PRT"
		ldone
	else
		lskip
	fi

	zmodload zsh/zutil
	zparseopts -D -F -E - \
		cmake:=io_cmake

	if [ ! $#io_cmake = 0 ]
	then
		case "${io_cmake[-1]##*=}" in
			d)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Debug \
					-DCMAKE_EXPORT_COMPILE_COMMANDS=YES -G "Unix Makefiles"
			;;
			dt)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Debug \
					-DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DTESTS=ON \
					-G "Unix Makefiles"
			;;
			r)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Release \
					-G "Unix Makefiles"
			;;
			*)
				echo "d or r"
				return 1
			;;
		esac
	fi
}

prt_rm_build()
{
	PRT="$(pwd)/build"
	TMP="/tmp/builds/${PWD##*/}"

	if [ -d "$(pwd)/build" ]
	then
		rm -rf "$PRT"
	fi

	if [ -d "/tmp/builds/${PWD##*/}" ]
	then
		rm -rf "$TMP"
	fi
}

prt_build()
{
	PRT="$(pwd)/build"
	TMP="/tmp/builds/${PWD##*/}"

	zmodload zsh/zutil
	zparseopts -D -F -E - \
		cmake=io_cmake \
		no_mt=io_no_mt

	if [ ! $#io_no_mt = 0 ]
	then
		THREADS=1
	else
		THREADS="$(nproc)"
	fi

	if [ ! $#io_cmake = 0 ]
	then
		cmake --build "$PRT" -- "-j$THREADS"
	else
		./build.sh -b "$PRT" -j "$THREADS"
	fi

	BR=$?
	if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]
	then
		if [ "$BR" -ne 0 ]
		then
			send_hyprnotify "Build failed!" > /dev/null
		else
			send_hyprnotify "Build complete!" > /dev/null
		fi
	fi

	return "$BR"
}

alias find_in_history='cat ~/.zsh_history | grep'

alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
