-- ─────────────────────────────────────────────────────────────
-- Completion & Snippets
-- ─────────────────────────────────────────────────────────────

return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- NOTE: supermaven-nvim is loaded separately with lazy = false
            -- Do NOT add it here as a dependency or it causes a load deadlock
        },
        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },

            appearance = {
                nerd_font_variant = "mono",
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            sources = {
                -- FIX: added 'supermaven' as a completion source
                default = { "lsp", "path", "snippets", "buffer", "supermaven" },
                providers = {
                    supermaven = {
                        name = "supermaven",
                        module = "blink.compat.source",
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- Code snippet engine
    { "rafamadriz/friendly-snippets" },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Use latest v2 release
        -- jsregexp is an optional speed-up that needs `make`; skip the build on
        -- Windows (no make) so LuaSnip still installs cleanly there.
        build = vim.fn.has "win32" == 0 and "make install_jsregexp" or nil,
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "LukasKorotaj/Luasnip-Markdown-snippets.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
        config = true,
    },

    -- FIX: nvim-cmp commented out in favour of blink.cmp above.
    -- Keeping it here for reference. If you want to switch back:
    --   1. Uncomment this block
    --   2. Comment out the blink.cmp block above
    --   3. Set disable_inline_completion = false in supermaven (it will render its own ghost text)
    --      OR set it to true and add { name = "supermaven" } to cmp sources
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-cmdline",
    --         "roobert/tailwindcss-colorizer-cmp.nvim",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         local colorizer = require("tailwindcss-colorizer-cmp")
    --         cmp.setup {
    --             formatting = {
    --                 format = colorizer.formatter,
    --             },
    --             sources = {
    --                 { name = "supermaven" },
    --                 { name = "nvim_lsp" },
    --                 { name = "buffer" },
    --                 { name = "path" },
    --             },
    --         }
    --     end,
    -- },
}
