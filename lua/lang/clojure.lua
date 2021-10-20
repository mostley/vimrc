local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup()
  nvim_lsp.clojure_lsp.setup({
    on_attach = on_attach,
  })
end

return setup
