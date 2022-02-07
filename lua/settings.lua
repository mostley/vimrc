local utils = require("utils")

local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
local apply_options = utils.apply_options
local apply_globals = utils.apply_globals

local indent = 2

cmd("syntax enable")
cmd("filetype plugin indent on")

o.shiftwidth = indent
o.tabstop = indent
o.softtabstop = indent
o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.scrolloff = 8
-- o.splitbelow = true
o.splitright = true
-- o.clipboard = 'unnamed,unnamedplus'
o.timeoutlen = 500
o.updatetime = 300
o.inccommand = "split"
o.cmdheight = 2
o.number = true
wo.relativenumber = true
wo.scrolloff = 8
wo.cursorline = true
o.laststatus = 2

apply_globals({
  -- Map leader to space
  mapleader = " ",
  maplocalleader = ",",
})

apply_options({
  encoding = "utf-8",
  fileencodings = "utf-8",
  exrc = true,
  guicursor = "",
  errorbells = false,
  wrap = false,
  swapfile = false,
  mouse = "a",
  backup = false,
  undodir = "/Users/svenhecht/.config/nvim/undodir",
  undofile = true,
  hlsearch = false,
  incsearch = true,
  showmode = false,
  signcolumn = "yes",
  list = true,
  listchars = "tab:░░,trail:·,nbsp:·",
  fillchars = { eob = "~" },
  colorcolumn = "120",
  expandtab = true,
  smarttab = true,
  shiftround = true,
  autoindent = true,
  smartindent = true,
  smartcase = true,
  path = vim.opt.path + { "**" },
  wildmode = "longest,list,full",
  wildmenu = true,
  wildignore = vim.opt.wildignore + {
    "*/.git/*",
    "*/.hg/*",
    "*/.svn/*.",
    "*/.vscode/*.",
    "*/.DS_Store",
    "*/dist*/*",
    "*/target/*",
    "*/builds/*",
    "*/build/*",
    "tags",
    "*/lib/*",
    "*/flow-typed/*",
    "*/node_modules/*",
    "*.png",
    "*.PNG",
    "*.jpg",
    "*.jpeg",
    "*.JPG",
    "*.JPEG",
    "*.pdf",
    "*.exe",
    "*.o",
    "*.obj",
    "*.dll",
    "*.DS_Store",
    "*.ttf",
    "*.otf",
    "*.woff",
    "*.woff2",
    "*.eot",
  },
})

-- Highlight on yank
-- cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")

vim.api.nvim_exec(
  [[
augroup auto_spellcheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.org setfiletype markdown
    autocmd BufNewFile,BufRead *.org setlocal spell
augroup END
]],
  false
)

vim.api.nvim_exec(
  [[
augroup auto_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END
]],
  false
)

-- vim.api.nvim_exec([[
--     fun! TrimWhitespace()
--         let l:save = winsaveview()
--         keeppatterns %s/\s\+$//e
--         call winrestview(l:save)
--     endfun
--     autocmd FileType go,rust,html,typescript,javascript,python autocmd BufWritePre <buffer> call TrimWhitespace()
-- ]], false)
