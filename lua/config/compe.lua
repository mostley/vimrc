-- Configuration for nvim-compe
local utils = require("utils")

vim.cmd([[set shortmess+=c]])
vim.o.completeopt = "menuone,noselect"

require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = false,
    tags = true,
    snippets_nvim = true,
    treesitter = true,
    vim_dadbod_completion = true,
    buffer = { kind = "﬘", true },
    vsnip = { kind = "﬌" }, --replace to what sign you prefer
    tmux = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
-- move to prev/next item in completion menuone
-- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t("<Plug>(vsnip-expand-or-jump)")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t("<Plug>(vsnip-jump-prev)")
  else
    return t("<S-Tab>")
  end
end

utils.map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
utils.map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
utils.map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
utils.map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

function _G.completions()
  local npairs = require("nvim-autopairs")
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"]("<CR>")
    end
  end
  return npairs.check_break_line_char()
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", { expr = true })
