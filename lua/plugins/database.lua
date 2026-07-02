-- ─────────────────────────────────────────────────────────────
-- Database tooling: dadbod UI + pg-docker
-- ─────────────────────────────────────────────────────────────

return {
    { "tpope/vim-dadbod" },

    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    {
        "BeastInBash/pg-docker.nvim",
        cmd = { "PgCreate", "PgQuickStart", "PgStop", "PgRemove", "PgLogs", "PgList", "PgLog" },
        keys = {
            { "<leader>pgn", "<cmd>PgCreate<cr>",     desc = "pg-docker: new container" },
            { "<leader>pgq", "<cmd>PgQuickStart<cr>", desc = "pg-docker: quick start" },
            { "<leader>pgs", "<cmd>PgStop<cr>",       desc = "pg-docker: stop" },
            { "<leader>pgr", "<cmd>PgRemove<cr>",     desc = "pg-docker: remove" },
            { "<leader>pgl", "<cmd>PgLogs<cr>",       desc = "pg-docker: logs" },
            { "<leader>pgL", "<cmd>PgList<cr>",       desc = "pg-docker: list" },
        },
        opts = {},
    },
}
