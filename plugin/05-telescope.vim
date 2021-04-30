lua << EOF
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

EOF

" project search
nnoremap <leader>ps :lua require('telescope.builtin').grep_string()<CR>

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>gc :lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>t :lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>w :lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>vrc :lua require('telescope.builtin').find_files({ prompt_title = "< VimRC >", cwd = "$HOME/projects/private/vimrc/"})<cr>

nnoremap <leader>fn :lua require('telescope.builtin').grep_string { only_sort_text = true, prompt_title = "< Find in Non-Test >", file_ignore_patterns = { "%.spec.ts" }, search = ''  }<CR>

