local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("failed to load treesitter", "error")
  return
end

local M = {}

M.setup = function()
  configs.setup({
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = { "vim" }, -- list of language that will be disabled
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

--    rainbow = {
--    enable = true,
--    colors = {
--      "Gold",
--      "Orchid",
--      "DodgerBlue",
--      -- "Cornsilk",
--      -- "Salmon",
--      -- "LawnGreen",
--    },
--    disable = { "html" },
--  },
    indent = {
      enable = true,
      disable = { "yaml", "python", "css" },
    },
    incremental_selection = {
      enable = true,
    },
    autotag = {
      enable = true,
      disable = { "xml" },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    textobjects = {
      enable = true,
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
          ["ae"] = "@call.outer",
          ["ie"] = "@call.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
    refactor = {
      highlight_definitions = {
        enable = false,
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
  })
end

return M
