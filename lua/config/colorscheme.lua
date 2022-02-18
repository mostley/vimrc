local M = {}

M.setup = function()
    local utils = require("utils")
    local g = vim.g
    local cmd = vim.cmd

    require("colorizer").setup()
    require("neoscroll").setup()

    local t = {}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150", [['sine']] } }
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150", [['sine']] } }
    require("neoscroll.config").set_mappings(t)

    utils.opt("o", "termguicolors", true)
    g.gruvbox_undercurl = 1
    g.gruvbox_contrast_dark = "hard"
    g.gruvbox_invert_selection = "0"
    --g.gruvbox_guisp_fallback = "bg"
    g.gruvbox_italicize_comments = 1
    g.gruvbox_italicize_string = 1
    g.gruvbox_italic = 1

    -- local base16 = require("base16")
    -- base16(base16.themes("onedark"), true)
    -- base16(base16.themes("dracula"), true)
    -- base16(base16.themes("material-darker"), true)

    g.indent_blankline_enabled = true
    g.indent_blankline_char = "▏"
    g.indent_blankline_use_treesitter = true
    g.indent_blankline_show_current_context = true

    g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
    g.indent_blankline_buftype_exclude = { "terminal" }

    g.indent_blankline_show_trailing_blankline_indent = false
    g.indent_blankline_show_first_indent_level = false

    cmd("highlight ColorColum ctermbg=0 guibg=lightgrey")
    cmd("highlight Normal guibg=None")
    -- cmd([[
    -- if exists('+termguicolors')
    --     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    --     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    -- endif
    -- ]])

    cmd("au Colorscheme * hi Keyword guifg=#fb4934 gui=italic cterm=italic")

    cmd("colorscheme gruvbox")
end

return M