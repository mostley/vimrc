local status_ok, legendary = pcall(require, "legendary")
if not status_ok then
  vim.notify("failed to load legendary", vim.log.levels.ERROR)
  return
end

local M = {}

function M.setup()
  legendary.setup({
    which_key = {
      auto_register = true,
      -- do_binding = false,
    },
  })
end

return M
