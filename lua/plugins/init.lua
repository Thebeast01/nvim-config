return {
  -- Try to learn about vim fugitive 
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      local lspconfig = require "lspconfig"
      -- TypeScript and JavaScript
      lspconfig.ts_ls.setup {}
      -- Prisma
      lspconfig.prismals.setup {}
      -- HTML
      lspconfig.html.setup {}
      -- CSS
      lspconfig.cssls.setup {}
      -- Tailwind CSS
      lspconfig.tailwindcss.setup {}
      -- Lua
      lspconfig.lua.setup {}
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
      config =function()
        require('gitsigns').setup()
        vim.keymap.set("n", "<leader>gp",":Gitsigns preview_hunk<CR>")
      end,
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
  {
    "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  },
  {
    "tpope/vim-fugitive",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.install").compilers = { "zig" }
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    priority = 950,
    config = function()
      vim.g.presence_debug = true

      local presence = require "presence"

      presence.setup {
        auto_update = true,
        neovim_image_text = "neovim",
        main_image = "neovim",
        debounce_timeout = 10,
        log_level = "debug",
        enable_line_number = true,
        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        client_id = "793271441293967371",
        line_number_text = "Line %s out of %s",
      }
      presence:update()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
        },
      }
    end,
  },
  {
    "derektata/lorem.nvim",
    config = function()
      local lorem = require "lorem"
      lorem.setup {
        default_word_count = 10,
        default_sentence_count = 5,
        default_paragraph_count = 3,
      }
    end,
  },
}
