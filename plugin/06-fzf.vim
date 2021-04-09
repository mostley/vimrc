let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" let $FZF_DEFAULT_OPTS = '--reverse --bind ctrl-a:select-all'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

nnoremap <silent> <Leader>ag :Ag<CR>
nnoremap <silent> <Leader>rg :Rg<CR>
" nnoremap <C-p> :GFiles<Cr>