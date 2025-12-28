alias dockerls='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.RunningFor}}"'
alias gc='git clone'
alias la='ls -lah --color=auto'
alias ls='ls -lh --color=auto'
alias lzd='lazydocker'
alias ncli='ncs_cli -Cu admin'
alias play='asciinema play'
alias rec='asciinema rec'
alias tar='tar czf'
alias tf='terraform'
alias tree='tree -C'
alias untar='tar xzf'
alias vim='nvim'
alias gbuild='go build .'
alias sgbuild='go build -ldflags="-s -w" -trimpath .'

if [[ -f /opt/homebrew/bin/kubecolor ]]; then
  alias k='kubecolor --kubecolor-theme=deuteranopia-dark'
else
  alias k='kubectl'
fi
