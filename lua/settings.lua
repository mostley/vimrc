local utils = require('utils')

local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'

bo.shiftwidth = indent
bo.tabstop = indent
bo.softtabstop = indent
o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.scrolloff = 8
-- o.splitbelow = true
o.splitright = true
o.clipboard = 'unnamed,unnamedplus'
o.timeoutlen = 500
o.updatetime = 300
o.inccommand = "split"
o.cmdheight = 2
wo.number = true
wo.relativenumber = true
wo.scrolloff = 8
wo.cursorline = true

cmd [[
set exrc
set guicursor=
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set nohlsearch
set incsearch
set noshowmode
set signcolumn=yes
set colorcolumn=120
set shortmess+=c
set expandtab smarttab shiftround autoindent smartindent smartcase
set path+=**
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
highlight ColorColum ctermbg=0 guibg=lightgrey
highlight Normal guibg=None
set mouse=a
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
let g:gruvbox_guisp_fallback = 'bg'
]]

-- Highlight on yank
-- cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

-- Auto format
-- vim.api.nvim_exec([[
-- let g:neoformat_enabled_python = ['autopep8']
-- let g:neoformat_enabled_typescript = ['prettier']
-- let g:neoformat_enabled_javascript= ['prettier']
-- let g:neoformat_enabled_json= ['prettier']
-- let g:neoformat_enabled_yaml= ['prettier']

-- augroup auto_fmt
--     autocmd!
--     autocmd BufWritePre *.py,*.lua,*.ts,*.vue try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
-- aug END
-- ]], false)

vim.api.nvim_exec([[
augroup auto_spellcheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.org setfiletype markdown
    autocmd BufNewFile,BufRead *.org setlocal spell
augroup END
]], false)

vim.api.nvim_exec([[
augroup auto_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END
]], false)

vim.api.nvim_exec([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    autocmd FileType go,rust,html,typescript,javascript,python autocmd BufWritePre <buffer> call TrimWhitespace()
]], false)
