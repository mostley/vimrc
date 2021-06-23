local utils = require('utils')
local g = vim.g

require('colorizer').setup()
require('neoscroll').setup()

local t = {}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150', [['sine']]}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '150', [['sine']]}}
require('neoscroll.config').set_mappings(t)

utils.opt('o', 'termguicolors', true)
-- cmd 'colorscheme gruvbox'
local base16 = require "base16"
base16(base16.themes["onedark"], true)

g.indent_blankline_enabled = true
g.indent_blankline_char = "▏"
g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true

g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false
