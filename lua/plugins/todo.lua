-- ─────────────────────────────────────────────────────────────
-- Todo: highlight comments + standalone todo manager
-- ─────────────────────────────────────────────────────────────

return {
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup {
                signs = true,
                keywords = {
                    FIX    = { icon = "", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
                    TODO   = { icon = "", color = "info" },
                    HACK   = { icon = "", color = "warning" },
                    WARN   = { icon = "", color = "warning", alt = { "WARNING" } },
                    PERF   = { icon = "", color = "hint", alt = { "OPTIM", "PERFORMANCE" } },
                    NOTE   = { icon = "", color = "info", alt = { "INFO" } },
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
        "BeastInBash/todos.nvim",
        event = "VeryLazy", -- lazy-load on first real event
        keys = {
            { "<leader>td", desc = "Todo: Open UI" },
            { "<leader>ta", desc = "Todo: Add" },
            { "<leader>tt", desc = "Todo: Toggle" },
            { "<leader>ts", desc = "Todo: Switch scope" },
        },
        config = function()
            require("todo-nvim").setup({
                -- default scope when opening: "project" | "global"
                default_scope = "project",

                -- storage paths (optional overrides)
                storage = {
                    global_path      = vim.fn.stdpath("data") .. "/todo/global.json",
                    project_filename = ".nvim/todo.json",
                },

                -- floating window proportions
                ui = {
                    width       = 0.8, -- fraction of editor width
                    height      = 0.8, -- fraction of editor height
                    border      = "rounded",
                    split_ratio = 0.4, -- left panel fraction
                },

                -- global keymaps (outside the window)
                keymaps = {
                    open   = "<leader>td",
                    add    = "<leader>ta",
                    toggle = "<leader>tt",
                    scope  = "<leader>ts",
                },

                -- in-panel keymaps
                panel_keymaps = {
                    add       = "a",
                    delete    = "d",
                    edit      = "e",
                    toggle    = "<CR>",
                    close     = "q",
                    scope     = "s",
                    next_prio = "p",
                    move_down = "J",
                    move_up   = "K",
                    help      = "?",
                },
                color = {
                    base = "#171717",
                },
            })
        end,
    },
}
