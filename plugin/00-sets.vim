set autoread
set exrc
set guicursor=
set relativenumber
set nu
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set nohlsearch
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set signcolumn=yes
set colorcolumn=120
set splitright
set wildignore+=**/node_modules/**

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms) leads to noticeable delays and
" poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

colorscheme gruvbox

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
