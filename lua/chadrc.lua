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
    ["@comment"] = { italic = true },
    ["@variable"] = { italic = true },
    ["@function"] = { italic = true },
    ["@parameter"] = { italic = true },
    ["@method"] = { italic = true },
    ["@property"] = { italic = true },
    ["@field"] = { italic = true },
    ["@type"] = { italic = true },
    ["@return"] = { italic = true },
    ["@throws"] = { italic = true },
    ["@constructor"] = { italic = true },
    ["@deprecated"] = { italic = true },
  },
}

return M
