local M = {}

local utils = require("utils")

local cmd = vim.cmd
local o = vim.o
local g = vim.g
local opt = vim.opt
local wo = vim.wo
local apply_options = utils.apply_options
local apply_globals = utils.apply_globals

local indent = 2

function M.setup()
    cmd("syntax enable")
    cmd("filetype plugin indent on")

    o.shiftwidth = indent
    o.tabstop = indent
    o.softtabstop = indent
    o.hidden = true
    o.history = 100
    o.ignorecase = true
    o.scrolloff = 8
    -- o.splitbelow = true
    o.splitright = true
    -- o.clipboard = 'unnamed,unnamedplus'
    o.timeoutlen = 300
    o.updatetime = 300
    o.inccommand = "split"
    o.lazyredraw = true
    o.cmdheight = 2
    o.number = true
    o.pumblend = 17
    o.synmaxcol = 240
    wo.relativenumber = true
    wo.scrolloff = 8
    wo.cursorline = true
    o.laststatus = 2
    opt.termguicolors = true
    o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

    apply_globals({
        -- Map leader to space
        mapleader = " ",
        maplocalleader = ",",
        vimsyn_embed= 'lPr',
        vim_markdown_fenced_languages = { "html", "javascript", "typescript", "css", "python", "lua", "vim" },
    })

    apply_options({
        encoding = "utf-8",
        fileencodings = "utf-8",
        exrc = true,
        guicursor = "",
        termguicolors = true,
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
        breakindent = true,
        smartindent = true,
        smartcase = true,
        path = vim.opt.path + { "**" },
        completeopt = "menu,menuone,noselect",
        --wildmode = "longest,list,full",
        --wildmenu = true,
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

end

M.setup()