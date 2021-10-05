local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  require("lspconfig").volar.setup({
    capabilities = capabilities,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end,
    settings = {
      volar = {
        tsPlugin = true,
      },
    },
  })
end

return setup
