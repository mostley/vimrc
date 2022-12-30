local status_ok, whichKey = pcall(require, "which-key")
if not status_ok then
  vim.notify("failed to load which-key", vim.log.levels.ERROR)
  return
end

local M = {}

function M.setup()
  whichKey.setup({})
end

return M
