-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Copy yanks to the system clipboard with OSC 52. This is needed on headless /
-- remote machines (no X11/Wayland clipboard tool) and works through tmux when
-- it has `set -g set-clipboard on`. When a local clipboard tool is available
-- (typical desktop), Nvim's own provider is used instead: forcing OSC 52 there
-- would break `"+p` on terminals that only support OSC 52 writes.
--  See `:help clipboard-osc52`
local function executable(name)
  return vim.fn.executable(name) == 1
end

local has_native_clipboard = ((vim.env.WAYLAND_DISPLAY or '') ~= '' and executable 'wl-copy')
  or ((vim.env.DISPLAY or '') ~= '' and (executable 'xclip' or executable 'xsel'))

if not has_native_clipboard then
  local osc52_copy = require('vim.ui.clipboard.osc52').copy '+'

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      local event = vim.v.event
      if event.operator == 'y' and event.regname ~= '_' then
        -- Take the text straight from the yank event. Reading the register with
        -- getreg() would round-trip through the clipboard provider (an OSC 52
        -- "read"), which blocks when the terminal doesn't answer, e.g. when
        -- yanking with `"+y`.
        osc52_copy(event.regcontents)
      end
    end,
  })

  -- Also enable `"+y`/`"+p`. Copying works with OSC 52, but reading the
  -- clipboard (OSC 52 query) is unsupported by terminals such as Windows
  -- Terminal, so `"+p` will time out -- use the terminal's paste shortcut
  -- (Ctrl+Shift+V) instead.
  vim.g.clipboard = 'osc52'
end
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
vim.o.number = true
vim.o.errorbells = false -- no error bells
vim.o.tabstop = 4 -- insert 2 spaces for a tab
vim.o.softtabstop = 4
vim.o.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.o.expandtab = true -- convert tabs to spaces
vim.o.smartindent = true -- make indenting smarter again
vim.o.wrap = false -- display lines as one long line
vim.o.swapfile = false -- creates a swapfile
vim.o.backup = false -- creates a backup file
vim.o.undofile = true -- enable persistent undo
vim.o.hlsearch = false -- highlight all matches on previous search pattern
vim.o.incsearch = true
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.scrolloff = 8 -- is one of my fav
vim.o.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text eacime
vim.o.updatetime = 50 -- faster completion (4000ms default)
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.colorcolumn = '131' -- vertical line to show recommended line length
vim.opt.inccommand = 'split' -- preview incremental substitut

-- custom
mouse = 'a' -- allow the mouse to be used in neovim
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Wqa', 'wqa', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

if vim.fn.has 'nvim' == 1 and vim.fn.executable 'nvr' == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- dotnet compiler errors
vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false
-- endm: ts=2 sts=2 sw=2 et
--
-- https://emojipedia.org/en/stickers/search?q=circle
vim.fn.sign_define('DapBreakpoint', {
  text = '⚪',
  texthl = 'DapBreakpointSymbol',
  linehl = 'DapBreakpoint',
  numhl = 'DapBreakpoint',
})

vim.fn.sign_define('DapStopped', {
  text = '🔴',
  texthl = 'yellow',
  linehl = 'DapBreakpoint',
  numhl = 'DapBreakpoint',
})
vim.fn.sign_define('DapBreakpointRejected', {
  text = '⭕',
  texthl = 'DapStoppedSymbol',
  linehl = 'DapBreakpoint',
  numhl = 'DapBreakpoint',
})
