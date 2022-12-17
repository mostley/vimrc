vim.g.ultest_use_pty = 1

local M = {}

function M.javascript_runner()
  local runners = { "jest", "vitest", "cypress" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      vim.notify("Test runner changed to " .. selected, "info")
    end
  end)
end

function M.python_runner()
  local runners = { "pytest", "unittest" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      vim.notify("Test runner changed to " .. selected, "info")
    end
  end)
end

function M.setup()
  require("neotest").setup({
    diagnostic = {
      enabled = true,
    },
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
        runner = "pytest",
      }),
      -- require("neotest-jest"),
      require("neotest-vitest"),
      require("neotest-plenary"),
      require("neotest-vim-test")({
        ignore_file_types = { "python", "vim", "lua" },
      }),
    },
  })
end

return M
