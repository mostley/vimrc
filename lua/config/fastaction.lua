require("lsp-fastaction").setup({
  hide_cursor = true,
  action_data = {
    ["typescript"] = {
      { pattern = "to existing import declaration", key = "a", order = 2 },
      { pattern = "from module", key = "i", order = 1 },
    },
  },
})
