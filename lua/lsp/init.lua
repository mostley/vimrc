local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("failed to load lspconfig", vim.log.levels.ERROR)
  return
end

local M = {}

function M.setup()
  require("lsp.handlers").setup()
  require("lsp.lsp-signature").setup()
  require("lsp.neodev").setup()
  require("lsp.null-ls").setup()
end

return M
