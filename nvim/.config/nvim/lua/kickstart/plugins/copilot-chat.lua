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
      -- mappings = {
      --   complete = {
      --     insert = '<Tab>',
      --   },
      -- },
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
