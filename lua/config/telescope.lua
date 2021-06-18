local actions = require('telescope.actions')


require('telescope').load_extension('fzf')
--require('telescope').load_extension('fzy_native')

require('telescope').setup {
    defaults = {
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
            attach_mappings = function(prompt_bufnr, map)
                map('i', '<c-d>', actions.git_delete_branch)
                map('n', '<c-d>', actions.git_delete_branch)
                return true
            end
        })
end

vim.cmd [[
" Find files using Telescope command-line sugar.
nnoremap <silent> <C-p> :Telescope git_files<CR>
nnoremap <silent> <leader>fg :Telescope live_grep<cr>
nnoremap <silent> <leader>ag :Telescope live_grep<cr>
nnoremap <silent> <leader>fb :Telescope buffers<cr>
nnoremap <silent> <leader>ft :Telescope help_tags<cr>
nnoremap <silent> <leader>fe :Telescope file_browser<cr>
nnoremap <silent> <leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <leader>fc :DashboardChangeColorscheme<CR>
nnoremap <silent> <leader>fw :DashboardFindWord<CR>
nnoremap <silent> <leader>fm :DashboardJumpMark<CR>
nnoremap <silent> <leader>fn :DashboardNewFile<CR>
nnoremap <silent> <leader>fp :Telescope project<CR>
nnoremap <silent> <leader>fr :Telescope frecency<CR>
nnoremap <silent> <leader>fy :Telescope symbols<CR>

nnoremap <silent> <leader>fd :lua require('config.telescope').search_dotfiles()<CR>
nnoremap <silent> <leader>fx :lua require('config.telescope').switch_projects()<CR>

nmap <leader>fss :<C-u>SessionSave<CR>
nmap <leader>fsl :<C-u>SessionLoad<CR>
]]

return M

