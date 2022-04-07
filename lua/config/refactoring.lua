local status_ok, refactoring = pcall(require, "refactoring")
if not status_ok then
  vim.notify("failed to load refactoring", "error")
  return
end
local M = {}

M.setup = function()
  refactoring.setup({
    -- prompt for return type
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
  })
end

return M
