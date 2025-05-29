vim.keymap.set('n', '<leader>gct', vim.cmd.CopilotChatToggle, { desc = 'Toggle Copilot Chat' })
-- to fix collision with tab from blink.cmp
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'copilot-chat',
  callback = function()
    vim.keymap.del('i', '<Tab>', { buffer = true })
  end,
})
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      completeopt = {
        'popup', -- Show completion menu
      },
      mappings = {
        complete = {
          insert = '<C-å>',
        },
      },
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
