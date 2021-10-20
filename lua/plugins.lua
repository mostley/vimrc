return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })

  -- Config
  use({
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = [[vim.g.startuptime_tries = 10]],
  })

  -- Development
  use({ "tpope/vim-dispatch" })
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-sleuth" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-abolish" })
  use({
    "mg979/vim-visual-multi",
    branch = "master",
  })
  use({ "wellle/targets.vim" })
  use({ "easymotion/vim-easymotion" })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })
  use({ "akinsho/nvim-bufferline.lua" })
  use({ "unblevable/quick-scope" })
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })
  use({ "kevinhwang91/rnvimr" })
  use({ "tikhomirov/vim-glsl" })
  use({ "stevearc/vim-arduino" })

  -- Color scheme
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "siduck76/nvim-base16.lua" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "gruvbox-community/gruvbox" })
  use({ "tomasr/molokai" })
  use({ "karb94/neoscroll.nvim" })

  -- Testing
  use({
    "rcarriga/vim-ultest",
    config = "require('config.ultest').post()",
    run = ":UpdateRemotePlugins",
    requires = { "vim-test/vim-test" },
  })

  -- Telescope
  use({ "nvim-lua/plenary.nvim" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-telescope/telescope.nvim" })
  use({
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sql.nvim" },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  })
  use({ "nvim-telescope/telescope-symbols.nvim" })

  -- LSP config
  use({ "neovim/nvim-lspconfig" })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  })
  use({
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "jose-elias-alvarez/null-ls.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  })

  -- Completion - use either one of this
  use({
    "hrsh7th/nvim-compe",
    requires = {
      { "andersevenrud/compe-tmux" },
    },
  })

  -- Better LSP experience
  -- use({ "glepnir/lspsaga.nvim" })
  -- use({ "al3xfischer/lspsaga.nvim" })
  use({ "windwp/lsp-fastaction.nvim" })
  use({ "onsails/lspkind-nvim" })
  use({ "p00f/nvim-ts-rainbow" })
  use({ "ray-x/lsp_signature.nvim" })
  use({ "szw/vim-maximizer" })
  -- use {'dyng/ctrlsfjvim'}
  -- use {'dbeniamine/cheat.sh-vim'}
  use({ "pechorin/any-jump.vim" })
  use({ "kevinhwang91/nvim-bqf", ft = "qf" })
  use({
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  })
  use({
    "folke/touble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  })
  use({ "folke/lsp-colors.nvim" })
  use({ "hrsh7th/vim-vsnip" })
  use({ "rafamadriz/friendly-snippets" })
  use({ "cstrap/python-snippets" })
  use({ "ylcnfrht/vscode-python-snippet-pack" })
  use({ "xabikos/vscode-javascript" })
  use({ "windwp/nvim-ts-autotag" })

  -- Lua development
  use({ "folke/lua-dev.nvim" })
  use({ "simrat39/symbols-outline.nvim" })

  -- Better syntax
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      {
        "nvim-treesitter/completion-treesitter",
        run = function()
          vim.cmd([[TSUpdate]])
        end,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("config.treesitter")
    end,
  })
  -- use {'nvim-treesitter/playground'}

  -- Dashboard
  use({ "glepnir/dashboard-nvim" })

  -- Status line
  use({
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require("statusline")
    end,
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })

  -- Debugging
  use({ "puremourning/vimspector" })
  use({ "nvim-telescope/telescope-vimspector.nvim" })

  -- DAP
  use({ "mfussenegger/nvim-dap" })
  use({ "nvim-telescope/telescope-dap.nvim" })
  use({ "mfussenegger/nvim-dap-python" }) -- Python
  use({ "theHamsta/nvim-dap-virtual-text" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "Pocco81/DAPInstall.nvim" })

  -- Telescope fzf
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Project
  use({ "nvim-telescope/telescope-project.nvim" })
  use({ "airblade/vim-rooter" })

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })
end)
