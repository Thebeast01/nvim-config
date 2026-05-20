require "nvchad.options"

local opt = vim.opt
local g = vim.g

-----------------------------------------------------------
-- GENERAL
-----------------------------------------------------------

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.hidden = true
opt.errorbells = false
opt.visualbell = false

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

opt.updatetime = 250
opt.timeoutlen = 400
opt.ttimeoutlen = 10

opt.autoread = true
opt.confirm = true

-- opt.shell = "zsh"
-- opt.history = 1000

-----------------------------------------------------------
-- INDENTATION
-----------------------------------------------------------

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- opt.smarttab = true
-- opt.shiftround = true
-- opt.copyindent = true
-- opt.preserveindent = true
-- opt.breakindentopt = "shift:2"
-- opt.cindent = true
-- opt.cinoptions = ""
-- opt.wrapmargin = 0

-----------------------------------------------------------
-- SEARCH
-----------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = true
opt.incsearch = true

-- opt.gdefault = true
-- opt.inccommand = "split"

-----------------------------------------------------------
-- UI
-----------------------------------------------------------

opt.number = false
opt.relativenumber = true

opt.cursorline = true
opt.cursorlineopt = "both"

opt.termguicolors = true
opt.signcolumn = "yes"

opt.scrolloff = 10
opt.sidescrolloff = 10

opt.cmdheight = 0
opt.laststatus = 3

opt.showmode = false
opt.showcmd = false
opt.ruler = false

opt.splitbelow = true
opt.splitright = true

opt.pumheight = 10

opt.winblend = 0
opt.pumblend = 0

opt.conceallevel = 0

-- opt.colorcolumn = "100"
-- opt.foldcolumn = "1"
-- opt.fillchars = {
--   eob = " ",
--   fold = " ",
--   foldopen = "",
--   foldclose = "",
-- }

-- opt.guifont = "JetBrainsMono Nerd Font:h14"

-----------------------------------------------------------
-- WRAPPING
-----------------------------------------------------------

opt.wrap = true
opt.linebreak = true
opt.breakindent = true

opt.textwidth = 120
opt.formatoptions:append "t"

-- opt.showbreak = "↪ "
-- opt.breakat = [[\ \	;:,!?]]
-- opt.colorcolumn = "120"

-----------------------------------------------------------
-- FOLDING
-----------------------------------------------------------

opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- opt.foldmethod = "indent"
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = ""
-- opt.foldnestmax = 3

-----------------------------------------------------------
-- COMPLETION
-----------------------------------------------------------

opt.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

-- opt.wildmode = "longest:full,full"
-- opt.wildignorecase = true

-----------------------------------------------------------
-- FILES & BUFFERS
-----------------------------------------------------------

opt.bufhidden = "hide"

-- opt.sessionoptions = {
--   "buffers",
--   "curdir",
--   "tabpages",
--   "winsize",
-- }

-----------------------------------------------------------
-- WHITESPACE / CHARACTERS
-----------------------------------------------------------

opt.list = false

-- opt.listchars = {
--   tab = "→ ",
--   trail = "•",
--   extends = "❯",
--   precedes = "❮",
--   nbsp = "␣",
-- }

-----------------------------------------------------------
-- CURSOR
-----------------------------------------------------------

opt.guicursor = ""
-- opt.guicursor =
--   "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-----------------------------------------------------------
-- SPELL CHECK
-----------------------------------------------------------

opt.spell = false

-- opt.spelllang = { "en_us" }

-----------------------------------------------------------
-- PERFORMANCE
-----------------------------------------------------------

opt.lazyredraw = false
-- opt.synmaxcol = 300

-----------------------------------------------------------
-- NETRW
-----------------------------------------------------------

-- g.netrw_banner = 0
-- g.netrw_liststyle = 3
-- g.netrw_browse_split = 0
-- g.netrw_winsize = 25

-----------------------------------------------------------
-- DIAGNOSTICS
-----------------------------------------------------------

vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,

    -- virtual_lines = false,
    -- float = {
    --   border = "rounded",
    --   source = "always",
    -- },
}

-----------------------------------------------------------
-- STATUSCOLUMN
-----------------------------------------------------------

-- vim.opt.statuscolumn =
-- [[%!v:lua.require('statuscol').get() ]]

-----------------------------------------------------------
-- UNDO DIRECTORY
-----------------------------------------------------------

-- opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-----------------------------------------------------------
-- BACKUP DIRECTORY
-----------------------------------------------------------

-- opt.backupdir = vim.fn.stdpath("cache") .. "/backup"
-- opt.directory = vim.fn.stdpath("cache") .. "/swp"

-----------------------------------------------------------
-- SESSION
-----------------------------------------------------------

-- vim.o.sessionoptions =
-- "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-----------------------------------------------------------
-- SMOOTH SCROLLING
-----------------------------------------------------------

-- opt.smoothscroll = true

-----------------------------------------------------------
-- DIFF
-----------------------------------------------------------

-- opt.diffopt:append("vertical")
-- opt.diffopt:append("linematch:60")

-----------------------------------------------------------
-- MARKDOWN
-----------------------------------------------------------

-- vim.g.markdown_recommended_style = 0

-----------------------------------------------------------
-- TRANSPARENCY
-----------------------------------------------------------

-- vim.cmd([[
--   highlight Normal guibg=NONE ctermbg=NONE
--   highlight NormalNC guibg=NONE ctermbg=NONE
--   highlight EndOfBuffer guibg=NONE ctermbg=NONE
-- ]])

-----------------------------------------------------------
-- CUSTOM KEYMAP FRIENDLY OPTIONS
-----------------------------------------------------------

opt.whichwrap:append "<>[]hl"

-----------------------------------------------------------
-- BETTER SPLITS
-----------------------------------------------------------

-- vim.cmd("set splitkeep=screen")

-----------------------------------------------------------
-- TREESITTER
-----------------------------------------------------------

-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-----------------------------------------------------------
-- TERMINAL
-----------------------------------------------------------

-- opt.shellcmdflag = "-ic"

-----------------------------------------------------------
-- COMMAND LINE
-----------------------------------------------------------

-- opt.wildmenu = true
-- opt.wildignore:append({
--   "*.o",
--   "*.obj",
--   "*.pyc",
--   "*.class",
-- })

-----------------------------------------------------------
-- EXTRA NICE OPTIONS
-----------------------------------------------------------

-- opt.shortmess:append("c")
-- opt.shortmess:append("sI")

-- opt.iskeyword:append("-")

-- opt.path:append("**")

-- opt.selection = "exclusive"

-- opt.virtualedit = "block"

-- opt.showmatch = true
-- opt.matchtime = 2

-----------------------------------------------------------
-- NOTES
-----------------------------------------------------------

-- :h option-list
-- :h options
-- :h 'option-name'
--
-- Example:
-- :h wrap
-- :h number
-- :h relativenumber
--
-- To inspect current value:
-- :set wrap?
-- :set number?
--
-- To see all changed options:
-- :set
--
-- To reset an option:
-- :set option&
--
-- Lua:
-- vim.opt.wrap = true
-- vim.opt.number = false
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
