local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  nvim_lsp.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      pyls = {
        plugins = {
          pyls_mypy = { enabled = true },
          pyls_rope = { enabled = true },
        },
      },
    },
  })
end

return setup
