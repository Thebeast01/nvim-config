return {

  -- PASSED: This is a passed test
  -- FIXME: Try to learn about vim fugitive
  -- BUG : Fix the issue with the plugin not loading correctly
  -- ISSUE: The plugin is not working as expected
  -- TODO: Add more plugins for better development experience
  -- HACK: This is a temporary solution
  -- WARN : This is a warning message
  -- INFO: Thisis infor
  -- PERFORMANCE: This is a performance issue
  -- TESTING : Thisis a testing message

  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          media_files = {
            filetypes = { "png", "jpg", "jpeg", "webp", "gif" },
            -- find_cmd = "rg" -- or "fd"
          }
        }
      }
      require("telescope").load_extension("media_files")
    end,
  },
  -- telescope
  {

    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
      }
    },

    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      vim.keymap.set("n", "<space>tn",
        function()
          require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath("config")
          }
        end)
    end
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {
        signs = true,
        keywords = {
          FIX    = { icon = "", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
          TODO   = { icon = "", color = "info" },
          HACK   = { icon = "", color = "warning" },
          WARN   = { icon = "", color = "warning", alt = { "WARNING" } },
          PERF   = { icon = "", color = "hint", alt = { "OPTIM", "PERFORMANCE" } },
          NOTE   = { icon = "", color = "info", alt = { "INFO" } },
          TEST   = { icon = "⏲", color = "test", alt = { "TESTING", "FAILED" } },
          PASSED = { icon = "✔ ", color = "success", alt = { "PASSED" } },
        },
        colors = {
          error   = { "DiagnosticError", "ErrorMsg", "#DD0303" },  -- rose-pine "love"
          warning = { "DiagnosticWarn", "WarningMsg", "#f6c177" }, -- rose-pine "gold"
          info    = { "DiagnosticInfo", "#31748f" },               -- rose-pine "pine"
          hint    = { "DiagnosticHint", "#c4a7e7" },               -- rose-pine "iris"
          test    = { "Identifier", "#ebbcba" },                   -- rose-pine "rose"
          success = { "String", "#9ccfd8" },                       -- rose-pine "foam" (green/teal)
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        enabled = false, -- disable Noice messages
      },
      notify = {
        enabled = false, -- disable Noice notifications
      },
      popupmenu = {
        enabled = false, -- disable popupmenu UI
      },
      cmdline = {
        enabled = true, -- keep cmdline enabled
      },
      lsp = {
        progress = {
          enabled = false, -- disable LSP progress spinner
        },
        hover = {
          enabled = false, -- disable hover UI
        },
        signature = {
          enabled = false, -- disable signature help UI
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },


  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "rust-lang/rust.vim"
  },
  {
    "simrat39/rust-tools.nvim"
  },
  -- Surround Plugin tpope/vim-surround
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup({
  --
  --     })
  --   end,
  -- },

  { "rose-pine/neovim",         name = "rose-pine" },
  { "ramojus/mellifluous.nvim", name = "mellifluous" },
  {
    "vague2k/vague.nvim",
    name = "vague",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  --
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --     "hrsh7th/cmp-nvim-lsp",
  --   },
  --   config = function()
  --     require "configs.lspconfig"
  --     local lspconfig = require "lspconfig"
  --
  --     -- Common LSP settings for auto-imports and code completion
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     local on_attach = function(client, bufnr)
  --       -- Enable completion triggered by <c-x><c-o>
  --       vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  --
  --       -- Common keymappings
  --       local bufopts = { noremap = true, silent = true, buffer = bufnr }
  --       vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  --       vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  --       vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  --       vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  --       vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  --       vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  --       vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  --       vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  --       vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  --       vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  --       vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  --
  --       -- Format on save
  --       if client.server_capabilities.documentFormattingProvider then
  --         vim.api.nvim_create_autocmd("BufWritePre", {
  --           buffer = bufnr,
  --           callback = function()
  --             vim.lsp.buf.format { async = false }
  --           end,
  --         })
  --       end
  --
  --       -- Enable inlay hints if available
  --       -- if client.server_capabilities.inlayHintProvider then
  --       --   vim.lsp.inlay_hint(bufnr, true)
  --       -- end
  --     end
  --     -- Solidity Language Configuration
  --     lspconfig.solidity_ls.setup({
  --       on_attach = on_attach, -- probably you will need this.
  --       capabilities = capabilities,
  --       filetypes = { "solidity" },
  --       root_dir = lspconfig.util.root_pattern("hardhat.config.*", ".git")
  --     })
  --     -- TypeScript/JavaScript configuration
  --     lspconfig.ts_ls.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         typescript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "all",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = true,
  --             includeInlayVariableTypeHints = true,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --           suggest = {
  --             completeFunctionCalls = true,
  --             autoImports = true,
  --           },
  --         },
  --         javascript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "all",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = true,
  --             includeInlayVariableTypeHints = true,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --           suggest = {
  --             completeFunctionCalls = true,
  --             autoImports = true,
  --           },
  --         },
  --       },
  --     }
  --     --Java Language Server Configuration
  --     lspconfig.jdtls.setup {
  --       cmd = { "jdtls", "-configuration", "-jar", "path/to/jdtls.jar" },
  --       settings = {
  --         java = {
  --           signatureHelp = { enabled = true },
  --           import = { enabled = true },
  --           rename = { enabled = true },
  --         },
  --       },
  --     }
  --     -- Golang configuration
  --     lspconfig.gopls.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         gopls = {
  --           analyses = {
  --             unusedparams = true,
  --           },
  --           staticcheck = true,
  --           gofumpt = true,
  --           usePlaceholders = true,
  --           completeUnimported = true,
  --           experimentalPostfixCompletions = true,
  --         },
  --       },
  --     }
  --
  --     -- Prisma configuration
  --     lspconfig.prismals.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       filetypes = { "prisma" },
  --       settings = {
  --         prisma = {
  --           enableFormatter = true,
  --           autoFormat = true,
  --         },
  --       },
  --
  --     }
  --
  --     -- HTML configuration
  --     lspconfig.html.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         html = {
  --           format = {
  --             enable = true,
  --           },
  --           hover = {
  --             documentation = true,
  --             references = true,
  --           },
  --         },
  --       },
  --     }
  --
  --     -- CSS configuration
  --     lspconfig.cssls.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         css = {
  --           lint = {
  --             unknownAtRules = "ignore",
  --           },
  --         },
  --       },
  --     }
  --
  --     -- Tailwind configuration
  --     lspconfig.tailwindcss.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         tailwindCSS = {
  --           experimental = {
  --             classRegex = {
  --               "tw`([^`]*)",
  --               'tw="([^"]*)',
  --               'tw={"([^"}]*)',
  --               "tw\\.\\w+`([^`]*)",
  --               "tw\\(.*?\\)`([^`]*)",
  --             },
  --           },
  --         },
  --       },
  --     }
  --
  --     -- Lua configuration
  --     lspconfig.lua_ls.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         Lua = {
  --           diagnostics = {
  --             globals = { "vim" },
  --           },
  --           workspace = {
  --             library = vim.api.nvim_get_runtime_file("", true),
  --             checkThirdParty = false,
  --           },
  --           telemetry = {
  --             enable = false,
  --           },
  --         },
  --       },
  --     }
  --     -- python
  --     lspconfig.pyright.setup {
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = {
  --         python = {
  --           analysis = {
  --             typeCheckingMode = "basic",
  --             autoImportCompletions = true,
  --             autoSearchPaths = true,
  --             useLibraryCodeForTypes = true,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
    end,
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "bash", "css", "typescript", "tsx", "json", "java", "go", "markdown", "markdown_inline", "prisma", "python" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        ignore_install = {},
        modules = {}
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

  -- NOTE: Github copilot is disabled for now
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  --   config = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.g.copilot_tab_fallback = ""
  --   end,
  -- },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"
      -- REQUIRED
      harpoon:setup {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function()
            return vim.loop.cwd()
          end,
        },
      }
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end,
  },
  -- Code Snippte plugin
  { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",                -- Use latest v2 release
    build = "make install_jsregexp", -- Optional: improves regex-based snippets
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local screen_width = vim.o.columns
      local window_width = 50
      local window_height = vim.o.lines - 2

      require("nvim-tree").setup {
        actions = {
          remove_file = {
            close_window = true,
            trash = {
              cmd             = "trash",
              require_confirm = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = {},
        },
        git = {
          enable = true,
          ignore = false,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "all",
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              git = true,
            },
          },
        },
        view = {
          float = {
            enable = true,
            open_win_config = {
              relative = "editor",
              border = "none",
              width = window_width,
              height = window_height,
              row = 1,                  -- Center vertically
              col = (screen_width - 0), -- Center horizontally
            },
          },
        },
      }
    end
  }
  ,
  -- Luasnip-Markdown-snippets.nvim
  {
    "LukasKorotaj/Luasnip-Markdown-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = true,
  },
  -- Clok nvim hedes the env
  {
    'laytan/cloak.nvim',
    event = { 'BufReadPre', 'BufNewFile' }, -- load when opening files
    config = function()
      local cloak = require('cloak')

      cloak.setup({
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        cloak_telescope = true,

        patterns = {
          {
            file_pattern = { '.env*' },
            cloak_pattern = '=.+',
          },
        },
      })

      -- Optional: automatically enable cloaking only for `.env` files
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = '.env*',
        callback = function()
          cloak.enable()
        end,
      })

      -- Keymap to toggle cloak manually
      vim.keymap.set('n', '<leader>tc', function()
        cloak.toggle()
        vim.notify('Cloak toggled', vim.log.levels.INFO, { title = 'cloak.nvim' })
      end, { desc = 'Toggle Cloak (cloak.nvim)' })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }

}





