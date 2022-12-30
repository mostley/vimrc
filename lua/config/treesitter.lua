local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("failed to load treesitter", vim.log.levels.ERROR)
  return
end

local M = {}

M.setup = function()
  configs.setup({
    ensure_installed = { -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      "help",
      "javascript",
      "typescript",
      "python",
      "c",
      "lua",
      "rust",
      "go",
      "html",
      "json",
      "arduino",
      "bash",
      "c_sharp",
      "clojure",
      "cmake",
      "cpp",
      "css",
      "cuda",
      "dart",
      "dockerfile",
      "git_rebase",
      "gitattributes",
      "gitignore",
      "glsl",
      "graphql",
      "java",
      "latex",
      "make",
      "query",
      "ruby",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "vim",
      "vue",
      "yaml",
      "zig",
    },
    auto_install = true,
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = false,
    },
    incremental_selection = {
      enable = false,
      -- keymaps = {
      --   init_selection = "gnn", -- set to `false` to disable one of the mappings
      --   node_incremental = "grn",
      --   scope_incremental = "grc",
      --   node_decremental = "grm",
      -- },
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
          ["<leader>pn"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>pp"] = "@parameter.inner",
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
          smart_rename = "<leader>rrn",
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
