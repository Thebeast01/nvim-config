require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local harpoon = require("harpoon")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-p>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true, replace_keycodes = false })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map('n', '<leader>r', ':set relativenumber!<CR>', { noremap = true, silent = true })
-- harpoon
map("n", "<leader>a", function() harpoon:list():append() end)
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Navigation
map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>4", function() harpoon:list():select(4) end)

-- Additional useful keymaps
-- Navigate to next/previous files in list
map("n", "<a-l>", function() harpoon:list():prev() end)
map("n", "<a-k>", function() harpoon:list():next() end)
map("n", "<leader>hc", function()
  harpoon:list():clear()
end)
-- Markdown Preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })

local cmp = require "cmp"

cmp.setup({
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
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
})
