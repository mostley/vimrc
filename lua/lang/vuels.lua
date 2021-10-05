local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local function setup(capabilities)
  require'lspconfig'.volar.setup {
  }
  -- nvim_lsp.vuels.setup {
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  --   init_options = {
  --     config = {
  --       vetur = {
  --         useWorkspaceDependencies = true
  --       }
  --     }
  --   }
  -- }
end

return setup


