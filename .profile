# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# $PATH settings
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
export PATH="$HOME/prefix/bin:$PATH"

export PATH="$HOME/.cabal/bin:/opt/cabal/1.24/bin:/opt/ghc/8.2.1/bin:$PATH"

export EDITOR="vi"
source "$HOME/.cargo/env"
