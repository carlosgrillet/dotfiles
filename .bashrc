# Author: Carlos Grillet
#
# This is my personal .bashrc file.
# not much to see here; just some pretty standard stuff.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# user variables
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERM="xterm-256color"
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u@\h]\[\033[00m\][\[\033[01;34m\]\W\[\033[00m\]]\[\033[01;34m\]$(current_branch)\[\033[00m\]\$ '

# hisotry options
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%F %T "
HISTIGNORE="clear:history"

# shopt options
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# user alias
alias dockerls='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.RunningFor}}"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# user functions
function current_branch() {
    git branch --show-current 2> /dev/null | sed -e 's/\(.*\)/ @\1/'
}

