vim.keymap.set('n', '<leader>gct', vim.cmd.CopilotChatToggle, { desc = 'Toggle Copilot Chat' })

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    require('copilot.suggestion').dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    -- Set buffer-local options
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
    vim.api.nvim_buf_set_keymap(0, 'i', '<C-j>', '<Down>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'i', '<C-k>', '<Up>', { noremap = true, silent = true })
  end,
})

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {

      { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      completeopt = {
        'popup', -- Show completion menu
      },
      mappings = {},
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
