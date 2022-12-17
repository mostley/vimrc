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
    definition_action_keys = {
      edit = "<leader>e",
      vsplit = "<C-v>",
      split = "<C-i>",
      quit = "q",
    },
  })
end

return M