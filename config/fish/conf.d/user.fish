abbr -a ll exa -lh
abbr -a l ll
abbr -a la exa -lah

# TODO make cross-platform
abbr -a nnn nautilus . --no-desktop

# Ubuntu
abbr -a install sudo apt install -y
abbr -a update sudo apt update
abbr -a upgrade sudo apt upgrade
abbr -a remove sudo apt remove

# Python
abbr -a py3 python3
abbr -a pyserver py3 -m SimpleHTTPServer

# Erlang
abbr -a r3 rebar3

# Vim
abbr -a vi nvim
abbr -a nv nvim
abbr -a vimrc vi ~/.vimrc

# Emacs
abbr -a  e emacsclient
abbr -a et emacsclient -t
abbr -a ec emacsclient -nc

# Git
abbr -a   g git
abbr -a  gp git push
abbr -a  gl git pull
abbr -a  gf git fetch
abbr -a  gs git status
abbr -a  gd git diff
abbr -a  ga git add
abbr -a  gc git commit -v
abbr -a gca git commit -v -a
abbr -a gco git checkout
abbr -a gdd git diff
abbr -a gcp git cherry-pick
abbr -a gcl git clone --recursive
abbr -a grb git rebase
abbr -a grbmh git rebase -i "(git merge-base HEAD origin/master)"

# https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
