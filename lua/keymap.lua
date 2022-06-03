--[[
 _   _-
| | / /
| |/ /  ___ _   _ _ __ ___   __ _ _ __  ___
|    \ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
| |\  \  __/ |_| | | | | | | (_| | |_) \__ \
\_| \_/\___|\__, |_| |_| |_|\__,_| .__/|___/
             __/ |               | |
            |___/                |_|
--]]
local M = {}

local keymap = require("utils.keymap")

local keymappings = {
  insert_mode = {
    ["<C-c>"] = "<Esc>",
    ["<D-v>"] = '<C-r>+',

    [","] = ",<c-g>u",
    [";"] = ";<c-g>u",
    ["."] = ".<c-g>u",
    ["!"] = "!<c-g>u",
    ["?"] = "?<c-g>u",
    ["]"] = "]<c-g>u",
    ["}"] = "}<c-g>u",
    [")"] = ")<c-g>u",
  },
  normal_mode = {
    ["<C-6>"] = "<C-^>",

    ["<D-c>"] = '"+y',
    ["<D-v>"] = '"+p',

    ["<leader>pv"] = ":RnvimrToggle<CR>",
    ["<leader>ss"] = ":<C-u>SessionSave<CR>",
    ["<leader>sl"] = ":<C-u>SessionLoad<CR>",
    ["<Leader>pd"] = ":let &runtimepath.=','.escape(expand('%:p:h'), ',')",

    ["<leader>y"] = "\"+y",
    ["<leader>Y"] = 'gg"+yG',
    ["Y"] = "y$",

    ["N"] = "Nzzzv",
    ["n"] = "nzzzv",

    -- add numeric jumps to jump list
    -- ["k"] = { { expr = true }, '(v:count > 5 ? "m\'" . v:count : "") . \'k\'' },
    -- ["j"] = { { expr = true }, '(v:count > 5 ? "m\'" . v:count : "") . \'j\'' },

    ["cp"] = "yap<S-}>p",
    ["<leader>s"] = ":%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>",

    -- quickfix
    ["<leader>qf"] = "<cmd>copen<CR>",
    ["<Leader>qc"] = "<Cmd>cclose<CR>",
    ["<Leader>qn"] = "<Cmd>cnext<CR>",
    ["<Leader>qp"] = "<Cmd>cprev<CR>",
    ["<Leader>qz"] = "<Cmd>cex []<CR>",
    ["<Leader>qh"] = "q:",
    ["<Leader>qs"] = "q/",

    -- window navigation
    ["<leader>h"] = ":wincmd h<CR>",
    ["<leader>j"] = ":wincmd j<CR>",
    ["<leader>k"] = ":wincmd k<CR>",
    ["<leader>l"] = ":wincmd l<CR>",

    ["<leader><leader>f"] = "<cmd>lua vim.lsp.buf.formatting()<CR>",
    ["<leader><leader>c"] = "<cmd>lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= '' then vim.api.nvim_win_close(win, false); print('Closing window', win) end end<CR>",

    -- trouble
    ["<leader>tn"] = ':lua require("trouble").next({skip_groups = true, jump = true});<CR>',
    ["<leader>tp"] = ':lua require("trouble").next({skip_groups = true, jump = true});<CR>',

    -- any jump
    ["<leader>aj"] = ":AnyJump<CR>",

    -- telescope
    ["<C-p>"] = ":lua require('config.telescope').project_files()<CR>",
    ["<leader>pp"] = ":lua require'telescope'.extensions.project.project{ change_dir = true, display_type = 'full' }<CR>",
    ["<leader>fg"] = ":Telescope find_files hidden=true no_ignore=true<cr>",
    ["<leader>ag"] = ":Telescope live_grep<cr>",
    ["<leader>fb"] = ":Telescope buffers<cr>",
    ["<leader>ft"] = ":Telescope help_tags<cr>",
    ["<leader>ff"] = ":Telescope file_browser<cr>",
    ["<leader>fh"] = ":DashboardFindHistory<CR>",
    ["<leader>fc"] = ":DashboardChangeColorscheme<CR>",
    ["<leader>fw"] = ":DashboardFindWord<CR>",
    ["<leader>fm"] = ":DashboardJumpMark<CR>",
    ["<leader>fn"] = ":DashboardNewFile<CR>",
    ["<leader>fp"] = ":Telescope project<CR>",
    ["<leader>fr"] = ":Telescope frecency<CR>",
    ["<leader>fy"] = ":Telescope symbols<CR>",
    ["<leader>fe"] = ":Telescope emoji<CR>",
    ["<leader>fd"] = ":lua require('config.telescope').search_dotfiles()<CR>",
    ["<leader>fx"] = ":lua require('config.telescope').switch_projects()<CR>",

    ["<leader>so"] = "<cmd>Telescope lsp_document_symbols<CR>",
    ["<leader>tqf"] = "<cmd>Telescope quickfix<CR>",

    ["<Leader>gs"] = "<cmd>Git<CR>",
    ["<Leader>gps"] = "<cmd>:Git push<CR>",
    ["<Leader>gpl"] = "<cmd>:Git pull<CR>",
    ["<Leader>gds"] = "<cmd>Gvdiffsplit<CR>",
    ["<Leader>ga"] = "<cmd>Git fetch --all<CR>",
    ["<Leader>grc"] = "<cmd>Git rebase --continue<CR>",
    ["<Leader>grum"] = "<cmd>Git rebase upstream/main<CR>",
    ["<Leader>grom"] = "<cmd>Git rebase origin/main<CR>",
    ["<Leader>gdr"] = "<cmd>diffget //3<CR>",
    ["<Leader>gf"] = "<cmd>diffget //3<CR>",
    ["<Leader>gdl"] = "<cmd>diffget //2<CR>",
    ["<Leader>gj"] = "<cmd>diffget //2<CR>",
    ["<leader>gc"] = ":Telescope git_branches<CR>",
    ["<leader>g-"] = "<cmd>:Silent Git stash<CR>",
    ["<leader>g+"] = "<cmd>:Silent Git stash pop<CR>",
    ["<leader>gh"] = "<cmd>0Gclog<CR>",

    -- trouble
    ["<leader>xx"] = "<cmd>TroubleToggle<cr>",
    ["<leader>xw"] = "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    ["<leader>xd"] = "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    ["<leader>xl"] = "<cmd>TroubleToggle loclist<cr>",
    ["<leader>xq"] = "<cmd>TroubleToggle quickfix<cr>",
    ["gR"] = "<cmd>TroubleToggle lsp_references<cr>",

    -- gitsigns
    ["n ]c"] = { { expr = true }, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    ["n [c"] = { { expr = true }, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

    ["n <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ["n <leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ["n <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ["n <leader>ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ["n <leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ["n <leader>ghb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- notify
    ["<leader>nc"] = ":lua require('notify').dismiss({})<cr>",

    -- terminal
    ["<C-t>"] = ":ToggleTerm<CR>",

    -- refactoring
    ["<leader>rc"] = ":lua require('refactoring').debug.cleanup({})<CR>",
    ["<leader>rp"] = ":lua require('refactoring').debug.printf({below = false})<CR>",

    -- ultest
    ["<leader>tt"] = ":UltestNearest<CR>",
    ["<leader>tf"] = ":Ultest<CR>",
    ["<leader>ts"] = ":UltestSummary<CR>",
    ["<leader>to"] = "<Plug>(ultest-output-jump)",
    ["[t"] = "<Plug>(ultest-prev-fail)",
    ["]t"] = "<Plug>(ultest-next-fail)",
  },
  visual_mode = {
    ["<C-c>"] = "<Esc>",
    ["<"] = "<gv",
    [">"] = ">gv",

    ["<D-c>"] = '"+y',
    ["<D-v>"] = '"+p',

    ["<leader>p"] = '"_dP', -- paste without
    ["<leader>d"] = '"_d', -- delete without copy
    ["<leader>y"] = '"+y',

    -- move line(s) in visual mode
    ["J"] = ":m '>+1<CR>gv=gv",
    ["K"] = ":m '<-2<CR>gv=gv",

    -- refactoring
    ["<leader>ri"] = "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
    ["<leader>re"] = "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
    ["<leader>rf"] = "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
    ["<leader>rv"] = "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
    ["<leader>rr"] = "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    ["<leader>rd"] = ":lua require('refactoring').debug.print_var({})<CR>",
  },
  visual_block_mode = {
    ["<leader>a"] = ":AnyJumpVisual<CR>",
    ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  },
  term_mode = {
    ["<C-w><C-o>"] = "<C-\\><C-n> :MaximizerToggle!<CR>",
    ["<C-h>"] = "<C-\\><C-n><C-w>h",
    ["<C-j>"] = "<C-\\><C-n><C-w>j",
    ["<C-k>"] = "<C-\\><C-n><C-w>k",
    ["<C-l>"] = "<C-\\><C-n><C-w>l",
  },
  command_mode = {
    ["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",
    ["<D-v>"] = '<C-r>+',
  },
  text_object = {
    -- Text objects
    ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  },
}

function M.setup()
  vim.api.nvim_exec(
    [[
      cnoreabbrev W! w!
      cnoreabbrev Q! q!
      cnoreabbrev Qall! qall!
      cnoreabbrev Wq wq
      cnoreabbrev Wa wa
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
      cnoreabbrev W w
      cnoreabbrev Q q
      cnoreabbrev Qall qall

      nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
      nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'
    ]],
    false
  )

  for mode, mapping in pairs(keymappings) do
    keymap.map(mode, mapping)
  end
end

M.lsp_keymappings = {
  normal_mode = {
    ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
    ["gt"] = "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
    ["gi"] = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    -- ["gr"] = "<Cmd>lua vim.lsp.buf.references()<CR>",
    ["gr"] = "<cmd>lua require'telescope.builtin'.lsp_references()<CR>",
    ["<C-s-k>"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["gp"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
    ["gn"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
    ["<leader>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
    ["<leader>gl"] = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    ["<leader>sl"] = "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    ["<leader>ac"] = '<cmd>lua require("lsp-fastaction").code_action()<CR>',
    ["<leader>ds"] = "<cmd>lua vim.lsp.buf.document_symbol()<CR>",
    -- ["[e"] = "<Cmd>Lspsaga diagnostic_jump_next<CR>",
    -- ["]e"] = "<Cmd>Lspsaga diagnostic_jump_prev<CR>",
  },
  visual_mode = {
    ["<leader>ac"] = "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>",
  },
}

function M.get_telescope_keymappings()
  local actions = require("telescope.actions")
  return {
    i = {
      ["<C-c>"] = actions.close,
      -- ["<C-c>"] = false,
      -- ["<C-x>"] = false,
      ["<esc>"] = actions.close,
      -- ["<C-t>"] = trouble.smart_open_with_trouble,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<C-h>"] = "which_key",
      ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-l>"] = actions.complete_tag,
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },
    n = {
      ["<esc>"] = actions.close,
      ["<C-c>"] = actions.close,
      -- ["<C-t>"] = trouble.smart_open_with_trouble,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-h>"] = "which_key",
      ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- <A-q>

      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  }
end

function M.get_legendary_custom_mappings(legendary)
  local opts = { noremap = true, silent = true }

  return {
    { "<C-b>", ":NvimTreeToggle<CR>", description = "Toggle file tree", opts = opts },
    -- cutting and pasting lines
    { "<C-k>", legendary.find, description = "Search key bindings" },
    -- Document jumping since we re-bind file tree to C-b
    { "<C-j>", "<C-f>", opts = opts, description = "Jump forward in document" },
    { "<C-v>", "<C-b>", opts = opts, description = "Jump backward in document" },
    -- call lazygit with control g
    -- { '<C-g>', _lazygit_toggle, opts = opts, description = 'Toggle LazyGit terminal' },
    { "gt", ":BufferLinCyclePrev<CR>", opts = opts, description = "Previous tab" },
    { "gy", ":BufferLineCycleNext<CR>", opts = opts, description = "Next tab" },
    { "<C-p>", ":Telescope git_files<CR>", opts = opts, description = "Find File" },
    { "<leader><leader>o", ":AerialToggle right<CR>", opts = opts, description = "Browse Symbols" },
    -- Commenting
    { "<leader><leader>c", ":CommentToggle<CR>", mode = "v", opts = opts, description = "Toggle Comment" },
    { "<leader><leader>c", ":CommentToggle<CR>", mode = "n", opts = opts, description = "Toggle Comment" },
    -- folding
    { "<C-]", "za", mode = "n", opts = opts, description = "Fold Out" },
    { "<C-[", "zc", mode = "n", opts = opts, description = "Fold In" },
  }
end

return M
