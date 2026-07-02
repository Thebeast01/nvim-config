-- ─────────────────────────────────────────────────────────────
-- Coding helpers: comments, autopairs, harpoon
-- ─────────────────────────────────────────────────────────────

return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },

        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },

        config = function()
            -- Treesitter context support (important for TSX/JSX)
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = nil,

                toggler = {
                    line = "gcc",  -- line comment
                    block = "gbc", -- block comment
                },

                opleader = {
                    line = "gc",  -- visual line comment
                    block = "gb", -- visual block comment
                },

                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },

                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
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
}
