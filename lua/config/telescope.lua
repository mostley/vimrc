local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("failed to load telescope", "error")
  return
end

local actions = require("telescope.actions")
local icons = require("icons")
local get_telescope_keymappings = require("keymap").get_telescope_keymappings

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

  telescope.load_extension("project")
  telescope.load_extension("frecency")
  telescope.load_extension("emoji")
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")

  telescope.setup({
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = " ",
      color_devicons = true,
      path_display = { "smart" },
      mappings = get_telescope_keymappings(),
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

      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          previewer = false,
          -- even more opts
        }),
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
