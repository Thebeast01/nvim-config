-- load defaults i.e lua_lsp
-- require("nvchad.configs.lspconfig").defaults()
--
-- local lspconfig = require "lspconfig"
--
-- vim.diagnostic.config({
--   virtual_text = false, -- Disable inline errors
--   float = { border = "rounded", wrap = true },
-- })
-- -- EXAMPLE
-- local servers = { "html", "cssls" }
-- local nvlsp = require "nvchad.configs.lspconfig"
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = nvlsp.on_attach,
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--
--   }
-- end
--
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls","ts_ls","tailwindcss","solidity_ls","jdtls","gopls","prismals","lua_ls","pyright","rust_analyzer"}
vim.lsp.enable(servers)

-- to configure lsps further read :h vim.lsp.config









