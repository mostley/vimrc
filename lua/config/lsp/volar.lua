local M = {}

local lsputils = require("config.lsp.utils")

function M.setup()
  local opts = {
    settings = {
      volar = {
        tsPlugin = true,
      },
    },
  }
  return opts
end

return M
