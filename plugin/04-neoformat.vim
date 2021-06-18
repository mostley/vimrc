" let g:neoformat_verbose = 1

let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript= ['prettier']
let g:neoformat_enabled_json= ['prettier']
let g:neoformat_enabled_yaml= ['prettier']

augroup NEOFORMAT_ON_SAVE
    autocmd!
    autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry


augroup END

