local neodev_loaded, neodev = pcall(require, "neodev")
if not neodev_loaded then
  vim.notify("failed to load lua-dev", vim.log.levels.ERROR)
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
      -- plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      plugins = { "neotest", "plenary.nvim", "nvim-dap-ui" },
      types = true,
    },
    lspconfig = opts,
  }

  neodev.setup(dev_opts)
end

return M
