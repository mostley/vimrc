local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").load_extension("fzf")
--require('telescope').load_extension('fzy_native')

require("telescope").setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    color_devicons = true,
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-c>"] = false,
        ["<C-x>"] = false,
        ["<esc>"] = actions.close,
        ["<C-t>"] = trouble.smart_open_with_trouble,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = "which_key",
        ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-t>"] = trouble.smart_open_with_trouble,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = "which_key",
        ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },

  find_command = {
    "rg",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  },
  use_less = true,
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  -- extensions = {
  --   fzy_native = {
  --     override_generic_sorter = false,
  --     override_file_sorter = true,
  --   }
  -- }
})

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/projects/private/vimrc",
  })
end

M.switch_projects = function()
  require("telescope.builtin").find_files({
    prompt_title = "< Switch Project >",
    cwd = "$HOME/projects",
  })
end

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end

local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  require("telescope.actions").close(prompt_bufnr)
  require("refactoring").refactor(content.value)
end

M.refactors = function()
  require("telescope.pickers").new({}, {
    prompt_title = "refactors",
    finder = require("telescope.finders").new_table({
      results = require("refactoring").get_refactors(),
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end,
  }):find()
end

vim.api.nvim_set_keymap(
  "v",
  "<Leader>rt",
  [[ <Cmd>lua M.refactors()<CR>]],
  { noremap = true, silent = true, expr = false }
)

return M
