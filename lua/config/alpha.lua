local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  vim.notify("failed to load alpha")
  return
end

local M = {}

function M.setup() end

return M
