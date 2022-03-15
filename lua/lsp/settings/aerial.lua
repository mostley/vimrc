local M = {}

function M.setup(client, bufnr)
  require("aerial").setup({
    show_guides = true,
  })
  require("aerial").on_attach(client, bufnr)
end

return M
