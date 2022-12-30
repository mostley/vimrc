local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  vim.notify("failed to load indent blankline", vim.log.levels.ERROR)
  return
end

local M = {}

function M.setup()
  vim.opt.list = true

  indent_blankline.setup({
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "NvimTree", "alpha", "Telescope" },
  })
end

return M
