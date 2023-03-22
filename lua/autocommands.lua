local M = {}

function M.setup()
  vim.cmd([[
    augroup _general_settings
      autocmd!
      autocmd FileType qf,help,man,lspinfo,spectre_panel nnoremap <silent> <buffer> q :close<CR>
      autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
      autocmd BufWinEnter * :set formatoptions-=cro
      autocmd FileType qf set nobuflisted
    augroup end

    augroup _auto_resize
      autocmd!
      autocmd VimResized * tabdo wincmd =
    augroup end

    augroup _alpha
      autocmd!
      autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    augroup end

    augroup auto_spellcheck
      autocmd!
      autocmd BufNewFile,BufRead *.md setlocal spell
      autocmd BufNewFile,BufRead *.org setfiletype markdown
      autocmd BufNewFile,BufRead *.org setlocal spell
    augroup END

    augroup auto_term
      autocmd!
      autocmd TermOpen * setlocal nonumber norelativenumber
      autocmd TermOpen *  if nvim_buf_get_name(0) =~# '^term://.*' | startinsert | endif
    augroup END
  ]])
end

return M
