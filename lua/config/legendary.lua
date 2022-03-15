local status_ok, legendary = pcall(require, "legendary")
if not status_ok then
  vim.notify("failed to load legendary", "error")
  return
end

local M = {}

function M.setup()
  local commands = {
    -- You can also use legendar.nvim to create commands!
    { ":DoSomething", ':echo "something"', description = "Do something!" },
  }

  local custom_mappings = require("keymap").get_legendary_custom_mappings(legendary)

  legendary.setup({
    -- Include builtins by default, set to false to disable
    include_builtin = true,
    -- Customize the prompt that appears on your vim.ui.select() handler
    select_prompt = "Legendary",
    -- Initial keymaps to bind
    keymaps = custom_mappings,
    -- Initial commands to create
    commands = commands,
    -- Automatically add which-key tables to legendary
    -- when you call `require('which-key').register()`
    -- for this to work, you must call `require('legendary').setup()`
    -- before any calls to `require('which-key').register()`, and
    -- which-key.nvim must be loaded when you call `require('legendary').setup()`
    auto_register_which_key = false,
  })
end

return M
