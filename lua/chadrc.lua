-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
  theme = "rosepine",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = {
      italic = true,
      -- fg = "#5F7D95", -- Pale Light blue
      fg = "#7E6B8F", -- Pale Lavander
      -- fg = "#8C7E6B" -- Warm Taupe
      -- fg = "#6e9695" -- Pale Green
      -- fg = "#6E8B7F" -- Pale Blue
      --underdashed = true

    },
  },
}
return M
