-- ─────────────────────────────────────────────────────────────
-- Telescope (fuzzy finder) + extensions
-- ─────────────────────────────────────────────────────────────

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                extensions = {
                    fzf = {},
                },
            })

            telescope.load_extension("fzf")

            -- Search Neovim config files
            vim.keymap.set("n", "<space>tn", function()
                builtin.find_files({
                    cwd = vim.fn.stdpath("config"),
                })
            end, { desc = "Search Neovim config" })

            -- Search git tracked files
            vim.keymap.set("n", "<C-p>", function()
                builtin.git_files()
            end, { desc = "Search Git files" })
        end,
    },

    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").setup {
                extensions = {
                    media_files = {
                        filetypes = { "png", "jpg", "jpeg", "webp", "gif" },
                        find_cmd = "", -- or "fd"
                    },
                },
            }
            require("telescope").load_extension("media_files")
        end,
    },
}
