local function javascript_runner()
  local runners = { "jest", "vitest", "cypress" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      vim.notify("Test runner changed to " .. selected, vim.log.levels.INFO)
    end
  end)
end

local function python_runner()
  local runners = { "pytest", "unittest" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      vim.notify("Test runner changed to " .. selected, vim.log.levels.INFO)
    end
  end)
end

-- Testing
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-vim-test",
  },
  module = { "neotest" },
  config = function()
    vim.g.ultest_use_pty = 1

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
  end,
  javascript_runner = javascript_runner,
  python_runner = python_runner,
}
