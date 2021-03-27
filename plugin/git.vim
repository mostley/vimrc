" git checkout
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
" git choose left side diff
nnoremap <leader>gf :diffget \\2<CR>
" git choose right side diff
nnoremap <leader>gj :diffget \\3<CR>
" git status
nmap <leader>gs :G<CR>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
nnoremap <leader>grc :Git rebase --continue<CR>
nnoremap <leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <leader>g+ :Silent Git stash pop<CR>:e<CR>

let g:fugitive_gitlab_domains = ['https://gitlab.understand.ai']
let g:fugitive_pty = 0
