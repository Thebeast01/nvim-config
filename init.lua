vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

vim.g.mapleader = " "
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter-based folding
vim.o.foldlevel = 99                          -- keep folds open by default
vim.o.foldenable = true
-- Tabs & indentation (global for all languages)
vim.g.cord_defer_startup = true

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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:append("t")
    end
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
