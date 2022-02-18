local actions = require("telescope.actions")

local M = {}

function M.setup()
  -- local trouble = require("trouble.providers.telescope")

  require("telescope-emoji").setup({
    action = function(emoji)
      -- argument emoji is a table.
      -- {name="", value="", cagegory="", description=""}
      vim.fn.setreg('"', emoji.value)
      print([[Press p or "*p to paste this emoji]] .. emoji.value)
    end,
  })

  require("telescope").load_extension("project")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("emoji")
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("fzf")

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
          -- ["<C-t>"] = trouble.smart_open_with_trouble,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-h>"] = "which_key",
          ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,
          -- ["<C-t>"] = trouble.smart_open_with_trouble,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-h>"] = "which_key",
          ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
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
      file_browser = {
        theme = "ivy",
      },

      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
    },
  })
end

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

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

return M
