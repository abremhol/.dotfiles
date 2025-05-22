return {
  '0x00-ketsu/maximizer.nvim',
  config = function()
    require('maximizer').setup {
      vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua require("maximizer").toggle()<CR>', { silent = true, noremap = true }),
    }
  end,
}
