local actions = require('telescope.actions')


require('telescope').load_extension('fzf')
--require('telescope').load_extension('fzy_native')

require('telescope').setup {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      color_devicons = true,
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

    find_command = {
        'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
    },
    use_less = true,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    extensions = {
        fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
  -- extensions = {
  --   fzy_native = {
  --     override_generic_sorter = false,
  --     override_file_sorter = true,
  --   }
  -- }
}


local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "< VimRC >",
            cwd = "$HOME/projects/private/vimrc"
        })
end

M.switch_projects = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "< Switch Project >",
            cwd = "$HOME/projects"
        })
end

M.git_branches = function()
    require("telescope.builtin").git_branches(
        {
            attach_mappings = function(_, map)
                map('i', '<c-d>', actions.git_delete_branch)
                map('n', '<c-d>', actions.git_delete_branch)
                return true
            end
        })
end

return M

