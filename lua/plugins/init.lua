return {
  -- Try to learn about vim fugitive
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- Surround Plugin tpope/vim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- Obsidian.nvim config  start

  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },
  },

  -- Obsidian Config end here

  { "rose-pine/neovim",      name = "rose-pine" },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({

      })
    end
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   opts = {},
  -- },
  { "ellisonleao/glow.nvim",       config = true, cmd = "Glow" },

  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        transparent_background = true,
      },
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd [[colorscheme tokyodark]]
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
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
          light = "lotus",
        },
      }
    end,
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Common keymappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

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
      -- Solidity Language Configuration
      lspconfig.solidity_ls.setup({
        on_attach = on_attach, -- probably you will need this.
        capabilities = capabilities,
        filetypes = { "solidity" },
        root_dir = lspconfig.util.root_pattern("hardhat.config.*", ".git")
      })
      -- TypeScript/JavaScript configuration
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
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
              includeInlayParameterNameHints = "all",
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
      --Java Language Server Configuration
      lspconfig.jdtls.setup {
        cmd = { "jdtls", "-configuration", "-jar", "path/to/jdtls.jar" },
        settings = {
          java = {
            signatureHelp = { enabled = true },
            import = { enabled = true },
            rename = { enabled = true },
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
              unknownAtRules = "ignore",
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
                'tw="([^"]*)',
                'tw={"([^"}]*)',
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
              globals = { "vim" },
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
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
    end,
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  },
  {
    "tpope/vim-fugitive",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
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
  -- {
  -- "andweeb/presence.nvim",
  -- event = "VeryLazy",
  -- priority = 950,
  -- config = function()
  --   vim.g.presence_debug = true
  --
  --   local presence = require "presence"
  --
  --   presence.setup {
  --     auto_update = true,
  --     neovim_image_text = "neovim",
  --     main_image = "neovim",
  --     debounce_timeout = 10,
  --     log_level = "debug",
  --     enable_line_number = true,
  --     editing_text = "Editing %s",
  --     file_explorer_text = "Browsing %s",
  --     git_commit_text = "Committing changes",
  --     plugin_manager_text = "Managing plugins",
  --     reading_text = "Reading %s",
  --     workspace_text = "Working on %s",
  --     client_id = "793271441293967371",
  --     line_number_text = "Line %s out of %s",
  --   }
  --   presence:update()
  -- end,
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
      --
      -- -- Navigation
      -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
      --
      -- -- Additional useful keymaps
      -- -- Navigate to next/previous files in list
      -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
      --
      -- -- Optional: Display length of Harpoon list
      -- vim.keymap.set("n", "<leader>hl", function()
      --     print(harpoon:list():length())
      -- end)

      -- Optional: Clear all marks
      -- vim.keymap.set("n", "<leader>hc", function()
      --     harpoon:list():clear()
      -- end)
    end,
  },

  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-jdtls" },

  -- Code Snippte plugin
  { "rafamadriz/friendly-snippets" },
  {

    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    require("luasnip.loaders.from_vscode").load { include = { "python", "JavaScript", "Java", "HTML" } }, -- Load only python snippets

    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local screen_width = vim.o.columns
      local screen_height = vim.o.lines

      local window_width = 50
      local window_height = 20

      require("nvim-tree").setup {
        view = {
          float = {
            enable = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = window_width,
              height = window_height,
              row = (screen_height - window_height) / 2, -- Center vertically
              col = (screen_width - window_width) / 2,   -- Center horizontally
            },
          },
        },
      }
    end
  }
  ,
}
