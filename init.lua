function _G.reload_nvim_conf()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^lsp") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.cmd("command! ReloadConfig lua reload_nvim_conf()")

require("settings").setup()
require("keymap").setup()
require("plugins").setup()
require("visual").setup()
require("lsp").setup()
require("autocommands").setup()

-- configs
require("config.mason").setup()
require("config.saga").setup()
require("config.cmp").setup()
require("config.lualine").setup()
require("config.treesitter").setup()
require("config.alpha").setup()
require("config.toggleterm").setup()
require("config.dressing").setup()
require("config.refactoring").setup()
require("config.harpoon").setup()
require("config.whichkey").setup()
require("config.rnvimr").setup()
require("config.neoscroll").setup()
require("config.ultest").setup()
require("config.fastaction").setup()
require("config.ultisnips").setup()
require("config.treesitter").setup()
require("config.indent-blankline").setup()
require("config.legendary").setup()
require("config.telescope").setup()
require("config.gitsigns").setup()
require("config.venn").setup()
require("dbg").setup()

function setupLib(libName, params)
  local status_ok, lib = pcall(require, libName)
  if not status_ok then
    vim.notify("failed to load " .. libName, "error")
    return
  end
  lib.setup(params)
end

setupLib("fidget")
--setupLib("Comment")
--setupLib("nvim-web-devicons", { default = true })
--       require("config.file-icons").setup()
