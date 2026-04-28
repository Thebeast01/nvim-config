require("nvchad.configs.lspconfig").defaults()

-- LSP servers to enable
local servers = {
    "html",
    "prismals",
    "css_lsp",
    "eslint",
    -- "emmet_ls",
    "ts_ls",
    "sqlls",
    "tailwindcss-language-server",
    "typescript_language_server",
    "solang",
    "jdtls",
    "gopls",
    "postgres-language-server",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "clangd",
}

-- Enable all LSP servers
vim.lsp.enable(servers)
-- Note: prettierd is a formatter, not an LSP server
-- Configure it separately with conform.nvim or null-ls

-- ESLint-specific configuration
local eslint_config = vim.lsp.config.eslint or {}
local base_on_attach = eslint_config.on_attach
local base_capabilities = eslint_config.capabilities
local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}
vim.lsp.config('tailwindcss-language-server',{
    capabilities = base_capabilities,
    flags = lsp_flags
})

-- vim.lsp.config('emmet_ls',{
--    capabilities = base_capabilities,
--       flags = lsp_flags
-- })
vim.lsp.config("eslint", {
    on_attach = function(client, bufnr)
        -- Call base on_attach if it exists
        if base_on_attach then
            base_on_attach(client, bufnr)
        end

        -- Auto-fix on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.cmd("EslintFixAll")
            end,
            desc = "ESLint: Auto-fix on save",
        })
    end,
    capabilities = base_capabilities,
    settings = {
        -- Run eslint on save
        workingDirectory = { mode = "auto" },
        format = { enable = true },
    },
})

-- Optional: Add common keybindings for all LSP servers
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    -- Diagnostic keymaps
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
    -- LSP keymaps
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- Format on save (optional)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
            desc = "LSP: Format on save",
        })
    end
end

-- Apply on_attach to all servers
for _, server in ipairs(servers) do
    if server ~= "eslint" then -- ESLint already configured above
        vim.lsp.config(server, {
            on_attach = on_attach,
        })
    end
end
vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }
})


vim.diagnostic.config(
    {
        underline = false,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.INFO] = " ",
            }
        }
    }
)

vim.diagnostic.config({
    virtual_text = false,
})
-- to configure lsps further read :h vim.lsp.config
