local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("failed to load lspsaga", "error")
  return
end

local M = {}

function M.setup()
  saga.init_lsp_saga({
    code_action_lightbulb = {
      enable = false,
    },
  })
end

return M
