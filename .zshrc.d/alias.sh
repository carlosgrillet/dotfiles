alias dockerls='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.State}}\t{{.RunningFor}}"'
alias la='ls -lah --color=auto'
alias ls='ls -lh --color=auto'
alias play='asciinema play'
alias rec='asciinema rec'
alias tf='terraform'
alias vim='nvim'

if [[ -x kubecolor ]]; then
  alias k='kubecolor --kubecolor-theme=deuteranopia-dark'
else
  alias k='kubectl'
fi
