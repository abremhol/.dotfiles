return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
  config = function()
    vim.g.lazygit_floating_window_use_plenary = 1
    -- Force Vim keybindings for commit editor
    vim.g.lazygit_use_neovim_remote = 1
    -- Set editor mode to use Vim keybindings
    vim.g.lazygit_commit_editor_mode = 'vim'
  end,
}
