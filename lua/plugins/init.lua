return {
  -- Config
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = [[vim.g.startuptime_tries = 10]],
  },
  -- Development
  "tpope/vim-dispatch",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  "tpope/vim-abolish",
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  "wellle/targets.vim",
  "easymotion/vim-easymotion",
  "unblevable/quick-scope",
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
  "tikhomirov/vim-glsl",
  "stevearc/vim-arduino",
  -- Color scheme
  "norcalli/nvim-colorizer.lua",
  "siduck76/nvim-base16.lua",
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
      require("config.file-icons").setup()
    end,
  },
  "gruvbox-eommunity/gruvbox",
  "tomasr/molokai",
  "j-hui/fidget.nvim",
  -- LSP config
  "jose-elias-alvarez/null-ls.nvim",
  "RRethy/vim-illuminate",
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "onsails/lspkind-nvim",
    },
    config = function()
      require("aerial").setup()
    end,
  },
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init()
    end,
  },
  "p00f/nvim-ts-rainbow",
  "ray-x/lsp_signature.nvim",
  "szw/vim-maximizer",
  -- "dyng/ctrlsfjvim",
  -- "dbeniamine/cheat.sh-vim",
  {
    "pechorin/any-jump.vim",
    config = function()
      vim.g.any_jump_disable_default_keybindings = 1
    end,
  },
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VimEnter",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = function()
      require("todo-comments").setup({})
    end,
  },
  "folke/lsp-colors.nvim",
  -- Lua development
  "folke/neodev.nvim",
  "simrat39/symbols-outline.nvim",
  -- Debugging
  "puremourning/vimspector",
  -- DAP
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python", -- Python
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",
  "Pocco81/DAPInstall.nvim",
  -- Project
  "airblade/vim-rooter",
  -- Rust
  {
    "Saecki/crates.nvim",
    tag = "v0.2.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  "b0o/schemastore.nvim",
  {
    "plasticboy/vim-markdown",
    event = "VimEnter",
    ft = "markdown",
    dependencies = { "godlygeek/tabular" },
  },
  "ellisonleao/glow.nvim",
  {
    "vuki656/package-info.nvim",
    event = "VimEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup({ package_manager = "npm" })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  -- "floobits/floobits-neovim",
  "github/copilot.vim",
}
