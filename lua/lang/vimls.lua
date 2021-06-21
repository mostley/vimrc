local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local function setup(capabilities)
  nvim_lsp.vimls.setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

return setup

