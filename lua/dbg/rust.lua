local dap = require("dap")

-- local extension_path = "/opt/codelldb/extension"
-- local extension_path = "/opt/vadimcn.vscode-lldb"
local extension_path = "/opt/vscode-lldb-1.6.7/extension"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

local opts = {
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}
require("rust-tools").setup(opts)
dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
dap.adapters.lldb_vscode = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "rt_lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  },
}
