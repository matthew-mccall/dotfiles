# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).
The repo is organized so Stow can place the config files directly into your home
directory with `--dotfiles`.

## What is here

### Neovim

- `lazy.nvim` bootstrap and plugin loading
- Treesitter for `c`, `cpp`, `cmake`, `latex`, `lua`, `vim`, and `vimdoc`
- `nvim-cmp` completion with `snippy`, buffer/path/cmdline sources, and TeX completion
- UI helpers like `lualine`, `bufferline`, and `rainbow-delimiters`
- `nvim-autopairs`
- `iron.nvim` REPL support for Scheme and Haskell, with auto-load on save for `.ss` and `.hs`
- `vimtex` configured to open PDFs with Skim
- Monokai Pro colorscheme with day/night switching

### tmux

- Simple tmux configuration with the status bar pinned to the top

### zsh

- `antigen`-based shell setup
- `oh-my-zsh` plus bundles for `colorize`, `gitignore`,
  `fast-syntax-highlighting`, and `zsh-completions`
- PATH additions for local tools and desktop apps
- `zoxide` integration for smart directory jumping

### helper scripts

- `scripts/setup` — convenience setup entrypoint
- `scripts/ag` — LaTeX project generator with `--make-template` for rebuilding the embedded template
- `scripts/recent-commit-links` — prints recent commit URLs, including merged PR commits
- `scripts/contained` — generates a bundled LaTeX project template

`scripts/ag` supports both the normal unpack flow and a self-templating mode:

```sh
./scripts/ag <project_name>
./scripts/ag --make-template
./scripts/ag --help
```

## Requirements

- GNU Stow
- a `csh`/`tcsh`-compatible shell for `scripts/setup` (`#!/bin/csh`)
- Neovim, tmux, and zsh for the configs in this repo
- `base64` for encoding and decoding the embedded template payload
- `tar` for packing and extracting the template archive
- `xz` support for `tar -cJf` compression

Some scripts also expect extra tools such as `gh`, `podman`, and `zoxide`.

## Setup

The easiest way to install the dotfiles is:

```sh
./scripts/setup
```

That script changes into the repo root and runs:

```sh
stow -v --dotfiles -t "$HOME" nvim
stow -v --dotfiles -t "$HOME" tmux
stow -v --dotfiles -t "$HOME" zsh
```

If you prefer to do it manually, run the same Stow commands from the repo root.
