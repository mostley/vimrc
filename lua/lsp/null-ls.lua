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
local code_actions = null_ls.builtins.code_actions

local lsputils = require("config.lsp.utils")

M.setup = function()
  local sources = {
    diagnostics.eslint_d,
    diagnostics.shellcheck,
    diagnostics.flake8,
    diagnostics.write_good,
    diagnostics.alex,
    diagnostics.gitlint,
    --diagnostics.mypy,
    diagnostics.tidy,

    formatting.prettierd.with({
      filetypes = { "html", "typescript", "yaml", "markdown" },
      extra_filetypes = { "toml", "tsx", "ts", "vue", "json" },
    }),
    -- formatting.black,
    formatting.yapf,
    formatting.stylua,
    formatting.nginx_beautifier,

    code_actions.gitsigns,
    code_actions.eslint_d,
    code_actions.proselint,
    code_actions.refactoring,
    code_actions.shellcheck,
  }

  null_ls.setup({
    sources = sources,
--    on_attach = lsputils.lsp_attach,
    --on_exit = lsputils.lsp_exit,
    --on_init = lsputils.lsp_init,
    --capabilities = lsputils.get_capabilities(),
    --flags = { debounce_text_changes = 150 },
  })
end

return M
