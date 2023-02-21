local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("failed to load telescope", vim.log.levels.ERROR)
  return
end

local actions = require("telescope.actions")
local icons = require("icons")
local get_telescope_keymappings = require("keymap").get_telescope_keymappings

local M = {}

function M.setup()
  -- local trouble = require("trouble.providers.telescope")

  -- require("telescope-emoji").setup({
  --   action = function(emoji)
  --     -- argument emoji is a table.
  --     -- {name="", value="", cagegory="", description=""}
  --     vim.fn.setreg('"', emoji.value)
  --     print([[Press p or "*p to paste this emoji]] .. emoji.value)
  --   end,
  -- })

  telescope.load_extension("project")
  telescope.load_extension("frecency")
  telescope.load_extension("emoji")
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")
  telescope.load_extension("refactoring")
  telescope.load_extension("ui-select")

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

  -- workaround for file can't be opened after find_files see https://github.com/nvim-telescope/telescope.nvim/issues/699
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx",
  })
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/projects/private/vimrc",
  })
end

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      -- map("i", "<c-d>", M.delete_git_branches)
      -- map("n", "<c-d>", M.delete_git_branches)
      return true
    end,
  })
end

-- M.delete_git_branches = function()
--   local prompt_bufnr = nil
--   for k, v in pairs(TelescopeGlobalState) do
--     if v["picker"] ~= nil and v["picker"]["preview_title"] == "Git Branch Preview" then
--       prompt_bufnr = k
--     end
--   end
--   if prompt_bufnr == nil then
--     print("No git branches prompt found")
--     return
--   end

--   local action_state = require("telescope.actions.state")
--   local utils = require("telescope.utils")
--   local action_name = "actions.git_delete_selected_branch"

--   local confirmation = vim.fn.input("Do you really want to delete the selected branches? [Y/n] ")
--   if confirmation ~= "" and string.lower(confirmation) ~= "y" then
--     return
--   end

--   local picker = action_state.get_current_picker(prompt_bufnr)
--   picker:delete_selection(function(selection)
--     local branch = selection.value
--     print("Deleting branch " .. branch)
--     local _, ret, stderr = utils.get_os_command_output({ "git", "branch", "-D", branch }, picker.cwd)
--     if ret == 0 then
--       utils.notify(action_name, {
--         msg = string.format("Deleted branch: %s", branch),
--         level = "INFO",
--       })
--     else
--       utils.notify(action_name, {
--         msg = string.format("Error when deleting branch: %s. Git returned: '%s'", branch, table.concat(stderr, " ")),
--         level = "ERROR",
--       })
--     end
--     return ret == 0
--   end)
-- end

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

return M
