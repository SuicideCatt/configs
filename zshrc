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

EDITOR=nvim

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
	case "$1" in
		0)
		COLOR=33
		;;
		1)
		COLOR=36
		;;
		2)
		COLOR=2
		;;
		3)
		COLOR=31
		;;
		4)
		COLOR=35
		;;
		5)
		COLOR=32
		;;
		*)
		COLOR=39
		;;
	esac
	COLOR="\\x1b[$(echo $COLOR)m"
	CLEAR="\\x1b[0m"

	printf "$COLOR$2$CLEAR\n"

	if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]
	then
		hyprctl notify "$1" 5000 0 "$2" > /dev/null
	fi
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
		cmake:=io_cmake \
		cmake_gen:=iog_cmake \
		compl:=io_compl

	if [ ! $#io_cmake = 0 ]
	then
		GEN="Unix Makefiles"
		if [ ! $#iog_cmake = 0 ]
		then
			case "${iog_cmake[-1]##*=}" in
				make)
					GEN="Unix Makefiles"
				;;
				ninja)
					GEN="Ninja"
				;;
				*)
				;;
			esac
		fi

		export CC=/bin/gcc CXX=/bin/g++
		if [ ! $#io_compl = 0 ]
		then
			case "${io_compl[-1]##*=}" in
				gcc)
					export CC=/bin/gcc CXX=/bin/g++
				;;
				clang)
					export CC=/bin/clang CXX=/bin/clang++
				;;
				*)
				;;
			esac

		fi

		case "${io_cmake[-1]##*=}" in
			d)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Debug \
					-DCMAKE_EXPORT_COMPILE_COMMANDS=YES -G "$GEN"
			;;
			dt)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Debug \
					-DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DTESTS=ON -G "$GEN"
			;;
			r)
				cmake -S "$(pwd)" -B "$PRT" -DCMAKE_BUILD_TYPE=Release -G "$GEN"
			;;
			*)
				echo "d or r"
				false
			;;
		esac

		BR=$?
		if [ "$BR" -ne 0 ]
		then
			send_hyprnotify 3 "Cache generation fail!"
		else
			send_hyprnotify 5 "Cache generation complete!"
		fi

		return "$BR"
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
		cmake --build "$PRT" -t rebuild_cache
		cmake --build "$PRT" -- "-j$THREADS"
	else
		./build.sh -b "$PRT" -j "$THREADS"
	fi

	BR=$?
	if [ "$BR" -ne 0 ]
	then
		send_hyprnotify 3 "Build failed!"
	else
		send_hyprnotify 5 "Build complete!"
	fi

	return "$BR"
}

alias find_in_history='cat ~/.zsh_history | grep'

livebg()
{
	pkill mpvpaper
	pkill cava

	zmodload zsh/zutil
	zparseopts -D -F -E - \
		paper:=io_paper \
		display:=io_display \
		cava=io_cava

	if [ ! $#io_display = 0 ]
	then
		WORK_MONITOR="${io_display[-1]##*=}"
		hyprctl monitors | grep "$WORK_MONITOR" > /dev/null
		if [ "$?" -ne 0 ]
		then
			send_hyprnotify 3 "No display: $WORK_MONITOR!"
			WORK_MONITOR="$MAIN_MONITOR"
		fi

	else
		WORK_MONITOR="$MAIN_MONITOR"
	fi

	if [ ! $#io_paper = 0 ]
	then
		NAME="${io_paper[-1]##*=}.mp4"
		FILE="wallpapers/live/$NAME"

		if [ ! -f "$CONFIG_DIRECTORY/$FILE" ]
		then
			send_hyprnotify 3 "No wallpaper file: $NAME!"
		else
			mpvpaper "$WORK_MONITOR" "$HOME/.local/share/$FILE" -o "loop no-audio" &
		fi
	fi

	if [ ! $#io_cava = 0 ]
	then
		OLD_MON_ID="${$(hyprctl activeworkspace | grep "monitorID")##*: }"

		hyprctl dispatch focusmonitor "$WORK_MONITOR" > /dev/null
		sleep 0.1
		kitten panel --config "$CONFIG_DIRECTORY/kitty/cava.conf" --edge=background \
					 --output-name=Cava cava &
		sleep 0.5
		hyprctl dispatch focusmonitor "$OLD_MON_ID" > /dev/null
	fi
}

alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
