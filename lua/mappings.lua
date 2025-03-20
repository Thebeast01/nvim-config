require "nvchad.mappings"


-- Add local here
local map = vim.keymap.set
local harpoon = require("harpoon")
local harpoon_ui = require("harpoon.ui")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Copilot Accept Suggestion
map("i", "<C-p>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true, replace_keycodes = false })

-- Git Blame Toggle
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true })

-- Toggle Relative Numbers
map("n", "<leader>r", ":set relativenumber!<CR>", { noremap = true, silent = true })

-- Harpoon: Add File
map("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Add file to Harpoon" })

-- -- Harpoon: Toggle Quick Menu
-- map("n", "<C-e>", function()
--   harpoon_ui.toggle_quick_menu(harpoon:list())
-- end, { desc = "Toggle Harpoon quick menu" })
-- Harpoon Navigation
map("n", "<leader>1", function()
  harpoon:list():select(1)
end)
map("n", "<leader>2", function()
  harpoon:list():select(2)
end)
map("n", "<leader>3", function()
  harpoon:list():select(3)
end)
map("n", "<leader>4", function()
  harpoon:list():select(4)
end)

-- Harpoon: Previous & Next
map("n", "<A-l>", function()
  harpoon:list():prev()
end, { desc = "Previous Harpoon file" })
map("n", "<A-k>", function()
  harpoon:list():next()
end, { desc = "Next Harpoon file" })

-- Harpoon: Clear List
map("n", "<leader>hc", function()
  harpoon:list():clear()
end, { desc = "Clear Harpoon list" })

-- Markdown Preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })

-- Toggle Tabline
map("n", "<leader>tt", function()
  vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
end, { desc = "Toggle tabline visibility" })

-- For pasting something over something  without loosing the copied text
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true })
-- To move selected line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- CMP Autocompletion Setup
local cmp = require("cmp")
cmp.setup {
  mapping = {
    -- Use Tab to navigate through and select completion items
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Use Shift+Tab to go backwards in completion menu
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Accept currently selected item using Enter
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
}
