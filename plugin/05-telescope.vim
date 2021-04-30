lua require("my_lua_extensions")

" project search
nnoremap <leader>ps :lua require('telescope.builtin').grep_string()<CR>

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>gc :lua require('my_lua_extensions.telescope').git_branches()<cr>
nnoremap <leader>t :lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>w :lua require('telescope.builtin').oldfiles()<cr>
" nnoremap <leader>gt :lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>vrc :lua require('telescope.builtin').find_files({ prompt_title = "< VimRC >", cwd = "$HOME/projects/private/vimrc/"})<cr>

nnoremap <leader>fn :lua require('telescope.builtin').grep_string { only_sort_text = true, prompt_title = "< Find in Non-Test >", file_ignore_patterns = { "%.spec.ts" }, search = ''  }<CR>

