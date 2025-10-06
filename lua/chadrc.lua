-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
  theme = "melange",
  transparency = true,
  theme_toggle = { "melange", "rosepine-dawn" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    String = {
      italic = true,
    },
    ['@string'] = {
      italic = true,
    },
    Function = {
      italic = true,
    },
    ['@function'] = {
      italic = true,
    },
    CursorLineNr = {
      fg = "#FFA555"

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

    "Welcome Beast to Your Coding Setup! 🔥",
    "                                      ",
    "                                      ",
  },
}

M.ui = {
  tabufline = {
    enabled = false,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
    bufwidth = 21,
  },
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
  cmp = {
    style = "default",
    border_color = "aquarium",
    kind_icon = "aquarium",
    kind_text = "aquarium",
  },
  telescope = {
    style = "bordered",
    results_color = "rosepine",
    preview_color = "rosepine",
  },
}

return M
