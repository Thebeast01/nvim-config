
vim.opt.swapfile = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.relativenumber = true
vim.opt.columns = 170
vim.opt.linebreak = true
vim.opt.wrap = true
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.opt.cmdheight = 0
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter-based folding
vim.o.foldlevel = 99                          -- keep folds open by default
vim.o.foldenable = true
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.conceallevel = 2
    vim.opt.concealcursor = "nc"
  end,
})
vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"


vim.schedule(function()
  require "mappings"
end)
-- Conceal Levels

-- Maintain at least 5 empty lines after cursor


-- vim.api.nvim_create_autocmd("CursorMoved", {
--   pattern = "*",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--
--     -- Only run for normal editable buffers
--     if not vim.bo[bufnr].modifiable then
--       return
--     end
--     if vim.bo[bufnr].buftype ~= "" then
--       -- skip non-file buffers like NvimTree, terminal, help
--       return
--     end
--
--     local unpack = table.unpack or unpack
--     local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
--     local line_count = vim.api.nvim_buf_line_count(0)
--
--     -- Number of lines that should always exist below the cursor
--     local min_gap = 5
--     local lines_below = line_count - row
--
--     if lines_below < min_gap then
--       local to_add = min_gap - lines_below
--       local blank_lines = {}
--       for _ = 1, to_add do
--         table.insert(blank_lines, "")
--       end
--       vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, blank_lines)
--     end
--   end,
-- })


