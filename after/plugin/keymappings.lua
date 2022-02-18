local M = {}

local keymap = require "utils.keymap"
local utils = require('utils')

local keymappings = {
    insert_mode = {
        ["<C-c>"] = "<Esc>",
    },
    normal_mode = {
        ["<C-c>"] = "<Esc>",
        ["<leader>qf"] = "<cmd>copen<CR>",
        ["<Leader>qc"] = "<Cmd>cclose<CR>",
        ["<Leader>qn"] = "<Cmd>cnext<CR>",
        ["<Leader>qp"] = "<Cmd>cprev<CR>",
        ["<Leader>qz"] = "<Cmd>cex []<CR>",
        ["<Leader>qh"] = "q:",
        ["<Leader>qs"] = "q/",
        ["<leader>h"] = ":wincmd h<CR>",
        ["<leader>j"] = ":wincmd j<CR>",
        ["<leader>k"] = ":wincmd k<CR>",
        ["<leader>l"] = ":wincmd l<CR>",
        -- trouble
        ["<leader>tn"] = ':lua require("trouble").next({skip_groups = true, jump = true});<CR>',
        ["<leader>tp"] = ':lua require("trouble").next({skip_groups = true, jump = true});<CR>',

        -- any jump
        ["<leader>a"] = ":AnyJump<CR>",

        -- telescope
        ["<C-p>"] = ":lua require('config.telescope').project_files()<CR>",
        ['<leader>pp'] = ":lua require'telescope'.extensions.project.project{ change_dir = true }<CR>",
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

        ["<leader>lo"] = "<cmd>Telescope lsp_document_symbols<CR>",
        ["<leader>lq"] = "<cmd>Telescope quickfix<CR>",

        ['<Leader>gs'] = '<cmd>Git<CR>',
        ['<Leader>gps'] = '<cmd>:Dispatch! Git push<CR>',
        ['<Leader>gpl'] = '<cmd>:Dispatch! Git pull<CR>',
        ['<Leader>gd'] = '<cmd>Gvdiffsplit<CR>',
        ['<Leader>ga'] = '<cmd>Git fetch --all<CR>',
        ['<Leader>grc'] = '<cmd>Git rebase --continue<CR>',
        ['<Leader>grum'] = '<cmd>Git rebase upstream/master<CR>',
        ['<Leader>grom'] = '<cmd>Git rebase origin/master<CR>',
        ['<Leader>gdr'] = '<cmd>diffget //3<CR>',
        ['<Leader>gf'] = '<cmd>diffget //3<CR>',
        ['<Leader>gdl'] = '<cmd>diffget //2<CR>',
        ['<Leader>gj'] = '<cmd>diffget //2<CR>',
        ['<leader>gc'] = '<cmd>lua require("config.telescope").git_branches()<CR>',
        ['<leader>g-'] = '<cmd>:Silent Git stash<CR>',
        ['<leader>g+'] = '<cmd>:Silent Git stash pop<CR>',
        ['<leader>gh'] = '<cmd>0Gclog<CR>',

        -- trouble
        ["<leader>xx"] = "<cmd>TroubleToggle<cr>",
        ["<leader>xw"] = "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
        ["<leader>xd"] = "<cmd>TroubleToggle lsp_document_diagnostics<cr>",
        ["<leader>xl"] = "<cmd>TroubleToggle loclist<cr>",
        ["<leader>xq"] = "<cmd>TroubleToggle quickfix<cr>",
        ["gR"] = "<cmd>TroubleToggle lsp_references<cr>",
    },
    visual_mode = {
        ["<C-c>"] = "<Esc>",
    },
    visual_block_mode = {
        ["<leader>a"] = ":AnyJumpVisual<CR>",
    },
    term_mode = {
        ["<C-w><C-o>"] = "<C-\\><C-n> :MaximizerToggle!<CR>",
        ["<C-h>"] = "<C-\\><C-n><C-w>h",
        ["<C-j>"] = "<C-\\><C-n><C-w>j",
        ["<C-k>"] = "<C-\\><C-n><C-w>k",
        ["<C-l>"] = "<C-\\><C-n><C-w>l",
    },
    command_mode = {
    }
}

function M.setup()
    for mode, mapping in pairs(keymappings) do
        keymap.map(mode, mapping)
    end
end

M.setup()

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

map <leader>pv :RnvimrToggle<CR>

nmap <leader>ss :<C-u>SessionSave<CR>
nmap <leader>sl :<C-u>SessionLoad<CR>

vmap < <gv
vmap > >gv

nnoremap <silent> <M-left> <C-w>>
nnoremap <silent> <M-right> <C-w><
nnoremap <silent> <M-up> <C-w>+
nnoremap <silent> <M-down> <C-w>-

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

nnoremap <Leader>pd :let &runtimepath.=','.escape(expand('%:p:h'), '\,')

nnoremap <Leader>es :call tts#Speak()<CR>
vnoremap <Leader>es :call tts#Speak(1)<CR>

"  greatest remap ever
vnoremap <leader>p "_dP

" delete without copy
vnoremap <leader>d "_d

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv

inoremap , ,<c-g>u
inoremap ; ;<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ] ]<c-g>u
inoremap } }<c-g>u
inoremap ) )<c-g>u

" add numeric jumps to jump list
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

noremap cp yap<S-}>p

" move line(s) in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

]],
  false
)

vim.cmd [[
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

" Integration with telescope.nvim
nmap <leader>vc :lua require('telescope').extensions.vimspector.configurations()<CR>

" Inspection
nnoremap <leader>vtv :MaximizerToggle!<CR>
nnoremap <leader>vgc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>vgt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>vgv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>vgw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>vgs :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>vgo :call GotoWindow(g:vimspector_session_windows.output)<CR>
]]
  -- keymaps = {
  --   -- Default keymap options
  --   noremap = true,
  --   buffer = true,
  --
  --   ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
  --   ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
  --
  --   ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  --   ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  --   ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   ['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
  --   ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  --
  --   -- Text objects
  --   ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
  --   ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  -- },
