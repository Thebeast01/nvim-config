-- ─────────────────────────────────────────────────────────────
-- LSP
-- ─────────────────────────────────────────────────────────────
-- Server setup lives in lua/configs/lspconfig.lua.

return {
    {
        "neovim/nvim-lspconfig",
        -- Load only once a real file is opened (NvChad fires "User FilePost"),
        -- not on the dashboard/empty-buffer startup. Servers themselves still
        -- start on-demand per filetype via vim.lsp.enable().
        event = "User FilePost",
        config = function()
            require "configs.lspconfig"
        end,
    },
    -- Formatting/linting is handled by conform.nvim (formatting) and the
    -- eslint LSP (linting/fix-on-save); the archived null-ls plugin used to
    -- live here but was redundant and has been removed.
}
