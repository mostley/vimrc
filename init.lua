vim.opt.termguicolors = true
vim.g.python_host_prog = '/Users/svenhecht/.pyenv/versions/py2nvim/bin/python'
vim.g.python3_host_prog = '/Users/svenhecht/.pyenv/versions/py3nvim/bin/python'

vim.lsp.set_log_level("debug")

require("plugins").setup()
