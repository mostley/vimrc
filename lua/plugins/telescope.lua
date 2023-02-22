-- Telescope
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "xiyaowong/telescope-emoji.nvim",
    "fhill2/telescope-ultisnips.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "ibhagwan/fzf-lua",                         dependencies = { "nvim-tree/nvim-web-devicons" } },
    "nvim-telescope/telescope-project.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { "tami5/sql.nvim" },
    },
    {
      "nvim-telescope/telescope-vimspector.nvim",
      event = "BufWinEnter",
    },
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local icons = require("icons")
    local get_telescope_keymappings = require("keymap").get_telescope_keymappings

    -- local trouble = require("trouble.providers.telescope")

    -- require("telescope-emoji").setup({
    --   action = function(emoji)
    --     -- argument emoji is a table.
    --     -- {name="", value="", cagegory="", description=""}
    --     vim.fn.setreg('"', emoji.value)
    --     print([[Press p or "*p to paste this emoji]] .. emoji.value)
    --   end,
    -- })
    telescope.load_extension("project")
    telescope.load_extension("frecency")
    telescope.load_extension("emoji")
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension("refactoring")
    telescope.load_extension("ui-select")

    telescope.setup({
      defaults = {
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = " ",
        color_devicons = true,
        path_display = { "smart" },
        mappings = get_telescope_keymappings(),
      },
      find_command = {
        "rg",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      use_less = true,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      extensions = {
        file_browser = {
          theme = "ivy",
        },

        fzf = {
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            previewer = false,
            -- even more opts
          }),
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    })

    -- workaround for file can't be opened after find_files see https://github.com/nvim-telescope/telescope.nvim/issues/699
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "*" },
      command = "normal zx",
    })
  end,
  search_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< VimRC >",
      cwd = "$HOME/projects/private/vimrc",
    })
  end,
  project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
      require("telescope.builtin").find_files(opts)
    end
  end,
}
