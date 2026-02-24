export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
