return {
  "SirVer/ultisnips",
  dependencies = { "honza/vim-snippets", "joaohkfaria/vim-jest-snippets" },
  config = function()
    vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
  end,
}
