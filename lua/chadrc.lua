-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}
M.base46 = {
  theme = "rosepine",
  transparency = true,
  theme_toggle = { "onedark", "one_light" },
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
    }
  },
}


M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = true,
    show_filename_only = true,
  },

  statusline = {
    theme = "minimal",
    separator_style = "arrow",
  },
  theme_toggle = { "rosepine", "everblush" },
  cmp = {
    style = "default",
    border_color = "rosepine",
    kind_icon = "rosepine",
    kind_text = "rosepine",
  },
  telescope = {
    style = "borderless",
    border_color = "rosepine",
    results_color = "rosepine",
    preview_color = "rosepine",
  },
}

return M
