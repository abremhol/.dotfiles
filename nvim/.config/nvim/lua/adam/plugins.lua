local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "moll/vim-bbye" -- to be able to close buffers with bdelete without closing neovim
  use "gpanders/editorconfig.nvim" -- "read .editorconfig"
  -- "treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'Hoffs/omnisharp-extended-lsp.nvim' -- fixes go to def in libraries
  use 'onsails/lspkind.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'simrat39/symbols-outline.nvim'
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "ray-x/lsp_signature.nvim"

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Git
  use("TimUntersberger/neogit")
  use "lewis6991/gitsigns.nvim"

  -- Statusline
  use 'nvim-lualine/lualine.nvim'
  use 'vimpostor/vim-tpipeline' -- for merging statusline with tmux status line

  -- Text Handling
  use 'tpope/vim-surround'
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim" -- Easily comment stuff

  -- Debugging
  use { 'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    }
  }


  -- ColorThemes
  use { "catppuccin/nvim", as = "catppuccin" }
  -- use "ayu-theme/ayu-vim"
  -- use "folke/tokyonight.nvim"
  -- use "lunarvim/darkplus.nvim"
  -- use 'marko-cerovac/material.nvim'

  -- Other
  use("mbbill/undotree")
  --[[ use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight ]]
  use 'szw/vim-maximizer' -- maximize current window

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
