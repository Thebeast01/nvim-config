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
        -- Use the plugin's built-in installer instead of `cd app && yarn install`;
        -- it works cross-platform (incl. Windows) and doesn't need a Unix shell
        -- or a global yarn.
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
}
