-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'Y', 'yg$')
vim.keymap.set('n', 'J', 'mzJ`z')

-- Sessionizer
vim.keymap.set('n', '<C-f>', '<cmd>:silent !tmux neww tmux-sessionizer<CR>')

-- vim.keymap.set('n', '<leader><leader>x', '<cmd>luafile %<CR>')

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Comment
vim.keymap.set('x', '<leader>c', "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
vim.keymap.set('n', '<leader>c', "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>")
vim.keymap.set('v', '<leader>c', "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- Nvim Tree
vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFindFileToggle)
vim.keymap.set('n', '<leader>r', vim.cmd.NvimTreeRefresh)

-- focus when searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'Y', 'y$')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move text up and down hold on to tabbing mode
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==')

-- replace what you you pasting
vim.keymap.set('v', 'p', '"_dP')

-- Move text up and down
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv")
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Easy close terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>zz', '<cmd>ZenMode<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set({ 'n', 'v' }, '<leader>gf', function()
  local range = nil
  -- Check if in visual mode and get the selection range
  if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == '\22' then
    -- Exit visual mode to avoid issues
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)

    -- Get the start and end of visual selection
    local start_pos = vim.api.nvim_buf_get_mark(0, '<')
    local end_pos = vim.api.nvim_buf_get_mark(0, '>')

    -- Get the line content to calculate proper column indices
    local start_line_content = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, start_pos[1], false)[1] or ''
    local end_line_content = vim.api.nvim_buf_get_lines(0, end_pos[1] - 1, end_pos[1], false)[1] or ''

    -- Ensure column indices are within bounds
    local start_col = math.min(start_pos[2], #start_line_content)
    local end_col = math.min(end_pos[2] + 1, #end_line_content)

    -- Create range object with 0-indexed positions as required by conform
    range = {
      start = { start_pos[1], start_col },
      ['end'] = { end_pos[1], end_col },
    }

    -- Ensure valid range
    local line_count = vim.api.nvim_buf_line_count(0)
    if range.start[1] > line_count or range['end'][1] > line_count then
      vim.notify('Invalid range selection', vim.log.levels.ERROR)
      return
    end
  end

  -- Format with or without range
  require('conform').format({
    async = true,
    range = range,
    lsp_fallback = true,
  }, function(err)
    if err then
      vim.notify('Formatting error: ' .. err, vim.log.levels.ERROR)
    end
  end)
end, { desc = 'Format code (normal=file, visual=selection)' })
-- vim: ts=2 sts=2 sw=2 et
