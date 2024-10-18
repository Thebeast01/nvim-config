require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-p>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false })
map("n", "<leader>lo",  ':Lorem 100<CR>', { noremap = true, silent = true })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>",{})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
