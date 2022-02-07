local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  nvim_lsp.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  nvim_lsp.pyre.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return setup
