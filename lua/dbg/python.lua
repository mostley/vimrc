require("dap-python").setup(vim.env.HOME .. "/.pyenv/versions/py3nvim/bin/python")
local python_config = require("dap").configurations.python
for key, _ in pairs(python_config) do
  python_config[key].justMyCode = false
end
