-- Changes in inline diagnostics display to windows with new lines
-- if remove, also remove the corresponding line in lspconfig.lua
return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = { diagnostics = { virtual_text = false } },
  },
}
