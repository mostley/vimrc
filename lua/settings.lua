--[[
______           _        _____              __ _
| ___ \         (_)      /  __ \            / _(_)
| |_/ / __ _ ___ _  ___  | /  \/ ___  _ __ | |_ _  __ _
| ___ \/ _` / __| |/ __| | |    / _ \| '_ \|  _| |/ _` |
| |_/ / (_| \__ \ | (__  | \__/\ (_) | | | | | | | (_| |
\____/ \__,_|___/_|\___|  \____/\___/|_| |_|_| |_|\__, |
                                                   __/ |
                                                  |___/
--]]
local utils = require("utils")

local M = {}

local cmd = vim.cmd
local g = vim.g

local indent = 2

function M.setup()
  g.python_host_prog = vim.env.HOME .. "/.pyenv/versions/py2nvim/bin/python"
  g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/py3nvim/bin/python"

  -- vim.lsp.set_log_level("debug")

  cmd("syntax enable")
  cmd("filetype plugin indent on")

  vim.opt.formatoptions = vim.opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    - "r" -- Don't insert comment after <Enter>
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

  local settings = {
    backup = false, -- creates a backup file
    -- clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    colorcolumn = "120",
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = false, -- highlight all matches on previous search pattern
    incsearch = true,
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = false, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = indent, -- the number of spaces inserted for each indentation
    tabstop = indent, -- insert 2 spaces for a tab
    softtabstop = indent, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,

    hidden = true,
    history = 100,
    inccommand = "split",
    lazyredraw = true,
    pumblend = 17,
    synmaxcol = 240,
    laststatus = 2,
    sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal",

    encoding = "utf-8",
    fileencodings = "utf-8",
    exrc = true,
    guicursor = "",
    errorbells = false,
    undodir = vim.env.HOME .. "/.config/nvim/undodir",
    list = true,
    listchars = "tab:░░,trail:·,nbsp:·",
    fillchars = { eob = "~" },
    smarttab = true,
    shiftround = true,
    autoindent = true,
    breakindent = true,
    path = vim.opt.path + { "**" },
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
  }

  vim.opt.shortmess:append("c")
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","
  vim.g.vimsyn_embed = "lPr"
  vim.g.vim_markdown_fenced_languages = { "html", "javascript", "typescript", "css", "python", "lua", "vim" }

  -- iterate through the options and set them
  for key, value in pairs(settings) do
    vim.opt[key] = value
  end
end

return M
