export ZSH="$HOME/.oh-my-zsh"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

ZSH_THEME="carlosgrillet"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias dockerls='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.RunningFor}}"'
alias gc='git clone'
alias la='ls -lah --color=auto'
alias ls='ls -lh --color=auto'
alias lzd='lazydocker'
alias tree='tree -C'
alias untar='tar -zxvf'
alias vim='nvim'

if [[ $(arch) = "i386" ]]; then
  alias brew='/usr/local/bin/brew'
  alias python="/usr/local/opt/python@3.10/bin/python3.10"
  alias python3="/usr/local/opt/python@3.10/bin/python3.10"
  export CFLAGS='-I/usr/local/opt/zlib/include -L/usr/local/opt/zlib/lib'
  export LDFLAGS="-L/usr/local/opt/zlib/lib"
  export CPPFLAGS="-I/usr/local/opt/zlib/include"
  export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
  export PATH="/usr/local/opt/python@3.10/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
else
  alias python='python3'
fi

if [[ -f /opt/homebrew/bin/kubecolor ]]; then
  alias k='kubecolor'
fi

tm() {
  if [ -z "$1" ]; then
    echo "Use this to attach to a tmux session"
    echo "Usage: t <session-name>"
    return 1
  else
    tmux a -t "$1"
  fi
}

showme() {
  if [ -z "$1" ]; then
    echo "Use this to find files wthing a directory"
    echo "Usage: showme <regex>"
    return 1
  else
    find . | grep -i "$1"
  fi
}

search () {
  if [ -z "$1" ]; then
    echo "Use this to find a text within all files in a directory"
    echo "Usage: search <regex>"
    return 1
  else
    egrep -rniI "$1" . | sort | uniq
  fi
}

pubip() {
  curl -s https://api64.ipify.org\?format\=json | jq -r .ip 
}

sshkey() {
  echo "#Carlos Grillet"
  cat ~/.ssh/id_rsa.pub
}

godu() {
  cd ~/nso-rosetta
  source ncsrc
  cd ncs-run-5.7.13
  ncs
}

tmsusit() {
  tmux new-session -d -s susit -n REPO -c ~/susit/tools \; \
    new-window -t susit -n NVIM -c ~/susit/tools \; \
    send-keys -t susit:2 'nvim' C-m \; \
    new-window -t susit -n PROD \; \
    new-window -t susit -n DB-PROD \; \
    new-window -t susit -n TOOLING \; \
    select-window -t susit:1
}

tmdu() {
  tmux new-session -d -s du -n DIR -c ~/nso-rosetta \; \
    send-keys -t du:1 'source ncsrc' C-m \; \
    new-window -t du -n REPO -c ~/github/ebb \; \
    new-window -t du -n NVIM -c ~/github/ebb \; \
    send-keys -t du:3 'nvim' C-m \; \
    new-window -t du -n LOGS -c ~/nso-rosetta/ncs-run-5.7.13/logs \; \
    select-window -t du:1
}
