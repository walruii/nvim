local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'          -- the package manager
  use 'nvim-tree/nvim-web-devicons'     -- the icons
  use 'nvim-lualine/lualine.nvim'       -- the line that shows up at the bottom
  use 'nvim-treesitter/nvim-treesitter' -- the language support manager with syntax highlight
  use 'lewis6991/gitsigns.nvim'         -- git signs on the left side
  use 'christoomey/vim-tmux-navigator'  -- tmux itegrations
  use 'windwp/nvim-ts-autotag'          -- HTML autotags
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }

  }
  use "https://github.com/diepm/vim-rest-console"
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  }
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  }
  use 'tpope/vim-surround'
  use "tpope/vim-repeat"
  use 'tpope/vim-commentary' -- for commenting
  use 'jiangmiao/auto-pairs'
  use 'Mofiqul/vscode.nvim'
  use "craftzdog/solarized-osaka.nvim"
  use 'brenoprata10/nvim-highlight-colors'
  use 'lukas-reineke/indent-blankline.nvim'

  -- completion

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp", }
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-buffer'
  use 'nvim-tree/nvim-tree.lua'
  use "https://github.com/aviate-labs/motoko.vim"
  use "https://github.com/takac/vim-hardtime"
  use {
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "glepnir/lspsaga.nvim",
  }


  if packer_bootstrap then
    require('packer').sync()
  end
end)
