return {
  "TobinPalmer/rayso.nvim",
  cmd = { "Rayso" },
  config = function()
    require("rayso").setup({
      open_cmd = "google\\ chrome",
      options = {
        theme = "midnight",
      },
    })
  end,
}
