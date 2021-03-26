syntax on
filetype plugin indent on

set autoread
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set wrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set splitright
set ignorecase
set pastetoggle=<leader>z
set wildignore+=**/node_modules/**

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

set mouse=a

setlocal foldmethod=syntax

call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-fugitive', { 'branch': 'race-condition' }
Plug 'tpope/vim-abolish'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-vinegar'
" Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'vim-utils/vim-man'
" Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()} }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'
" Plug 'ThePrimeagen/vim-be-good'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
" Plug 'integralist/vim-mypy'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'npm install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Plug 'idanarye/vim-merginal'

Plug 'puremourning/vimspector'

"  I AM SO SORRY FOR DOING COLOR SCHEMES IN MY VIMRC, BUT I HAVE
"  TOOOOOOOOOOOOO

" Plug 'colepeters/spacemacs-theme.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
" Plug 'flazz/vim-colorschemes'
" Plug 'chriskempson/base16-vim'

call plug#end()

let g:python3_host_prog = '/Users/svenhecht/.pyenv/versions/py3nvim/bin/python'

let test#strategy = 'neoterm'
let g:neoterm_default_mod = 'vertical'

let g:coc_global_extensions = [ 
            \ 'coc-tsserver', 
            \ 'coc-pyright', 
            \ 'coc-json', 
            \ 'coc-vetur', 
            \ 'coc-eslint',
            \ 'coc-prettier' 
            \ ]

let g:fugitive_gitlab_domains = ['https://gitlab.understand.ai']
"  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}

" let g:prettier#autoformat_config_present = 1
" let g:prettier#autoformat_require_pragma = 0
" let g:prettier#quickfix_enabled = 0
" autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs  <Plug>(coc-format-selected)

let mapleader = " "

let g:airline_powerline_fonts = 1
let g:airline_extensions = []

let g:chadtree_settings = {
            \ 'theme.text_colour_set': 'nerdtree_syntax_dark',
            \ 'view.window_options': { "relativenumber": v:true },
            \ }

let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

let g:fugitive_pty = 0

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS = '--reverse --bind ctrl-a:select-all'
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-d': 'deselect-all',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
 
" let g:fzf_branch_actions = {
"       \ 'checkout': {
"       \   'prompt': 'Checkout> ',
"       \   'execute': 'echo system("{git} checkout {branch}")',
"       \   'multiple': v:false,
"       \   'keymap': 'enter',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \ 'diff': {
"       \   'prompt': 'Diff> ',
"       \   'execute': 'Git diff {branch}',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-f',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \ 'rebase': {
"       \   'prompt': 'Rebase> ',
"       \   'execute': 'echo system("{git} rebase {branch}")',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-r',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \ 'track': {
"       \   'prompt': 'Track> ',
"       \   'execute': 'echo system("{git} checkout {branch}")',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-t',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \ 'create': {
"       \   'prompt': 'Create> ',
"       \   'execute': 'echo system("{git} checkout -b {input}")',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-b',
"       \   'required': ['input'],
"       \   'confirm': v:false,
"       \ },
"       \}
let g:fzf_branch_actions = {
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'enter',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'


let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
let g:gruvbox_guisp_fallback = 'bg'

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1 

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let test#javascript#jest#executable = 'npm run test:unit:watch'

colorscheme gruvbox
set background=dark

" project explorer
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>pv <cmd>CHADopen<cr>

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
vmap <leader>ac  <Plug>(coc-codeaction)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>oi :CocCommand tsserver.organizeImports<cr>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocFzfList diagnostics<cr>

" Show autocomplete when Tab is pressed
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Map fzf search to CTRL P
nnoremap <C-p> :GFiles<Cr>
nnoremap <D-S-F> :Ag<Cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
tmap <C-o> <C-\><C-n>
nnoremap <leader><tab> :b#<CR>

" search word in vim help
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>

" git checkout
nnoremap <leader>gc :GBranches<CR>
" get fetch
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
" git choose left side diff
nnoremap <leader>gf :diffget \\2<CR>
" git choose right side diff
nnoremap <leader>gj :diffget \\3<CR>
" git status
nnoremap <leader>gs :G<CR>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
nnoremap <leader>grc :Git rebase --continue<CR>
nnoremap <leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <leader>g+ :Silent Git stash pop<CR>:e<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>

nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <Leader>! :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
 
" paste from system clipboard in visualmode
vnoremap <leader>p "_dP

nnoremap <silent><leader>f :Ag <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent><F8> :Ag <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <Leader>ag :Ag<CR>
nnoremap <silent> <Leader>rg :Rg<CR>

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yGnn

nnoremap <leader>e :T !!<CR>
noremap cp yap<S-}>p
noremap <leader>pr :profile start vim-profile.log<CR>:profile file *<CR>:profile func *<CR>
noremap <leader>ps :profile stop<CR>

map <F5> :cp!<CR>
map <F6> :cn!<CR>
nnoremap <F8> :Ag "<cword>"<CR>

nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

" toggle true/false in current line
" let g:switch_mapping = ""
" noremap <silent> gs /\\%<c-r>=line('.')<CR>true\\|false<CR>n:Switch<CR>
" noremap <silent> gs /true\\|false<CR>n:Switch<CR>

" use s to trigger replace in visual mode
" xnoremap s :s//g<left><left>
