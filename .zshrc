# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="jreese"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git wd tmuxinator)

source $ZSH/oh-my-zsh.sh
source ~/.aliases

UNAMESTR="$(uname -a)"
if [[ "$UNAMESTR" == Linux* ]] && [[ -n "$DISPLAY" ]]; then
    # Don't set this on WSL as there's no X
    setxkbmap -layout us -option ctrl:nocaps
fi

export DISABLE_AUTO_TITLE=true

#TERM="xterm-256color"

LOCAL_INIT_ERL_LIBS="$HOME/local_init_erl_libs.sh"
if [ -f "$LOCAL_INIT_ERL_LIBS" ]; then
    source $LOCAL_INIT_ERL_LIBS
fi

# make aliases available in sudo
alias sudo='sudo '

# key repeat for either Windows or whatever windows terminal emulator I'm
# using?
KEYTIMEOUT=1

SAVEHIST=1000000
HISTSIZE=1000000

# don't share history among different zsh terminals
unsetopt share_history

# Only allow unique entries in the PATH variable
typeset -U path

# always use the same ssh-agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	eval `ssh-agent`
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

export PATH=/home/user/.nimble/bin:$PATH

export EDITOR=nvim

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#source /home/user/.config/broot/launcher/bash/br

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

# Will's stuff

# change to directory. doesn't look too deep, use it to get to project dirs
function z() {
	local search="${1:-.}"
	local found=$(fd --maxdepth=3 --type d ${search} ~/code | fzf --select-1 --exit-0)

	if [ -z "$found" ]; then
		return
	fi

	if test -d ${found}; then
		cd ${found}
	fi
}

# change to virtualenv
# assumes virtualenvs live in ~/.envs (because why would you pollute your repo???)
function v() {
	local search="${1:-.}"
	local found=$(fd --maxdepth=1 --type d ${search} ~/.envs/ | fzf --select-1 --exit-0)

	if [ -z "$found" ]; then
		return
	fi

	if test -f ${found}/bin/activate; then
		source ${found}/bin/activate
	fi
}

# fuzzy file opener with preview (can also cd, which is why this is a function and not a script!)
function ,() {
	local dir="."
	local search="."

	command -v bat >/dev/null 2>&1 || { echo >&2 "I require bat but it's not installed.  Aborting."; exit 1; }
	command -v fd >/dev/null 2>&1 || { echo >&2 "I require fd but it's not installed.  Aborting."; exit 1; }
	command -v fzf >/dev/null 2>&1 || { echo >&2 "I require fzf but it's not installed.  Aborting."; exit 1; }
	command -v rg >/dev/null 2>&1 || { echo >&2 "I require rg but it's not installed.  Aborting."; exit 1; }
	command -v tree >/dev/null 2>&1 || { echo >&2 "I require tree but it's not installed.  Aborting."; exit 1; }

	if [ -n "$1" ]; then
		if test -f $1; then
			$EDITOR $1
			return

		elif test -d $1; then
			local dir=$1

		elif [ $1 = "-f" ]; then
			# Special find mode.
			# todo: don't open if nothing found
			# todo: allow picking search dir
			${EDITOR} $(rg -n ${2:-.} | fzf --tac --select-1 --exit-0 | awk -F: '{print "+" $2 " " $1}')
			return

		elif [ $1 = "-t" ] || [[ $1 = +* ]]; then
			# Trying to open tag or specific line. Just pass straight to editor.
			${EDITOR} $*
			return

		else
			local search=$1
		fi
	fi

	local found=$(
		fd \
			--full-path \
			--hidden \
			--size -10m \
			--exclude '*.gz' \
			--exclude '*.xz' \
			--exclude .git \
			${search} ${dir} \
			| fzf --tac --select-1 --exit-0 \
				--preview="if test -f {}; then
					bat --style=numbers --color=always --line-range :150 {}
				else
					tree -C -L 1 {};
				fi"
	)

	if [ -z "$found" ]; then
		return
	fi

	if test -d ${found}; then
		cd ${found}

	elif test -f ${found}; then
		${EDITOR} ${found}
	fi
}

# preview with bat. I don't use this much, YMMV.
function p() {
	local search="${1:-.}"
	local dir="${2:-.}"

	local found=$(
		fd --type f ${search} ${dir} \
			| fzf --tac --select-1 --exit-0 \
				--preview="bat --style=numbers --color=always --line-range :150 {}"
	)

	if [ -z "$found" ]; then
		return
	fi

	if test -f ${found}; then
		bat --style=numbers --color=always ${found}
	fi
}

# git checkout with fzf. doesn't work for remote really, needs more work. YMMV.
function co() {
	local search="${1:-.}"
	local found=$(git branch --all \
		| grep ${search} \
		| fzf --select-1 --exit-0 \
		| tr -d '[:space:]'
	)

	if [ -z "$found" ]; then
		return
	fi

	git checkout ${found}
}
