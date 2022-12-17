local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("failed to load mason", "error")
  return
end

local status_ok_2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_2 then
  vim.notify("failed to load mason-lspconfig", "error")
  return
end

local M = {}

function M.setup()
  mason.setup()
  mason_lspconfig.setup()

  local opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }
  require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup(opts)
    end,

    -- Next, you can provide a dedicated handler for specific servers.
    ["rust_analyzer"] = function()
      require("rust-tools").setup({})
    end,
    ["sumneko_lua"] = function()
      local sumneko_opts = require("lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
      require("lspconfig")["sumneko_lua"].setup(opts)
    end,
  })
end

return M
