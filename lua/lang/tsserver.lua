local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local function setup(capabilities)
  nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end
  }
end

return setup

