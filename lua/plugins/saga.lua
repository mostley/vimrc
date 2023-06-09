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
    finder = {
      max_height = 0.5,
      min_width = 30,
      force_max_height = false,
      keys = {
        jump_to = "p",
        expand_or_jump = { "o", "<enter>" },
        vsplit = "<C-v>",
        split = "<C-i>",
        tabe = "t",
        tabnew = "r",
        quit = { "q", "<ESC>" },
        close_in_preview = "<ESC>",
      },
    },
  },
}
