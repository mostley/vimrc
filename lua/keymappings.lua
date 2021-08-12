local utils = require('utils')

utils.map('n', '<Leader>qf', '<Cmd>copen<CR>')
utils.map('n', '<Leader>qc', '<Cmd>cclose<CR>')
utils.map('n', '<Leader>qn', '<Cmd>cnext<CR>')
utils.map('n', '<Leader>qp', '<Cmd>cprev<CR>')
utils.map('n', '<Leader>qz', '<Cmd>cex []<CR>')
utils.map('n', '<Leader>qh', 'q:')
utils.map('n', '<Leader>qs', 'q/')

utils.map('t', '<C-w><C-o>', '<C-\\><C-n> :MaximizerToggle!<CR>')
utils.map('t', '<C-h>', '<C-\\><C-n><C-w>h')
utils.map('t', '<C-j>', '<C-\\><C-n><C-w>j')
utils.map('t', '<C-k>', '<C-\\><C-n><C-w>k')
utils.map('t', '<C-l>', '<C-\\><C-n><C-w>l')
utils.map('n', '<leader>h', ':wincmd h<CR>')
utils.map('n', '<leader>j', ':wincmd j<CR>')
utils.map('n', '<leader>k', ':wincmd k<CR>')
utils.map('n', '<leader>l', ':wincmd l<CR>')
utils.map('n', '<leader>tn', ':lua require("trouble").next({skip_groups = true, jump = true});<CR>')
utils.map('n', '<leader>tp', ':lua require("trouble").next({skip_groups = true, jump = true});<CR>')

utils.map('n', '<C-c>', '<Esc>')

vim.api.nvim_exec([[
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

vmap < <gv
vmap > >gv

nnoremap <silent> <M-left> <C-w>>
nnoremap <silent> <M-right> <C-w><
nnoremap <silent> <M-up> <C-w>+
nnoremap <silent> <M-down> <C-w>-

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

nnoremap <Leader>pd :let &runtimepath.=','.escape(expand('%:p:h'), '\,')

nnoremap <Leader>es :call tts#Speak()<CR>
vnoremap <Leader>es :call tts#Speak(1)<CR>

"  greatest remap ever
vnoremap <leader>p "_dP

" delete without copy
vnoremap <leader>d "_d

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv

inoremap , ,<c-g>u
inoremap ; ;<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ] ]<c-g>u
inoremap } }<c-g>u
inoremap ) )<c-g>u

" add numeric jumps to jump list
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

noremap cp yap<S-}>p

" move line(s) in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
]], false)
