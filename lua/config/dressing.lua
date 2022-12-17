local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
  vim.notify("failed to load dressing", "error")
  return
end

local M = {}

function M.setup()
  dressing.setup({
    input = {
      enabled = true,
      default_prompt = "➤ ",
      insert_only = false, -- When true, <Esc> will close the modal
    },
    select = {
      enabled = true,
    },
  })
end

return M
