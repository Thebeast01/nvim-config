# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal **Neovim configuration** built on **NvChad v2.5** with **lazy.nvim** as the plugin manager. It targets **Neovim 0.11+** (uses the modern `vim.lsp.config` / `vim.lsp.enable` API and `vim.treesitter.start()` rather than the legacy lspconfig/nvim-treesitter framework calls). This is the **Windows** branch (`main`); the `Linux` branch carries the same config plus extra dotfiles (`fastfetch/`, `tmux-config/`) that don't apply on Windows.

There is no build system or test suite — this is runtime configuration. "Does it work" means "does Neovim start without errors and behave correctly."

## Verifying changes

Always sanity-check edits headlessly before considering them done:

```sh
# Clean-load test: should print the marker and nothing else
nvim --headless "+lua print('=== load ok ===')" "+messages" +qa

# Realistic test: open a real file so treesitter/LSP/mappings/conform fire
nvim --headless lua/options.lua "+lua vim.defer_fn(function() vim.cmd('messages'); vim.cmd('qa') end, 1500)"

# Count resolved plugin specs (sanity after restructuring plugin files)
nvim --headless "+lua print(#require('lazy').plugins())" +qa
```

Plugin management (run inside Neovim): `:Lazy sync`, `:Lazy clean`, `:TSUpdate`, `:checkhealth`.

Formatting follows `.stylua.toml` (4-space indent, double quotes, `call_parentheses = "None"`, width 120). Stylua is not installed locally; match the existing style by hand. `conform.nvim` formats on save for configured filetypes (see `lua/configs/conform.lua`).

## Load sequence (`init.lua`)

Order matters and is non-obvious:
1. Sets `vim.g.base46_cache`, leader, fold options **before** lazy bootstraps.
2. `require("lazy").setup({ {NvChad import}, {import="plugins"} }, lazy_config)` — NvChad's own plugins load first, then everything under `lua/plugins/`.
3. Theme is applied by `dofile`-ing the **compiled base46 cache** (`defaults`, `statusline`), not by a colorscheme command.
4. `require "options"` → `require "nvchad.autocmds"` → mappings are loaded **deferred** via `vim.schedule`.

## Architecture

- **`lua/chadrc.lua`** — NvChad UI config (`ChadrcConfig`): active theme (`obsidian-ember`, transparent), statusline modules (custom `time` clock), nvdash header, telescope/cmp/colorify styling. This is the single source of truth for theme/UI; base46 recompiles from it.
- **`lua/plugins/*.lua`** — Plugin specs grouped by purpose (lsp, completion, treesitter, coding, telescope, editor, git, formatting, ui, markdown, lang, database, todo, colorschemes, misc). lazy.nvim auto-imports **every** file in this directory, so each file just returns a spec table (or list). `init.lua` here is an intentionally empty index with an overview comment — add new plugins to the matching category file.
- **`lua/configs/`** — Heavy plugin setup extracted out of specs:
  - `lspconfig.lua` — defines the `servers` list and configures them via `vim.lsp.config` + `vim.lsp.enable`. `on_attach` sets LSP keymaps and a format-on-save autocmd; `tailwindcss` and `eslint` have bespoke configs (eslint runs `EslintFixAll` on save).
  - `conform.lua` — per-filetype formatters and their args.
  - `lazy.lua` — lazy.nvim options (disabled rtp plugins, lazy defaults).
  - `buflimit.lua` — **custom** module capping NvChad tabufline buffers at `MAX_BUFS = 3`, evicting the least-recently-used buffer that is not active/visible/modified. Loaded from `options.lua`.
- **`lua/options.lua`** — `vim.opt` settings (after `require "nvchad.options"`); also wires up the yank-highlight autocmd, diagnostic config, and loads `configs.buflimit`.
- **`lua/mappings.lua`** — keymaps (after `require "nvchad.mappings"`). Also contains a `cmp.setup{}` block configuring Tab/CR completion behavior.

## Gotchas specific to this config

- **Two completion engines coexist**: `nvim-cmp` (pulled in by NvChad's default plugin set, configured in `mappings.lua`) and `blink.cmp` (added in `lua/plugins/completion.lua`). `require("cmp")` in `mappings.lua` depends on NvChad providing nvim-cmp — don't remove that assumption casually.
- **`blink.cmp` references an uninstalled `supermaven` source** (`module = "blink.compat.source"`); neither `blink.compat` nor `supermaven-nvim` is installed. blink currently tolerates it. To actually enable it, both plugins must be added.
- **Diagnostics are configured in three places** (`options.lua`, `configs/lspconfig.lua`, and `tiny-inline-diagnostic` in `plugins/ui.lua`); the last one wins and disables `virtual_text` in favor of inline rendering. Change them together.
- `lua/configs/lspconfig.lua` lists some entries that are formatters/tools, not language servers (`prettier`, `postgres-language-server`); they are passed to `vim.lsp.enable` and silently ignored if not real servers.
- Editing `chadrc.lua` UI/theme values may require deleting the base46 cache or running `:Lazy sync` for recompilation to take effect.
