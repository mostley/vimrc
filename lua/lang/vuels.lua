local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  require("lspconfig").volar.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    settings = {
      volar = {
        tsPlugin = true,
      },
    },
  })
end

return setup
