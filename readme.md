# nvim-config

Personal Neovim configuration built on [NvChad](https://github.com/NvChad/NvChad) v2.5, with plugins managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Leader key

The leader key is the **spacebar** (set in `init.lua`).

## Theme

Default colorscheme is `chocolate`, with `everforest` available via the theme toggle (see `lua/chadrc.lua`).

## Layout

- `init.lua` — entry point; bootstraps lazy.nvim and loads NvChad
- `lua/chadrc.lua` — NvChad UI/theme overrides
- `lua/mappings.lua` — custom keymaps
- `lua/options.lua` — Neovim options
- `lua/configs/` — per-plugin setup (LSP, conform, lazy, buflimit)
- `lua/plugins/` — plugin specs, split by concern (lsp, completion, git, telescope, ui, etc.)

## Setup

```sh
git clone <this repo> ~/.config/nvim
nvim
