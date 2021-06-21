local utils = require('utils')

utils.map('n', '<Leader>gs', '<cmd>Git<CR>')
utils.map('n', '<Leader>gps', '<cmd>:Dispatch! Git push<CR>')
utils.map('n', '<Leader>gpl', '<cmd>:Dispatch! Git pull<CR>')
utils.map('n', '<Leader>gd', '<cmd>Gvdiffsplit<CR>')
utils.map('n', '<Leader>ga', '<cmd>Git fetch --all<CR>')
utils.map('n', '<Leader>grc', '<cmd>Git rebase --continue<CR>')
utils.map('n', '<Leader>grum', '<cmd>Git rebase upstream/master<CR>')
utils.map('n', '<Leader>grom', '<cmd>Git rebase origin/master<CR>')
utils.map('n', '<Leader>gdr', '<cmd>diffget //3<CR>')
utils.map('n', '<Leader>gf', '<cmd>diffget //3<CR>')
utils.map('n', '<Leader>gdl', '<cmd>diffget //2<CR>')
utils.map('n', '<Leader>gj', '<cmd>diffget //2<CR>')
utils.map('n', '<leader>gc', '<cmd>lua require("config.telescope").git_branches()<CR>')
utils.map('n', '<leader>g-', '<cmd>:Silent Git stash<CR>')
utils.map('n', '<leader>g+', '<cmd>:Silent Git stash pop<CR>')
utils.map('n', '<leader>gh', '<cmd>0Gclog<CR>')

require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
}

