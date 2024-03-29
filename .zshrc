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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LD_LIBRARY_PATH="/opt/gurobi751/linux64/lib/:/home/user/code/grelka/env/lib/python3.7/site-packages/"
