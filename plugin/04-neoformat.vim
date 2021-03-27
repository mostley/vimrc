" let g:neoformat_verbose = 1

let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_typescript = ['prettier']
" Use formatprg when available
" let g:neoformat_try_formatprg = 1
" let g:neoformat_run_all_formatters = 1

augroup NEOFORMAT_ON_SAVE
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat

    " au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

" let g:neoformat_typescript_prettier = {
"             \ 'exe': './node_modules/.bin/prettier',
"             \ 'args': ['--write', '--config .prettierrc'],
"             \ 'replace': 1
"             \ }

" let g:neoformat_javascript_prettier = {
"             \ 'exe': './node_modules/.bin/prettier',
"             \ 'args': ['--write', '--config .prettierrc'],
"             \ 'replace': 1
"             \ }
