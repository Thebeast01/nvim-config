require "nvchad.mappings"

local map = vim.keymap.set
local builtin = require("telescope.builtin")
local harpoon = require("harpoon")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ─────────────────────────────────────────────────────────────
-- Editor Toggles
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>z", function()
    vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })

map("n", "<leader>r", ":set relativenumber!<CR>", { noremap = true, silent = true, desc = "Toggle relative numbers" })

map("n", "<leader>sp", function()
    vim.opt.spell = not vim.opt.spell:get()
    vim.notify(
        "Spell Check: " .. (vim.opt.spell:get() and "enabled" or "disabled"),
        vim.log.levels.INFO,
        { title = "Editor" }
    )
end, { desc = "Toggle spell check" })

map("n", "<leader>tt", function()
    vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
end, { desc = "Toggle tabline" })

-- ─────────────────────────────────────────────────────────────
-- LSP
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format buffer" })
map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
map("n", "gt", builtin.lsp_type_definitions, { desc = "Go to type definition" })
map("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" })
map("n", "gr", builtin.lsp_references, { desc = "References" })
map("n", "<leader>fl", builtin.lsp_references, { noremap = true, silent = true, desc = "LSP references" })

-- ─────────────────────────────────────────────────────────────
-- Telescope
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>fi", "<cmd>Telescope media_files<CR>", {
    noremap = true, silent = true, desc = "Find media files",
})

-- ─────────────────────────────────────────────────────────────
-- Find & Replace
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], {
    desc = "Replace word under cursor",
})
map("n", "<leader>fp", [[:%s/\<<C-r><C-w>\>//gc<Left><Left>]], {
    desc = "Replace word under cursor (confirm each)",
})

-- ─────────────────────────────────────────────────────────────
-- Editing Utilities
-- ─────────────────────────────────────────────────────────────

-- Paste over selection without clobbering register
map("x", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without overwriting register" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-- Create new file
map("n", "<leader>nf", function()
    local fname = vim.fn.input("New file: ")
    if fname ~= "" then vim.cmd("edit " .. fname) end
end, { desc = "Create new file" })

-- ─────────────────────────────────────────────────────────────
-- Harpoon
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: add file" })
map("n", "<leader>cc", function() harpoon:list():clear() end, { desc = "Harpoon: clear list" })
map("n", "<leader>mn", function() harpoon:list():prev() end, { desc = "Harpoon: previous file" })
map("n", "<leader>mf", function() harpoon:list():next() end, { desc = "Harpoon: next file" })

map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })

-- ─────────────────────────────────────────────────────────────
-- Noice
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>ml", function() require("noice").cmd("last") end, { desc = "Noice: last message" })
map("n", "<leader>mh", function() require("noice").cmd("history") end, { desc = "Noice: message history" })
map("n", "<leader>dn", function() require("noice").cmd("dismiss") end, { desc = "Noice: dismiss" })

-- ─────────────────────────────────────────────────────────────
-- Git
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {
    noremap = true, silent = true, desc = "Toggle git blame",
})
map("n", "<leader>td", ":Td<CR>", { noremap = true, silent = true })

-- ─────────────────────────────────────────────────────────────
-- Misc Plugins
-- ─────────────────────────────────────────────────────────────

map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true, desc = "Markdown preview" })
map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })

-- Copilot: accept suggestion
map("i", "<C-p>", "copilot#Accept('<CR>')", {
    noremap = true, silent = true, expr = true, replace_keycodes = false, desc = "Copilot accept",
})

-- ─────────────────────────────────────────────────────────────
-- Completion (cmp)
-- ─────────────────────────────────────────────────────────────

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item() else fallback() end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
})

-- ─────────────────────────────────────────────────────────────
-- Fold reference (no keymaps needed — built-in)
-- za  toggle fold   zc  close fold   zo  open fold
-- zM  close all     zR  open all
-- ─────────────────────────────────────────────────────────────
