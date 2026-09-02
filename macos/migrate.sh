#!/usr/bin/env bash

set -Eeuo pipefail

readonly REPO_URL_DEFAULT="git@github.com:carlosgrillet/dotfiles.git"
readonly OH_MY_ZSH_URL="https://github.com/ohmyzsh/ohmyzsh.git"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"
EXTRA_BREWFILE="$SCRIPT_DIR/Brewfile.extra"
APP_INVENTORY="$SCRIPT_DIR/apps.txt"
DOTFILES_DIR="${DOTFILES_DIR:-}"
DOTFILES_REPO_URL="${DOTFILES_REPO_URL:-$REPO_URL_DEFAULT}"
DRY_RUN=0

if [[ -z "$DOTFILES_DIR" ]]; then
  if [[ -d "$REPO_ROOT/.git" ]]; then
    DOTFILES_DIR="$REPO_ROOT"
  else
    DOTFILES_DIR="$HOME/github/dotfiles"
  fi
fi

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'Warning: %s\n' "$*" >&2
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

run() {
  if ((DRY_RUN)); then
    printf '+'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi

  "$@"
}

usage() {
  cat <<'EOF'
Usage: ./migrate.sh <command> [--dry-run]

Commands:
  snapshot   Refresh Brewfile and apps.txt on the old Mac
  restore    Set up programs and dotfiles on the new Mac
  audit      Report packages or links that are still missing
  help       Show this help

Environment overrides:
  DOTFILES_DIR       Dotfiles checkout path
  DOTFILES_REPO_URL  Dotfiles Git URL

Run snapshot shortly before returning the old laptop. Review its output before
committing because Homebrew may record private or company-only taps.
EOF
}

require_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || die "this script supports macOS only"
}

activate_homebrew() {
  local brew_path

  if command -v brew >/dev/null 2>&1; then
    return 0
  fi

  for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brew_path" ]]; then
      eval "$("$brew_path" shellenv)"
      return 0
    fi
  done

  return 1
}

install_homebrew() {
  local installer_url

  if activate_homebrew; then
    log "Homebrew is already installed"
    return 0
  fi

  log "Installing Homebrew"
  installer_url="https://raw.githubusercontent.com/Homebrew/install"
  installer_url="$installer_url/HEAD/install.sh"

  if ((DRY_RUN)); then
    printf '+ /bin/bash Homebrew/install/HEAD/install.sh\n'
    return 0
  fi

  /bin/bash -c "$(curl -fsSL "$installer_url")"
  activate_homebrew || die "Homebrew installed but is not on PATH"
}

ensure_homebrew_shellenv() {
  local brew_path shellenv_line

  if [[ -x /opt/homebrew/bin/brew ]]; then
    brew_path="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    brew_path="/usr/local/bin/brew"
  else
    warn "cannot add Homebrew to .zprofile during a dry run"
    return 0
  fi

  shellenv_line="eval \"\$($brew_path shellenv)\""
  if [[ -f "$HOME/.zprofile" ]] &&
    grep -Fqx "$shellenv_line" "$HOME/.zprofile"; then
    return 0
  fi

  log "Adding Homebrew to ~/.zprofile"
  if ((DRY_RUN)); then
    printf '+ append %q to %q\n' "$shellenv_line" "$HOME/.zprofile"
    return 0
  fi

  printf '\n%s\n' "$shellenv_line" >>"$HOME/.zprofile"
}

ensure_cargo_shellenv() {
  local cargo_line='export PATH="$HOME/.cargo/bin:$PATH"'

  if [[ -f "$HOME/.zprofile" ]] &&
    grep -Fqx "$cargo_line" "$HOME/.zprofile"; then
    return 0
  fi

  log "Adding Cargo to ~/.zprofile"
  if ((DRY_RUN)); then
    printf '+ append %q to %q\n' "$cargo_line" "$HOME/.zprofile"
    return 0
  fi

  printf '\n%s\n' "$cargo_line" >>"$HOME/.zprofile"
}

install_rust() {
  local installer tmp_file

  if command -v cargo >/dev/null 2>&1 &&
    command -v rustup >/dev/null 2>&1; then
    log "Rustup and Cargo are already installed"
    ensure_cargo_shellenv
    return 0
  fi

  log "Installing the stable Rust toolchain"
  if ((DRY_RUN)); then
    printf '+ install rustup with the stable toolchain\n'
    ensure_cargo_shellenv
    return 0
  fi

  if command -v rustup >/dev/null 2>&1; then
    rustup toolchain install stable
    rustup default stable
  else
    installer="https://sh.rustup.rs"
    tmp_file="$(mktemp "${TMPDIR:-/tmp}/rustup-init.XXXXXX")"
    if ! curl \
      --proto '=https' \
      --tlsv1.2 \
      -sSfL \
      "$installer" \
      -o "$tmp_file"; then
      rm -f "$tmp_file"
      die "could not download rustup"
    fi
    sh "$tmp_file" \
      -y \
      --profile minimal \
      --default-toolchain stable
    rm -f "$tmp_file"
  fi

  export PATH="$HOME/.cargo/bin:$PATH"
  ensure_cargo_shellenv
}

snapshot_homebrew() {
  local tmp_file

  activate_homebrew || die "Homebrew is required for snapshot"
  tmp_file="$(mktemp "${TMPDIR:-/tmp}/Brewfile.XXXXXX")"

  log "Taking a Homebrew and developer-tool snapshot"
  if ((DRY_RUN)); then
    printf '+ brew bundle dump --file=%q --force [all package types]\n' \
      "$BREWFILE"
    rm -f "$tmp_file"
    return 0
  fi

  if ! env -u TMUX brew bundle dump \
    --file="$tmp_file" \
    --force \
    --formula \
    --cask \
    --tap \
    --mas \
    --vscode \
    --go \
    --cargo \
    --uv \
    --npm \
    --no-describe; then
    rm -f "$tmp_file"
    die "Homebrew snapshot failed"
  fi

  mv "$tmp_file" "$BREWFILE"
  log "Updated $BREWFILE"
  warn "review the Brewfile for private taps before committing it"
}

snapshot_apps() {
  local app app_id app_name tmp_file

  tmp_file="$(mktemp "${TMPDIR:-/tmp}/apps.XXXXXX")"
  log "Recording installed macOS applications"

  if ((DRY_RUN)); then
    printf '+ inventory /Applications and %q\n' "$HOME/Applications"
    rm -f "$tmp_file"
    return 0
  fi

  {
    printf '# Application\tBundle identifier\n'
    for app in /Applications/*.app "$HOME"/Applications/*.app; do
      [[ -d "$app" ]] || continue
      app_name="${app##*/}"
      app_id="$(
        /usr/libexec/PlistBuddy \
          -c 'Print :CFBundleIdentifier' \
          "$app/Contents/Info.plist" \
          2>/dev/null || true
      )"
      printf '%s\t%s\n' "$app_name" "$app_id"
    done
  } | sort -f >"$tmp_file"

  mv "$tmp_file" "$APP_INVENTORY"
  log "Updated $APP_INVENTORY"
}

install_brewfile() {
  local brewfile="$1"

  [[ -f "$brewfile" ]] || return 0
  log "Installing $(basename "$brewfile")"

  if ((DRY_RUN)); then
    printf '+ brew bundle install --no-upgrade --file=%q\n' "$brewfile"
    return 0
  fi

  if ! env -u TMUX brew bundle install \
    --no-upgrade \
    --file="$brewfile"; then
    warn "some entries in $(basename "$brewfile") could not be installed"
    warn "run the audit command after network and work access are ready"
    return 1
  fi
}

clone_dotfiles() {
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    log "Using dotfiles at $DOTFILES_DIR"
    return 0
  fi

  [[ ! -e "$DOTFILES_DIR" ]] || {
    die "$DOTFILES_DIR exists but is not a Git checkout"
  }

  log "Cloning dotfiles into $DOTFILES_DIR"
  run mkdir -p "$(dirname "$DOTFILES_DIR")"
  run git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
}

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh/.git" ]]; then
    log "Oh My Zsh is already installed"
    return 0
  fi

  [[ ! -e "$HOME/.oh-my-zsh" ]] || {
    die "$HOME/.oh-my-zsh exists but is not a Git checkout"
  }

  log "Installing Oh My Zsh"
  run git clone --depth=1 "$OH_MY_ZSH_URL" "$HOME/.oh-my-zsh"
}

backup_and_link() {
  local source_rel="$1"
  local target_rel="$2"
  local backup_root="$3"
  local source_path="$DOTFILES_DIR/$source_rel"
  local target_path="$HOME/$target_rel"
  local current_target

  [[ -e "$source_path" ]] || {
    warn "dotfile source is missing: $source_path"
    return 1
  }

  if [[ -L "$target_path" ]]; then
    current_target="$(readlink "$target_path")"
    if [[ "$current_target" == "$source_path" ]]; then
      printf 'Linked: ~/%s\n' "$target_rel"
      return 0
    fi
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    log "Backing up ~/$target_rel"
    run mkdir -p "$backup_root/$(dirname "$target_rel")"
    run mv "$target_path" "$backup_root/$target_rel"
  fi

  run mkdir -p "$(dirname "$target_path")"
  run ln -s "$source_path" "$target_path"
}

link_dotfiles() {
  local backup_root
  local link_spec source_rel target_rel
  local links=(
    ".bashrc:.bashrc"
    ".gitconfig:.gitconfig"
    ".vimrc:.vimrc"
    ".zshrc:.zshrc"
    ".zshrc.d:.zshrc.d"
    ".config/lazynvim:.config/nvim"
    ".config/tmux:.config/tmux"
    ".config/helix:.config/helix"
  )

  backup_root="$HOME/.migration-backups/$(date +%Y%m%d-%H%M%S)-$$"
  log "Linking dotfiles"

  for link_spec in "${links[@]}"; do
    source_rel="${link_spec%%:*}"
    target_rel="${link_spec#*:}"
    backup_and_link "$source_rel" "$target_rel" "$backup_root"
  done

  if [[ -d "$backup_root" ]]; then
    log "Previous configuration is in $backup_root"
  fi
}

audit_brewfile() {
  local brewfile="$1"

  [[ -f "$brewfile" ]] || return 0
  log "Checking $(basename "$brewfile")"
  env -u TMUX brew bundle check --file="$brewfile"
}

audit_link() {
  local source_rel="$1"
  local target_rel="$2"
  local expected="$DOTFILES_DIR/$source_rel"
  local target="$HOME/$target_rel"

  if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$expected" ]]; then
    printf 'OK: ~/%s\n' "$target_rel"
    return 0
  fi

  printf 'Missing or different: ~/%s\n' "$target_rel" >&2
  return 1
}

audit() {
  local status=0
  local link_spec source_rel target_rel
  local links=(
    ".bashrc:.bashrc"
    ".gitconfig:.gitconfig"
    ".vimrc:.vimrc"
    ".zshrc:.zshrc"
    ".zshrc.d:.zshrc.d"
    ".config/lazynvim:.config/nvim"
    ".config/tmux:.config/tmux"
    ".config/helix:.config/helix"
  )

  require_macos
  activate_homebrew || {
    warn "Homebrew is not installed"
    status=1
  }

  if command -v brew >/dev/null 2>&1; then
    audit_brewfile "$BREWFILE" || status=1
    audit_brewfile "$EXTRA_BREWFILE" || status=1
  fi

  [[ -d "$HOME/.oh-my-zsh/.git" ]] || {
    warn "Oh My Zsh is not installed"
    status=1
  }

  command -v cargo >/dev/null 2>&1 || {
    warn "Cargo is not installed"
    status=1
  }

  command -v rustup >/dev/null 2>&1 || {
    warn "Rustup is not installed"
    status=1
  }

  log "Checking dotfile links"
  for link_spec in "${links[@]}"; do
    source_rel="${link_spec%%:*}"
    target_rel="${link_spec#*:}"
    audit_link "$source_rel" "$target_rel" || status=1
  done

  return "$status"
}

snapshot() {
  require_macos
  snapshot_homebrew
  snapshot_apps
  log "Snapshot complete"
}

restore() {
  local status=0

  require_macos
  install_homebrew
  activate_homebrew || {
    ((DRY_RUN)) || die "Homebrew is unavailable"
  }
  ensure_homebrew_shellenv
  install_rust

  install_brewfile "$BREWFILE" || status=1
  install_brewfile "$EXTRA_BREWFILE" || status=1
  clone_dotfiles
  install_oh_my_zsh
  link_dotfiles

  log "Restore finished"
  if ((status)); then
    warn "restore finished with package errors; run ./migrate.sh audit"
  else
    printf 'Open a new terminal, then run ./migrate.sh audit.\n'
  fi

  return "$status"
}

main() {
  local command="help"

  if (($#)); then
    command="$1"
    shift
  fi

  while (($#)); do
    case "$1" in
      --dry-run)
        DRY_RUN=1
        ;;
      -h | --help)
        usage
        return 0
        ;;
      *)
        die "unknown option: $1"
        ;;
    esac
    shift
  done

  case "$command" in
    snapshot)
      snapshot
      ;;
    restore)
      restore
      ;;
    audit)
      audit
      ;;
    help | -h | --help)
      usage
      ;;
    *)
      usage >&2
      die "unknown command: $command"
      ;;
  esac
}

main "$@"
