-- Better LSP experience
--Please make sure you install markdown and markdown_inline parser
return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    lightbulb = {
      enable = false,
    },
    definition_action_keys = {
      edit = "<leader>e",
      vsplit = "<C-v>",
      split = "<C-i>",
      quit = "q",
    },
  },
}
