#!/usr/bin/env bash
# Symlink the dotfiles into $HOME. Existing files are moved to ~/.dotfiles-backup/<timestamp>/.
# Usage: ./install.sh [--brew]   (--brew also installs Node LTS through nvm and runs `brew bundle`)
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

backup() {
  local target="$1"
  local dest="$BACKUP/${target#"$HOME"/}"
  mkdir -p "$(dirname "$dest")"
  mv "$target" "$dest"
  echo "  backed up $target -> $dest"
}

link() {
  local src="$DOTFILES/$1" target="$2"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "  ok        $target"
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    backup "$target"
  fi
  mkdir -p "$(dirname "$target")"
  ln -s "$src" "$target"
  echo "  linked    $target"
}

# Older setups linked ~/.vim to a whole repo directory; make it a real directory
# so vim-plug's plugins and autoload stay out of this repo.
if [ -L "$HOME/.vim" ]; then
  backup "$HOME/.vim"
fi

# nvm lives in ~/.nvm (where zsh-nvm expects it). Install it before linking
# default-packages into that directory, since cloning needs an empty target.
NVM_DIR="$HOME/.nvm"
if [ ! -f "$NVM_DIR/nvm.sh" ]; then
  echo "Installing nvm into $NVM_DIR"
  [ -d "$NVM_DIR" ] && backup "$NVM_DIR"
  git clone --quiet https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  git -C "$NVM_DIR" checkout --quiet "$(git -C "$NVM_DIR" describe --abbrev=0 --tags --match "v[0-9]*" "$(git -C "$NVM_DIR" rev-list --tags --max-count=1)")"
fi

echo "Linking dotfiles from $DOTFILES"
link zsh/zshrc       "$HOME/.zshrc"
link zsh/zprofile    "$HOME/.zprofile"
link git/gitconfig   "$HOME/.gitconfig"
link ghostty/config  "$HOME/.config/ghostty/config"
link vim/vimrc       "$HOME/.vimrc"
link vim/plug.vim    "$HOME/.vim/plug.vim"
link nvim/init.vim   "$HOME/.config/nvim/init.vim"
link nvim/lua/lsp.lua "$HOME/.config/nvim/lua/lsp.lua"
link nvm/default-packages "$NVM_DIR/default-packages"

# Ghostty on macOS also reads this file, and it overrides ~/.config/ghostty/config
ghostty_mac="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if [ -f "$ghostty_mac" ] && [ ! -L "$ghostty_mac" ]; then
  echo "  warning   $ghostty_mac exists and overrides the linked config; remove it or move its settings into ghostty/config"
fi

if [ "${1:-}" = "--brew" ]; then
  # Node LTS through nvm; nvm also installs the packages in nvm/default-packages (sfw)
  echo "Installing Node LTS with nvm"
  set +eu   # nvm.sh is not written for errexit/nounset
  # shellcheck source=/dev/null
  . "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm_status=$?
  set -eu
  if [ "$nvm_status" -ne 0 ]; then
    echo "nvm install --lts failed" >&2
    exit 1
  fi

  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed: https://brew.sh" >&2
    exit 1
  fi
  brew bundle --file="$DOTFILES/Brewfile"
fi

echo "Done. Open a new terminal; zinit and vim-plug install their plugins on first run."
