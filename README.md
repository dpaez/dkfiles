# dkfiles

> My humble dotfiles :sweat_smile:

macOS setup built around **Ghostty**, **zsh** (zinit + [pure](https://github.com/sindresorhus/pure)) and **Neovim**.

## What's inside

| Path | Linked to | Notes |
|---|---|---|
| `zsh/zshrc` | `~/.zshrc` | zinit plugins, history, aliases, PATH |
| `zsh/zprofile` | `~/.zprofile` | Homebrew + OrbStack |
| `git/gitconfig` | `~/.gitconfig` | aliases, diff-so-fancy, GPG signing |
| `ghostty/config` | `~/.config/ghostty/config` | theme follows macOS light/dark |
| `vim/vimrc` | `~/.vimrc` | shared by Vim and Neovim |
| `vim/plug.vim` | `~/.vim/plug.vim` | [vim-plug](https://github.com/junegunn/vim-plug) plugin list |
| `nvim/init.vim` | `~/.config/nvim/init.vim` | loads `~/.vimrc`, then `lsp.lua` |
| `nvim/lua/lsp.lua` | `~/.config/nvim/lua/lsp.lua` | built-in LSP: TypeScript + ESLint, completion while typing |
| `Brewfile` | — | CLI tools, language servers, apps, fonts, VSCodium extensions |

## New machine

1. Install [Homebrew](https://brew.sh).
2. Clone and install:

   ```sh
   git clone https://github.com/dpaez/dkfiles ~/Projects/dkfiles
   cd ~/Projects/dkfiles
   ./install.sh --brew
   ```

3. Open a new Ghostty window. zinit installs itself and the zsh plugins on first run.
4. Open `nvim` once; vim-plug installs the plugins.

`install.sh` is safe to re-run. Anything it would replace is moved to `~/.dotfiles-backup/<timestamp>/`.

## Not in this repo

- `~/.gitconfig-work`: work identity, included for repos under `~/Projects/agility/`.
- GPG keys: commits are signed (`commit.gpgsign = true`), so import your key before committing.
- The **Circular Air** font used for Ghostty's title bar (commercial; install it manually).
- [nvm](https://github.com/nvm-sh/nvm) is installed by the `zsh-nvm` plugin; [pyenv](https://github.com/pyenv/pyenv) needs installing separately if you want it.
- `~/Projects/agility/.envrc`: makes everything under that folder use the work GitHub account (run `direnv allow` once):

  ```sh
  export GH_TOKEN="$(gh auth token --user dpaez-agilityio)"            # gh + HTTPS git
  export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_work -o IdentitiesOnly=yes"  # SSH git
  ```
