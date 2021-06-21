local utils = require('utils')
local cmd = vim.cmd

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

vim.g.indentLine_fileTypeExclude = { "help", "terminal", "dashboard" }
vim.g.indent_blankline_buftype_exclude = {"terminal"}

-- vim.g.indent_blankline_space_char = '·'
vim.g.indent_blankline_char = '︙'
vim.g.indentLine_char = '︙'

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
