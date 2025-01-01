return {
  -- Try to learn about vim fugitive
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  { "rose-pine/neovim", name = "rose-pine" },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   opts = {},
  -- },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        ---@class snacks.dashboard.Config
        ---@field enabled? boolean
        ---@field sections snacks.dashboard.Section
        ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
        {
          width = 60,
          row = nil, -- dashboard position. nil for center
          col = nil, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
          -- These settings are used by some built-in sections
          preset = {
            -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
            ---@type fun(cmd:string, opts:table)|nil
            pick = nil,
            -- Used by the `keys` section to show keymaps.
            -- Set your custom keymaps here.
            -- When using a function, the `items` argument are the default keymaps.
            ---@type snacks.dashboard.Item[]
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
              {
                icon = " ",
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
            -- Used by the `header` section
            header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          },
          -- item field formatters
          formats = {
            icon = function(item)
              if item.file and item.icon == "file" or item.icon == "directory" then
                return M.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match "^(.*)/(.+)$"
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
          },
          sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
            {
              section = "terminal",
              cmd = "ascii-image-converter --width 30 --height 30 ./logo.png -C -c",
              random = 10,
              pane = 2,
              indent = 4,
              height = 30,
            },
          },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
  },
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
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
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

      -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
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
}
