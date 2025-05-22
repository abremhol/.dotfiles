return {
  'zbirenbaum/copilot.lua',
  opts = {
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {}
    end,
  },
}
