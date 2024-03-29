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
    ["<D-v>"] = "<C-r>+",
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
    ["N"] = "Nzzzv",
    ["n"] = "nzzzv",
    ["<leader>?"] = { { desc = "Find Keymaps" }, ":Legendary<CR>" },
    ["<leader>pv"] = { { desc = "Open File Explorer (Ranger)" }, ":lua require('ranger-nvim').open(true)<CR>" },
    ["<leader>ss"] = { { desc = "Save Session" }, ":mksession<CR>" },
    ["<leader>sl"] = { { desc = "Restore Session" }, ":so Session.vim<CR>" },
    ["<Leader>pd"] = ":let &runtimepath.=','.escape(expand('%:p:h'), ',')<CR>",
    ["<leader>y"] = { { desc = "Yank to clipboard" }, '"+y' },
    ["<leader>Y"] = { { desc = "Yank file to clipboard" }, 'gg"+yG' },
    ["Y"] = { { desc = "Yank to end of line" }, "y$" },
    ["cp"] = { { desc = "Duplicate paragraph" }, "yap<S-}>p" },
    ["<leader>sw"] = {
      { desc = "Substitue word (search and replace)" },
      ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    },
    -- quickfix
    ["<leader>qf"] = "<cmd>copen<CR>",
    ["<Leader>qc"] = "<Cmd>cclose<CR>",
    ["<Leader>qn"] = "<Cmd>cnext<CR>zz",
    ["<Leader>qp"] = "<Cmd>cprev<CR>zz",
    ["<Leader>qz"] = "<Cmd>cex []<CR>",
    ["<Leader>qh"] = "q:",
    ["<Leader>qs"] = "q/",
    ["<leader><leader>f"] = "<cmd>lua vim.lsp.buf.format({ async=true, timeout_ms=10000 })<CR>",
    ["<leader><leader>c"] = "<cmd>lua for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= '' then vim.api.nvim_win_close(win, false); print('Closing window', win) end end<CR>",
    -- trouble
    ["<leader>tn"] = '<cmd>lua require("trouble").next({skip_groups = true, jump = true});<CR>',
    ["<leader>tp"] = '<cmd>lua require("trouble").next({skip_groups = true, jump = true});<CR>',
    -- any jump
    ["<leader>aj"] = "<cmd>AnyJump<CR>",
    -- telescope
    ["<C-p>"] = "<cmd>lua require('plugins.telescope').project_files()<CR>",
    ["<leader>pp"] = "<cmd>lua require'telescope'.extensions.project.project{ change_dir = true, display_type = 'full' }<CR>",
    ["<leader>fg"] = "<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
    ["<leader>ag"] = "<cmd>Telescope live_grep<cr>",
    ["<leader>aw"] = "<cmd>Telescope grep_string<cr>",
    ["<leader>fb"] = "<cmd>Telescope buffers<cr>",
    ["<leader>fm"] = "<cmd>Telescope marks<cr>",
    ["<leader>ft"] = "<cmd>Telescope help_tags<cr>",
    ["<leader>ff"] = "<cmd>Telescope file_browser<cr>",
    ["<leader>fp"] = "<cmd>Telescope project<CR>",
    ["<leader>fo"] = "<cmd>Telescope oldfiles<CR>",
    ["<leader>fr"] = "<cmd>Telescope frecency<CR>",
    ["<leader>fy"] = "<cmd>Telescope symbols<CR>",
    ["<leader>fe"] = "<cmd>Telescope emoji<CR>",
    ["<leader>fd"] = "<cmd>lua require('plugins.telescope').search_dotfiles()<CR>",
    ["<leader>fx"] = "<cmd>lua require('plugins.telescope').switch_projects()<CR>",
    ["<leader>so"] = "<cmd>Telescope lsp_document_symbols<CR>",
    ["<leader>tqf"] = "<cmd>Telescope quickfix<CR>",
    ["<Leader>gs"] = "<cmd>Git<CR>",
    ["<Leader>gps"] = "<cmd>Git push<CR>",
    ["<Leader>gpl"] = "<cmd>Git pull<CR>",
    ["<Leader>gpu"] = "<cmd>Git push -u origin<CR>",
    ["<Leader>gds"] = "<cmd>Gvdiffsplit<CR>",
    ["<Leader>ga"] = "<cmd>Git fetch --all<CR>",
    ["<Leader>grc"] = "<cmd>Git rebase --continue<CR>",
    ["<Leader>grum"] = "<cmd>Git rebase upstream/main<CR>",
    ["<Leader>grom"] = "<cmd>Git rebase origin/main<CR>",
    ["<Leader>gdr"] = "<cmd>diffget //3<CR>",
    ["<Leader>gf"] = "<cmd>diffget //3<CR>",
    ["<Leader>gdl"] = "<cmd>diffget //2<CR>",
    ["<Leader>gj"] = "<cmd>diffget //2<CR>",
    ["<leader>gc"] = "<cmd>Telescope git_branches<CR>",
    ["<leader>g-"] = "<cmd>Silent Git stash<CR>",
    ["<leader>g+"] = "<cmd>Silent Git stash pop<CR>",
    ["<leader>gl"] = "<cmd>0Gclog<CR>",
    -- trouble
    ["<leader>xx"] = "<cmd>TroubleToggle<cr>",
    ["<leader>xw"] = "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
    ["<leader>xd"] = "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
    ["<leader>xl"] = "<cmd>TroubleToggle loclist<cr>",
    ["<leader>xq"] = "<cmd>TroubleToggle quickfix<cr>",
    ["gR"] = "<cmd>TroubleToggle lsp_references<cr>",
    -- gitsigns
    ["]c"] = { { expr = true }, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    ["[c"] = { { expr = true }, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
    ["<leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ["<leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ["<leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ["<leader>ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ["<leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ["<leader>ghb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    -- notify
    ["<leader>nc"] = "<cmd>lua require('notify').dismiss({})<cr>",
    -- terminal
    ["<C-t>"] = "<cmd>ToggleTerm<CR>",
    -- refactoring
    ["<leader>rc"] = "<cmd>lua require('refactoring').debug.cleanup({})<CR>",
    ["<leader>rp"] = "<cmd>lua require('refactoring').debug.printf({below = false})<CR>",
    -- neotest
    ["<leader>tt"] = "<cmd>lua require('neotest').run.run({adapter=vim.g['test#javascript#runner']})<CR>",
    ["<leader>tbt"] = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
    ["<leader>tf"] = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
    ["<leader>ts"] = "<cmd>lua require('neotest').summary.toggle()<CR>",
    ["<leader>to"] = "<cmd>lua require('neotest').output.open({ enter = true })<CR>",
    ["<leader>tj"] = "<cmd>lua require('plugins.neotest').javascript_runner()<CR>",
    ["<leader>tr"] = "<cmd>lua require('plugins.neotest').python_runner()<CR>",
    -- DAP
    ["<leader>dct"] = '<cmd>lua require"dap".continue()<CR>',
    ["<leader>dxx"] = '<cmd>lua require"dap".close()<CR>',
    ["<leader>dsv"] = '<cmd>lua require"dap".step_over()<CR>',
    ["<leader>dsi"] = '<cmd>lua require"dap".step_into()<CR>',
    ["<leader>dso"] = '<cmd>lua require"dap".step_out()<CR>',
    ["<leader>dtb"] = '<cmd>lua require"dap".toggle_breakpoint()<CR>',
    ["<leader>de"] = '<cmd>lua require("dapui").eval()<CR>',
    ["<leader>duh"] = '<cmd>lua require"dap.ui.widgets".hover()<CR>',
    ["<leader>duf"] = "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
    ["<leader>dsbr"] = '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    ["<leader>dsbm"] = '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    ["<leader>dro"] = '<cmd>lua require"dap".repl.open()<CR>',
    ["<leader>drl"] = '<cmd>lua require"dap".repl.run_last()<CR>',
    ["<leader>dnu"] = '<cmd>lua require"dap".up()<CR>',
    ["<leader>dnd"] = '<cmd>lua require"dap".down()<CR>',
    -- telescope-dap
    ["<leader>dcc"] = '<cmd>lua require"telescope".extensions.dap.commands{}<CR>',
    ["<leader>dco"] = '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
    ["<leader>dlb"] = '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>',
    ["<leader>dv"] = '<cmd>lua require"telescope".extensions.dap.variables{}<CR>',
    ["<leader>df"] = '<cmd>lua require"telescope".extensions.dap.frames{}<CR>',
    -- nvim-dap-ui
    ["<leader>dui"] = '<cmd>lua require"dapui".toggle()<CR>',
    -- package-info
    ["<leader>ns"] = "<cmd>lua require('package-info').show()<cr>",
    ["<leader>np"] = "<cmd>lua require('package-info').change_version()<cr>",
    -- harpoon
    ["<leader>;"] = '<cmd>lua require("harpoon.mark").add_file()<CR>',
    ["<C-h>"] = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
    ["<leader>ki"] = '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>',
    ["<C-j>"] = '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
    ["<C-k>"] = '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
    ["<C-l>"] = '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
    ["<C-;>"] = '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
    ["<leader>kd"] = '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>',
    ["<leader>ks"] = '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>',
    ["<leader>id"] = '<cmd>lua require("harpoon.term").sendCommand(1, 1)<CR>',
    ["<leader>is"] = '<cmd>lua require("harpoon.term").sendCommand(1, 2)<CR>',
    -- smart-splits
    ["<A-h>"] = '<cmd>lua require("smart-splits").resize_left()<CR>',
    ["<A-j>"] = '<cmd>lua require("smart-splits").resize_down()<CR>',
    ["<A-k>"] = '<cmd>lua require("smart-splits").resize_up()<CR>',
    ["<A-l>"] = '<cmd>lua require("smart-splits").resize_right()<CR>',
    -- moving between splits
    -- -- window navigation
    -- ["<leader>h"] = "<cmd>wincmd h<CR>",
    -- ["<leader>j"] = "<cmd>wincmd j<CR>",
    -- ["<leader>k"] = "<cmd>wincmd k<CR>",
    -- ["<leader>l"] = "<cmd>wincmd l<CR>",
    ["<leader>h"] = '<cmd>lua require("smart-splits").move_cursor_left()<CR>',
    ["<leader>j"] = '<cmd>lua require("smart-splits").move_cursor_down()<CR>',
    ["<leader>k"] = '<cmd>lua require("smart-splits").move_cursor_up()<CR>',
    ["<leader>l"] = '<cmd>lua require("smart-splits").move_cursor_right()<CR>',
    -- swapping buffers between windows
    ["<leader><leader>h"] = '<cmd>lua require("smart-splits").swap_buf_left()<CR>',
    ["<leader><leader>j"] = '<cmd>lua require("smart-splits").swap_buf_down()<CR>',
    ["<leader><leader>k"] = '<cmd>lua require("smart-splits").swap_buf_up()<CR>',
    ["<leader><leader>l"] = '<cmd>lua require("smart-splits").swap_buf_right()<CR>',
    -- color picker
    ["<leader>zp"] = "<cmd>CccPick<cr>",
    ["<leader>zc"] = "<cmd>CccConvert<cr>",
    ["<leader>zh"] = "<cmd>CccHighlighterToggle<cr>",
  },
  visual_mode = {
    -- ["<C-c>"] = "<Esc>",
    ["<"] = "<gv",
    [">"] = ">gv",
    ["<D-c>"] = '"+y',
    ["<D-v>"] = '"+p',
    ["<leader>p"] = '"_dP', -- paste without
    ["<leader>d"] = '"_d',  -- delete without copy
    ["<leader>y"] = '"+y',
    -- move line(s) in visual mode
    ["J"] = "<cmd>m '>+1<CR>gv=gv",
    ["K"] = "<cmd>m '<-2<CR>gv=gv",
    -- refactoring
    ["<leader>ri"] = "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
    ["<leader>re"] = "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
    ["<leader>rf"] = "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
    ["<leader>rv"] = "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
    ["<leader>rr"] = "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    ["<leader>rp"] = "<cmd>lua require('refactoring').debug.print_var({})<CR>",
    -- telescope-dap
    ["<leader>dhv"] = '<cmd>lua require"dap.ui.variables".visual_hover()<CR>',
  },
  visual_block_mode = {
    ["<leader>a"] = "<cmd>AnyJumpVisual<CR>",
    ["ih"] = "<cmd><C-U>Gitsigns select_hunk<CR>",
  },
  term_mode = {
    ["<C-w><C-o>"] = "<C-\\><C-n> :MaximizerToggle!<CR>",
    ["<C-h>"] = "<C-\\><C-n><C-w>h",
    ["<C-j>"] = "<C-\\><C-n><C-w>j",
    ["<C-k>"] = "<C-\\><C-n><C-w>k",
    ["<C-l>"] = "<C-\\><C-n><C-w>l",
  },
  command_mode = {
    -- ["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",
    ["<D-v>"] = "<C-r>+",
  },
  text_object = {
    -- Text objects
    ["ih"] = "<cmd><C-U>Gitsigns select_hunk<CR>",
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
      cnoreabbrev Qa qa
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
    -- ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["K"] = "<Cmd>Lspsaga hover_doc<CR>",
    -- ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
    ["gD"] = "<Cmd>Lspsaga peek_definition<CR>",
    ["gt"] = "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
    ["gi"] = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    ["gh"] = "<Cmd>Lspsaga lsp_finder<CR>",
    -- ["gr"] = "<Cmd>lua vim.lsp.buf.references()<CR>",
    -- ["gr"] = "<cmd>lua require'telescope.builtin'.lsp_references()<CR>",
    ["gr"] = "<Cmd>Lspsaga lsp_finder<CR>",
    ["<C-s-k>"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["gp"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
    ["gn"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
    -- ["<leader>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
    ["<leader>rn"] = "<cmd>Lspsaga rename<CR>",
    ["<leader>ld"] = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    ["<leader>sl"] = "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    -- ["<leader>ac"] = '<cmd>lua require("lsp-fastaction").code_action()<CR>',
    ["<leader>ac"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    -- ["<leader>ac"] = "<cmd>Lspsaga code_action<CR>",
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
      -- ["<C-c>"] = actions.close,
      -- ["<C-c>"] = false,
      -- ["<C-x>"] = false,
      ["<esc>"] = actions.close,
      -- ["<C-t>"] = trouble.smart_open_with_trouble,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
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
      -- ["<C-c>"] = actions.close,
      -- ["<C-t>"] = trouble.smart_open_with_trouble,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
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

return M
