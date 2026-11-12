#!/usr/bin/env bash
# Symlink the dotfiles into $HOME. Existing files are moved to ~/.dotfiles-backup/<timestamp>/.
# Usage: ./install.sh [--brew]   (--brew also runs `brew bundle`)
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

echo "Linking dotfiles from $DOTFILES"
link zsh/zshrc       "$HOME/.zshrc"
link zsh/zprofile    "$HOME/.zprofile"
link git/gitconfig   "$HOME/.gitconfig"
link ghostty/config  "$HOME/.config/ghostty/config"
link vim/vimrc       "$HOME/.vimrc"
link vim/plug.vim    "$HOME/.vim/plug.vim"
link nvim/init.vim   "$HOME/.config/nvim/init.vim"
link nvim/lua/lsp.lua "$HOME/.config/nvim/lua/lsp.lua"

# Ghostty on macOS also reads this file, and it overrides ~/.config/ghostty/config
ghostty_mac="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if [ -f "$ghostty_mac" ] && [ ! -L "$ghostty_mac" ]; then
  echo "  warning   $ghostty_mac exists and overrides the linked config; remove it or move its settings into ghostty/config"
fi

if [ "${1:-}" = "--brew" ]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed: https://brew.sh" >&2
    exit 1
  fi
  brew bundle --file="$DOTFILES/Brewfile"
fi

echo "Done. Open a new terminal; zinit and vim-plug install their plugins on first run."
