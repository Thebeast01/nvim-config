-- ─────────────────────────────────────────────────────────────
-- Formatting
-- ─────────────────────────────────────────────────────────────
-- Formatter mappings live in lua/configs/conform.lua.

return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- format on save
        opts = require "configs.conform",
    },
}
