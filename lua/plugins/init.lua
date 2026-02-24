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
    -- {
    --     'wsdjeg/calendar.nvim',
    -- },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup({
                '*', -- Apply to all file types
            }, {
                mode = 'background',
                css = true, -- Enable all CSS features
                -- tailwind = true, -- Enable tailwind colors
            })
        end
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,

        -- Completion for `blink.cmp`
        -- dependencies = { "saghen/blink.cmp" },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "*", -- Highlight in all filetypes
                css = { rgb_fn = true, },
                html = { names = false, },
            })
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

    {
        'wakatime/vim-wakatime',
        lazy = false
    },

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
                enabled = true, -- disable Noice messages
            },
            notify = {
                enabled = true, -- disable Noice notifications
            },
            popupmenu = {
                enabled = false, -- disable popupmenu UI
            },
            cmdline = {
                enabled = true, -- keep cmdline enabled
            },
            lsp = {
                progress = {
                    enabled = true, -- disable LSP progress spinner
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
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
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
    },
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
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "amongus",
                options = {
                    multilines = {
                        enabled = true,
                    },

                    softwrap = 30,
                    overflow = {
                        mode = "wrap",
                        padding = 2,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },


    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        'vyfor/cord.nvim',
        build = ':Cord update',
        event = "VeryLazy",
        opts = {
            text = {
                editing = 'Editing ${filename}',
                file_browser = 'Browsing files in ${tooltip}',
            },
            variables = true, -- Enable string templates

        }
    },
    -- {
    --   "Isrothy/neominimap.nvim",
    --   version = "v3.x.x",
    --   lazy = false, -- NOTE: NO NEED to Lazy load
    --   -- Optional. You can also set your own keybindings
    --   keys = {
    --     -- Global Minimap Controls
    --     { "<leader>nm",  "<cmd>Neominimap Toggle<cr>",      desc = "Toggle global minimap" },
    --     { "<leader>no",  "<cmd>Neominimap Enable<cr>",      desc = "Enable global minimap" },
    --     { "<leader>nc",  "<cmd>Neominimap Disable<cr>",     desc = "Disable global minimap" },
    --     { "<leader>mr",  "<cmd>Neominimap Refresh<cr>",     desc = "Refresh global minimap" },
    --
    --     -- Window-Specific Minimap Controls
    --     { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>",   desc = "Toggle minimap for current window" },
    --     { "<leader>nwr", "<cmd>Neominimap WinRefresh<cr>",  desc = "Refresh minimap for current window" },
    --     { "<leader>nwo", "<cmd>Neominimap WinEnable<cr>",   desc = "Enable minimap for current window" },
    --     { "<leader>nwc", "<cmd>Neominimap WinDisable<cr>",  desc = "Disable minimap for current window" },
    --
    --     -- Tab-Specific Minimap Controls
    --     { "<leader>ntt", "<cmd>Neominimap TabToggle<cr>",   desc = "Toggle minimap for current tab" },
    --     { "<leader>ntr", "<cmd>Neominimap TabRefresh<cr>",  desc = "Refresh minimap for current tab" },
    --     { "<leader>nto", "<cmd>Neominimap TabEnable<cr>",   desc = "Enable minimap for current tab" },
    --     { "<leader>ntc", "<cmd>Neominimap TabDisable<cr>",  desc = "Disable minimap for current tab" },
    --
    --     -- Buffer-Specific Minimap Controls
    --     { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>",   desc = "Toggle minimap for current buffer" },
    --     { "<leader>nbr", "<cmd>Neominimap BufRefresh<cr>",  desc = "Refresh minimap for current buffer" },
    --     { "<leader>nbo", "<cmd>Neominimap BufEnable<cr>",   desc = "Enable minimap for current buffer" },
    --     { "<leader>nbc", "<cmd>Neominimap BufDisable<cr>",  desc = "Disable minimap for current buffer" },
    --
    --     ---Focus Controls
    --     { "<leader>mf",  "<cmd>Neominimap Focus<cr>",       desc = "Focus on minimap" },
    --     { "<leader>mu",  "<cmd>Neominimap Unfocus<cr>",     desc = "Unfocus minimap" },
    --     { "<leader>ms",  "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
    --   },
    --   init = function()
    --     -- The following options are recommended when layout == "float"
    --     vim.opt.wrap = false
    --     vim.opt.sidescrolloff = 36 -- Set a large value
    --
    --     --- Put your configuration here
    --     ---@type Neominimap.UserConfig
    --     vim.g.neominimap = {
    --       auto_enable = true,
    --     }
    --   end,
    -- }
}
