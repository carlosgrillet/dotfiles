# Author: Carlos Grillet
#
# This is my personal .bashrc file.
# not much to see here; just some pretty standard stuff.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash colors
blk='\[\033[0;30m\]'
red='\[\033[0;31m\]'
grn='\[\033[0;32m\]'
ylw='\[\033[0;33m\]'
blu='\[\033[0;34m\]'
prp='\[\033[0;35m\]'
cyn='\[\033[0;36m\]'
wht='\[\033[0;37m\]'
nc='\[\033[00m\]'

# user variables
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERM="xterm-256color"
PS1="$grn[\u@\h]$nc[${blu}\W${nc}${wht}\$(current_branch)${nc}]\$ "

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
shopt -s dotglob # include hidden files in globbing
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

