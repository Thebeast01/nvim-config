-- ─────────────────────────────────────────────────────────────
-- Treesitter
-- ─────────────────────────────────────────────────────────────

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- Only use setup() if you want a custom install directory
            -- You DON'T need it for highlighting!
            require("nvim-treesitter").install({
                "lua", "vim", "vimdoc", "javascript", "html",
                "bash", "css", "typescript", "tsx", "json",
                "java", "go", "markdown", "markdown_inline", "prisma", "python"
            })

            -- THIS is what enables highlighting now (Neovim built-in)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "javascript", "typescript", "tsx", "lua", "html",
                    "css", "json", "python", "go", "java", "bash",
                    "markdown", "prisma"
                },
                callback = function()
                    vim.treesitter.start() -- syntax highlighting
                end,
            })
        end,
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
}
