local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if not lua_dev_loaded then
  vim.notify("failed to load lua-dev", "error")
  return
end

local M = {}

function M.setup()
  local opts = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  }
  local dev_opts = {
    library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      -- plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      plugins = { "plenary.nvim" },
    },
    lspconfig = opts,
  }

  lua_dev.setup(dev_opts)
end

return M
