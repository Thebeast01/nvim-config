-- ─────────────────────────────────────────────────────────────
-- Editor: file tree, secret cloaking, tmux navigation
-- ─────────────────────────────────────────────────────────────

return {
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
        end,
    },

    -- cloak.nvim hides secrets in .env files
    {
        "laytan/cloak.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- load when opening files
        config = function()
            local cloak = require("cloak")

            cloak.setup({
                enabled = true,
                cloak_character = "*",
                highlight_group = "Comment",
                cloak_telescope = true,

                patterns = {
                    {
                        file_pattern = { ".env*" },
                        cloak_pattern = "=.+",
                    },
                },
            })

            -- Optional: automatically enable cloaking only for `.env` files
            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = ".env*",
                callback = function()
                    cloak.enable()
                end,
            })

            -- Keymap to toggle cloak manually
            vim.keymap.set("n", "<leader>tc", function()
                cloak.toggle()
                vim.notify("Cloak toggled", vim.log.levels.INFO, { title = "cloak.nvim" })
            end, { desc = "Toggle Cloak (cloak.nvim)" })
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
}
