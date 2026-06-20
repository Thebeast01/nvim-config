-- ─────────────────────────────────────────────────────────────
-- Markdown
-- ─────────────────────────────────────────────────────────────

return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require("markview").setup({
                render_delay = 150,
            })
        end,
        -- Completion for `blink.cmp`
        -- dependencies = { "saghen/blink.cmp" },
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
}
