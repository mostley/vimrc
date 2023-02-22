local function setupLib(libName, params)
  local status_ok, lib = pcall(require, libName)
  if not status_ok then
    vim.notify("failed to load " .. libName, vim.log.levels.ERROR)
    return
  end
  lib.setup(params)
end

setupLib("settings")
setupLib("pluginmanager")
setupLib("lsp")
setupLib("visual")
setupLib("autocommands")

-- configs
setupLib("dbg")
setupLib("fidget")

setupLib("keymap")
