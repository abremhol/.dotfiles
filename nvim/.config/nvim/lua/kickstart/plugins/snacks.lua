-- folke/snacks.nvim
-- A collection of small QoL plugins. This config is intentionally *additive*:
-- it only enables modules that don't overlap with existing plugins
-- (telescope, nvim-tree, indent-blankline, zen-mode, lazygit.nvim are kept).
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Detect and disable heavy features for very large files.
    bigfile = { enabled = true },
    -- Render files faster on startup (before plugins/treesitter kick in).
    quickfile = { enabled = true },
    -- Better `vim.notify` with history.
    notifier = { enabled = true, timeout = 3000 },
    -- LSP reference highlighting + navigation (]] / [[).
    words = { enabled = true },
    -- Indent guides + animated scope. Disabled to avoid clashing with
    -- indent-blankline.nvim which is already installed. Flip to true and
    -- drop indent-blankline if you'd rather consolidate.
    indent = { enabled = false },
    -- Scope-based textobjects/navigation.
    scope = { enabled = true },
    -- Simple startup dashboard (config currently has none).
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Grep Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
          { icon = ' ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
    -- On-demand modules used via keymaps below (no global behaviour change).
    gitbrowse = { enabled = true },
    scratch = { enabled = true },
    rename = { enabled = true },
    bufdelete = { enabled = true },
    -- Left disabled to avoid conflicts with existing plugins:
    lazygit = { enabled = false }, -- using kdheepak/lazygit.nvim
    zen = { enabled = false }, -- using folke/zen-mode.nvim
    dim = { enabled = false }, -- using monokai-pro dimInactive
    explorer = { enabled = false }, -- using nvim-tree
    picker = { enabled = false }, -- using telescope
  },
  keys = {
    -- GitHub / gh: open current file (or selection) on GitHub in the browser.
    { '<leader>gB', function() Snacks.gitbrowse() end, mode = { 'n', 'v' }, desc = 'Git Browse (open on GitHub)' },
    -- Inline git blame for the current line.
    { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
    -- Notifications.
    { '<leader>nh', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>nd', function() Snacks.notifier.hide() end, desc = 'Dismiss Notifications' },
    -- Scratch buffers.
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    -- LSP-aware file rename (updates imports/references).
    { '<leader>rf', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    -- Delete buffer without wrecking the window layout.
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    -- Jump between LSP references under the cursor.
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
  },
}
