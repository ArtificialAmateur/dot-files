# ZSH Modules {{{

# Loads listed modules:
autoload -Uz compinit promptinit vcs_info color

# }}}



# Options (((

# Auto-corrects commands:
setopt correctall

# Prevents command duplicates from being recorded in history:
setopt hist_ignore_all_dups

# Prevents commands from being recorded if preceeded with a space:
setopt hist_ignore_space

# Shares the same history with all shells:
setopt sharehistory

# Changes into typed-in directory without having to type "cd":
setopt autocd

# Expands globbing operator and list all matches found:
setopt extendedglob

# )))



# Prompt {{{

# Activates prompt:
promptinit

# Sets 256 color mode:
export TERM="xterm-256color"

# Powerlevel9k Configuration
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# }}}



# History {{{

# Sets history size:
export HISTSIZE=2000

# Sets history file directory:
export HISTFILE="~/.zsh/zhistory"

# Saves history:
export SAVEHIST=$HISTSIZE

# }}}



# Variables {{{

# Sets default editor to vim:
export EDITOR=/usr/bin/vim

# Displays location of local scripts:
export PATH=$PATH:~/bin

# Fixes "command not found" for root permission programs:
export PATH=/sbin:/usr/sbin:$PATH

# Sets JDK environments
export JDK_HOME=/usr/lib/jvm/oracle-jdk-bin-1.8
export JAVA_HOME=/usr/lib/jvm/oracle-jdk-bin-1.8

# }}}



# Aliases {{{

# Reminds me to use keyboard shortcuts instead:
alias clear="echo 'USE ^L!'"

# Incase you forget to type sudo:
alias fuck='sudo $(fc -ln -1)'

# Improves 'ls' commands:
alias ls="ls --color=auto"
alias ll="ls -lha"
alias la="ls -a"

# Automatically warps text in nano:
alias nano="nano -w"

# Runs wgetpaste with dpaste:
alias dpaste="wgetpaste -s dpaste"

# Runs screenshot in interactive mode:
alias gnome-screenshot="gnome-screenshot --interactive"

# ISO 8601
alias date="date -I'seconds' | sed -e 's/T/ /g'"

# Remove directory shortcut:
alias rmr="rm -r"

# Improves 'df' command:
alias df="df -h"

# }}}



# Completions {{{

# Activates completions:
compinit -d ~/var/cache/zsh

# Enables completions cache:
zstyle ':completion::complete:*' use-cache 1

# Sets completions format:
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

# Gives error if no matches appear:
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# }}}



# Functions {{{

# Displays a list of supported colors:
function lscolors {
	((cols = $COLUMNS - 4))
	s=$(printf %${cols}s)
	for i in {000..$(tput colors)}; do
		echo -e $i $(tput setaf $i; tput setab $i)${s// /=}$(tput op);
	done
}

# Launches a program:
function launch {
	type $1 >/dev/null || { print "$1 not found" && return 1 }
	$@ &>/dev/null &|
}

# Opens a web browser on google for a query:
function google {
	xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`"
}

# Gets public ip address:
function myip {
	local api
	case "$1" in
		"-4")
			api="http://v4.ipv6-test.com/api/myip.php"
			;;
		"-6")
			api="http://v6.ipv6-test.com/api/myip.php"
			;;
		*)
			api="http://ipv6-test.com/api/myip.php"
			;;
	esac
	curl -s "$api"
	echo # Newline.
}

# Shortens url using goo.gl:
function surl {
	if [[ -z $1 ]]; then
		print "USAGE: $0 <URL>"
		return 1
	fi

	local url=$1
	local api="https://www.googleapis.com/urlshortener/v1/url"
	local data

	# Prepend "http://" to given URL where necessary for later output.
	if [[ $url != http(s|)://* ]]; then
		url="http://$url"
	fi
	local json="{\"longUrl\": \"$url\"}"

	data=$(curl --silent -H "Content-Type: application/json" -d $json $api)
	# Match against a regex and print it
	if [[ $data =~ '"id": "(http://goo.gl/[[:alnum:]]+)"' ]]; then
		print $match
	fi
}

# }}}



# External Files {{{

# ZSH auto-suggestions:
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH syntax-highlighting:
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

# Powerlevel9k theme:
source ~/.zsh/powerlevel9k/powerlevel9k.zsh-theme

# }}}