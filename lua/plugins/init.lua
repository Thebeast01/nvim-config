return {
  -- Try to learn about vim fugitive
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   transparent = true,
  --   config = function()
  --     require("nordic").setup({
  --       transparent = {
  --         bg = true,
  --         float = true,
  --       }
  --     })
  --   end
  --
  -- },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        transparent_background = true,
        comments = { fg = "#ff0000" },

      }
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd [[colorscheme tokyodark]]
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
    end
  },
  {

    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require "configs.lspconfig"
      local lspconfig = require "lspconfig"

      -- Common LSP settings for auto-imports and code completion
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Common keymappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end

        -- Enable inlay hints if available
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hint(bufnr, true)
        -- end
      end

      -- TypeScript/JavaScript configuration
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
              autoImports = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
              autoImports = true,
            },
          },
        },
      }

      -- Golang configuration
      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            experimentalPostfixCompletions = true,
          },
        },
      }

      -- Prisma configuration
      lspconfig.prismals.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- HTML configuration
      lspconfig.html.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          html = {
            format = {
              enable = true,
            },
            hover = {
              documentation = true,
              references = true,
            },
          },
        },
      }

      -- CSS configuration
      lspconfig.cssls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore"
            },
          },
        },
      }

      -- Tailwind configuration
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                "tw=\"([^\"]*)",
                "tw={\"([^\"}]*)",
                "tw\\.\\w+`([^`]*)",
                "tw\\(.*?\\)`([^`]*)",
              },
            },
          },
        },
      }

      -- Lua configuration
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
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
