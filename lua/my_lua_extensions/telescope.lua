local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-c>"] = false,
        ["<C-x>"] = false,
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}


local action_state = require('telescope.actions.state')
local utils = require('telescope.utils')

local git_delete_branch = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()

  local confirmation = vim.fn.input('Do you really wanna delete branch ' .. selection.value .. '? [Y/n] ')
  if confirmation ~= '' and string.lower(confirmation) ~= 'y' then return end

  -- actions.close(prompt_bufnr)
  local _, ret, stderr = utils.get_os_command_output({ 'git', 'branch', '-D', selection.value }, cwd)
  if ret == 0 then
    print("Deleted branch: " .. selection.value)
  else
    print(string.format(
      'Error when deleting branch: %s. Git returned: "%s"',
      selection.value,
      table.concat(stderr, '  ')
    ))
  end

end

M.git_branches = function()
  require'telescope.builtin'.git_branches({
    attach_mappings = function(_, map)
      map('i', '<C-d>', git_delete_branch)
      map('n', '<C-d>', git_delete_branch)
      return true
    end
  })
end

return M
