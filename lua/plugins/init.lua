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
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "unblevable/quick-scope",
  "mrjones2014/legendary.nvim",
  "folke/which-key.nvim",
  "kevinhwang91/rnvimr",
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
  "lukas-reineke/indent-blankline.nvim",
  "stevearc/dressing.nvim",
  "gruvbox-community/gruvbox",
  "tomasr/molokai",
  "karb94/neoscroll.nvim",
  "j-hui/fidget.nvim",
  -- Terminal emulator
  -- ---------------------
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end,
  },
  -- Testing
  -- {
  --   "rcarriga/vim-ultest",
  --   build = ":UpdateRemotePlugins",
  --   dependencies = { "vim-test/vim-test" },
  -- },
  {
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
  },
  -- Telescope
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "fhill2/telescope-ultisnips.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "ibhagwan/fzf-lua",                         dependencies = { "nvim-tree/nvim-web-devicons" } },
      { "nvim-telescope/telescope-project.nvim" },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "tami5/sql.nvim" },
      },
      {
        "nvim-telescope/telescope-vimspector.nvim",
        event = "BufWinEnter",
      },
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  },
  "nvim-telescope/telescope-ui-select.nvim",
  -- LSP config
  "jose-elias-alvarez/null-ls.nvim",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
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
  "windwp/lsp-fastaction.nvim",
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
  {
    "SirVer/ultisnips",
    dependencies = { { "honza/vim-snippets" } },
  },
  -- Lua development
  "folke/neodev.nvim",
  "simrat39/symbols-outline.nvim",
  -- Better syntax
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "nvim-treesitter/playground",
        cmd = "TSHighlightCapturesUnderCursor",
      },
      "nvim-treesitter/nvim-treesitter-refactor",
      {
        "nvim-treesitter/completion-treesitter",
        build = function()
          vim.cmd([[TSUpdate]])
        end,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup({ enable = true })
        end,
      },
      {
        "romgrk/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup({ enable = true })
        end,
      },
      -- {
      --  "mfussenegger/nvim-ts-hint-textobject",
      --config = function()
      --vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
      --vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
      --end,
      --},
      "simrat39/rust-tools.nvim",
      {
        "neovim/nvim-lspconfig",
        name = "nvim-lspconfig",
      },

      -- Completion
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-nvim-lsp",
          "quangnguyen30192/cmp-nvim-ultisnips",
          "hrsh7th/cmp-nvim-lua",
          "octaltree/cmp-look",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-calc",
          "f3fora/cmp-spell",
          "hrsh7th/cmp-emoji",
          "ray-x/cmp-treesitter",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lsp-document-symbol",
        },
      },
    },
  },
  --use("~/projects/private/treesitter-boolean.nvim")

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
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
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
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
    "ThePrimeagen/harpoon",
    module = "harpoon",
  },
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
  "jbyuki/venn.nvim",
  -- "floobits/floobits-neovim",
  "github/copilot.vim",
}
