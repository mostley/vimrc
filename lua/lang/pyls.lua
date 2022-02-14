local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  -- nvim_lsp.pylsp.setup({
  nvim_lsp.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  })

  nvim_lsp.pyre.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  })
end

return setup
