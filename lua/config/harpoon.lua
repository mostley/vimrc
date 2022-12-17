local gitsigns_status_ok, harpoon = pcall(require, "harpoon")
if not gitsigns_status_ok then
  vim.notify("failed to load harpoon")
  return
end

local M = {}

function M.setup()
  harpoon.setup({
    save_on_toggle = true,
    nav_first_in_list = true,
    enter_on_sendcmd = true,
  })

  require("telescope").load_extension("harpoon")
end

return M
