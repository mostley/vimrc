local function setupLib(libName, params)
  local status_ok, lib = pcall(require, libName)
  if not status_ok then
    vim.notify("failed to load " .. libName, vim.log.levels.ERROR)
    return
  end
  lib.setup(params)
end

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

setupLib("settings")
setupLib("pluginmanager")
setupLib("visual")
setupLib("lsp")
setupLib("autocommands")

-- configs
setupLib("config.mason")
setupLib("config.fastaction")
setupLib("config.ultisnips")
setupLib("config.indent-blankline")
setupLib("config.telescope")
setupLib("config.gitsigns")
setupLib("config.venn")
setupLib("dbg")
setupLib("fidget")

setupLib("keymap")
