return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    vim.opt.list = true

    require("indent_blankline").setup({
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = { "NvimTree", "alpha", "Telescope" },
    })
  end,
}
