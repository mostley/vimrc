local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local function setup(capabilities)
  nvim_lsp.vuels.setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

return setup


