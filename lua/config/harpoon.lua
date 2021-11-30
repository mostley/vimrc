require("harpoon").setup({
  nav_first_in_list = true,
  enter_on_sendcmd = true,
})

local opt = { silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>;", [[<cmd>lua require("harpoon.mark").add_file()<CR>]], opt)
map("n", "<C-h>", [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], opt)
map("n", "<leader>ki", [[<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>]], opt)

map("n", "<C-j>", [[<cmd>lua require("harpoon.ui").nav_file(1)<CR>]], opt)
map("n", "<C-k>", [[<cmd>lua require("harpoon.ui").nav_file(2)<CR>]], opt)
map("n", "<C-l>", [[<cmd>lua require("harpoon.ui").nav_file(3)<CR>]], opt)
map("n", "<C-;>", [[<cmd>lua require("harpoon.ui").nav_file(4)<CR>]], opt)
map("n", "<leader>kd", [[<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>]], opt)
map("n", "<leader>ks", [[<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>]], opt)
map("n", "<leader>id", [[<cmd>lua require("harpoon.term").sendCommand(1, 1)<CR>]], opt)
map("n", "<leader>is", [[<cmd>lua require("harpoon.term").sendCommand(1, 2)<CR>]], opt)
