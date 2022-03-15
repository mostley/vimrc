local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status_ok then
  vim.notify("failed to load gitsigns")
  return
end

local M = {}

M.setup = function()
  vim.notify("test it!!!")
  gitsigns.setup({
    signs = {
      add = { hl = "DiffAdd", text = "+", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
    },
    sign_priority = 5,
  })
  vim.notify("tested")
end

return M
