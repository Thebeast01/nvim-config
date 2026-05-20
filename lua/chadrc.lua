-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
    theme = "gruvchad",
    transparency= true,
    theme_toggle = { "gruvchad", "gruvchad" },
    hl_override = {
        Comment = {
            fg = "#e8a093",
            italic = true
        },
        ["@comment"] = {
            fg = "#8790b7",
            italic = true
        },
        Variable = {
            italic = true,
        },
        CursorLineNr = {
            fg = "#FFA555"
        },
        LineNr = {
            fg = "#765e93"
        },
        ["@variable"] = {
            italic = true,
        },

    },
}

M.nvdash = {
    load_on_startup = true,

    header = {
        " ███████████  ██████████   █████████    █████████  ███████████",
        "░░███░░░░░███░░███░░░░░█  ███░░░░░███  ███░░░░░███░█░░░███░░░█",
        " ░███    ░███ ░███  █ ░  ░███    ░███ ░███    ░░░ ░   ░███  ░ ",
        " ░██████████  ░██████    ░███████████ ░░█████████     ░███    ",
        " ░███░░░░░███ ░███░░█    ░███░░░░░███  ░░░░░░░░███    ░███    ",
        " ░███    ░███ ░███ ░   █ ░███    ░███  ███    ░███    ░███    ",
        " ███████████  ██████████ █████   █████░░█████████     █████   ",
        "░░░░░░░░░░░  ░░░░░░░░░░ ░░░░░   ░░░░░  ░░░░░░░░░     ░░░░░    ",

        "Welcome Beast  🔥",
        "                                      ",
        "                                      ",
    },
}
vim.fn.timer_start(1000, function()
    vim.cmd("redrawstatus")
end, { ["repeat"] = -1 })
vim.api.nvim_set_hl(0, "StatusTime", {
    fg = "#f5a97f",
    bg = "NONE",
    italic = true,
})
M.ui = {
     -- lazyload it when there are 1+ buffers
     tabufline = {
       enabled = true,
       lazyload = true,
       treeOffsetFt = "NvimTree",
       order = { "treeOffset", "buffers", "tabs", "btns" },
       modules = nil,
       bufwidth = 21,
     }, 
    statusline = {
       theme = "minimal", -- default/vscode/vscode_colored/minimal
        separator_style = "default",
        order = {
            "mode",
            "file",
            "%=", -- push next modules to center
            "time",
            "git",
            "diagnostics",
            "lsp",
            "%=", -- push remaining to right
            "cwd",
            "cursor",
        },
        modules ={
            pwd = function()
                local pwd = vim.fn.getcwd()
                local folder = vim.fn.fnamemodify(pwd, ":t")
                return " " .. folder .. " "
            end,
            time = function()
            -- 12 hour format
            return "%#StatusTime#󰥔 " .. os.date("%I:%M:%S") .. " "
            
            -- 24 hour format:
            -- return "󰥔 " .. os.date("%H:%M") .. " "
            end,
        }
    },
     cmp = {
       lspkind_text = true,
       style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
       format_colors = {
         lsp = true,
       },
     },
    telescope = {
        style = "borderless",
        results_color = "gruvchad",
        preview_color = "gruvchad",
    },
   colorify = {
     enabled = true,
     mode = "virtual", -- fg, bg, virtual
     virt_text = "󱓻 ",
     highlight = { hex = true, lspvars = false },
   },
}
return M
