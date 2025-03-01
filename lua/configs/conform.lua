local options = {
  formatters_by_ft = {
    solidity = { "prettier" }, -- Changed to "prettier"
    lua = { "stylua" },
    css = { "prettier" },
    java = { "prettier" }, -- Changed to "prettier"
    html = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    -- lsp_fallback = true,

  } -- Ensure the plugin you're using supports this at this level

  -- Uncomment if you need custom arguments
  -- formatters = {
  --   stylua = {
  --     args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" },
  --   }
  -- },

  -- Global options

}

return options
