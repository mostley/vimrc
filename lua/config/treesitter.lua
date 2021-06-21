require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    use_languagetree = true,
    disable = { },              -- list of language that will be disabled
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  rainbow = {
    enable = true
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
  refactor = {
    highlight_definitions = {
      enable = true
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr"
      }
    }
  }
}
