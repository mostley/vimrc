local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("failed to load null-ls", "error")
  return
end

local M = {}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local lsputils = require("config.lsp.utils")

M.setup = function()
  local sources = {
    formatting.prettierd.with({
      filetypes = { "html", "typescript", "yaml", "markdown" },
      extra_filetypes = { "toml", "tsx", "ts", "vue", "json" },
    }),
    formatting.eslint_d,
    formatting.yapf,
    diagnostics.shellcheck,
    formatting.stylua,
    diagnostics.flake8,
    null_ls.builtins.code_actions.gitsigns,
    formatting.nginx_beautifier,
    diagnostics.write_good,
  }

  null_ls.setup({
    sources = sources,
    on_attach = lsputils.lsp_attach,
    on_exit = lsputils.lsp_exit,
    on_init = lsputils.lsp_init,
    capabilities = lsputils.get_capabilities(),
    flags = { debounce_text_changes = 150 },
  })
end

return M
