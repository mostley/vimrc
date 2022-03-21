local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("failed to load nvim-lsp-installer", "error")
  return
end

local M = {}

function M.setup()
  -- Register a handler that will be called for all installed servers.
  -- Alternatively, you may also register handlers on specific server instances instead (see example below).
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = require("lsp.handlers").on_attach,
      capabilities = require("lsp.handlers").capabilities,
    }

    if server.name == "sumneko_lua" then
      local sumneko_opts = require("lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "omnisharp" then
      local omnisharp_bin = "/Users/svenhecht/omnisharp/OmniSharp"
      opts = vim.tbl_deep_extend("force", {
        cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      }, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
  end)
end

return M
