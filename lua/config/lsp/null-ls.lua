local M = {}

local lsputils = require "config.lsp.utils"

M.setup = function()
  local null_ls = require("null-ls")
  local sources = {
    null_ls.builtins.formatting.prettierd.with {
      filetypes = { "html", "typescript", "yaml", "markdown" },
    },
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.stylua,
    -- nls.builtins.formatting.black,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.nginx_beautifier,
    null_ls.builtins.diagnostics.write_good,
    -- nls.builtins.formatting.prettier,
    -- nls.builtins.diagnostics.markdownlint,
    -- nls.builtins.diagnostics.vale,
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
