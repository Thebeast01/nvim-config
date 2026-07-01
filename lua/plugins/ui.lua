-- ─────────────────────────────────────────────────────────────
-- UI: noice, inline diagnostics, discord rich presence
-- ─────────────────────────────────────────────────────────────

return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            messages = {
                enabled = true,
            },
            notify = {
                enabled = true,
            },
            popupmenu = {
                enabled = false, -- disable popupmenu UI
            },
            cmdline = {
                enabled = true, -- keep cmdline enabled
            },
            lsp = {
                progress = {
                    enabled = true,
                },
                hover = {
                    enabled = false, -- disable hover UI
                },
                signature = {
                    enabled = false, -- disable signature help UI
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "amongus",
                options = {
                    multilines = {
                        enabled = true,
                    },

                    softwrap = 30,
                    overflow = {
                        mode = "wrap",
                        padding = 2,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },

    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        event = "VeryLazy",
        opts = {
            timestamp = {
                enabled = true,
                reset_on_idle = true,
                reset_on_change = false,
            },
            idle = {
                enabled = true,
                timeout = 300000, -- 5 minutes
                text = "Beating around the Bush",
                tooltip = "Probably debugging in my head",
            },
            text = {
                -- Editing messages — rotates per file via a custom hook
                editing = function(opts)
                    local victims = {
                        "⚔️ Beast Slaying bugs in " .. opts.filename,
                        "🔥 Beast Burning down " .. opts.filename,
                        "🧠 Beast Outsmarting " .. opts.filename,
                        "💀 Beast Murdering " .. opts.filename,
                        "🩸 Beast Bleeding into " .. opts.filename,
                        "🌀 Beast unleashing his fangs on " .. opts.filename,
                        "⚡ Overclocking : " .. opts.filename,
                        "🎯 Sniping bugs in : " .. opts.filename,
                        "😵‍💫 Frying Brain.exe : " .. opts.filename,
                    }
                    return victims[math.random(#victims)]
                end,
                file_browser = function(opts)
                    return "📂 Digging through " .. opts.tooltip
                end,
                plugin_manager = "📦 Updating the arsenal...",
                lsp_manager = "🔧 Calibrating the weapons",
                docs = "📖 Reading the forbidden scrolls",
                vcs = "🌿 Rewriting history in " .. "${tooltip}",
                notes = "📝 Plotting something...",
                -- Workspace status
                workspace = "in ${workspace}",
            },
            buttons = {
                {
                    label = "👾 My GitHub",
                    url = "https://github.com/thebeast01",
                },
            },
            variables = true,
        },
    },
}
