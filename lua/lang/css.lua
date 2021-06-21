local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local function setup()
  nvim_lsp.tsserver.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end
  }
end

return setup


