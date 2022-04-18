local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Sessionizer
keymap("n", "<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle <cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers shift l or h
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymap("n", "<Leader><CR>", ":so ~/.config/nvim/init.vim<CR>", opts)
keymap("n", "<leader>m", ":MaximizerToggle!<CR>", opts)
keymap("v", "<leader>c", "<cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", opts)
keymap("n", "<leader>c", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", opts)

-- focus when searching
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "Y", "y$", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down hold on to tabbing mode
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- keep what you are pasting
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope
keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown())<cr>", opts)

-- DAP
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>B", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<M-k>", "<cmd>lua require'dapui'.eval()<CR>", opts)
keymap("v", "<M-k>", "<cmd>lua require'dapui'.eval()<CR>", opts)

-- Git
keymap("n", "<leader>gb", "<cmd>:GBranches<CR>", opts)

-- Bujo
--
vim.g["bujo#todo_file_path "] = '/home/adam/.cache/bujo'

-- Other
keymap("n", "gf", ":Format<cr>", opts)
-- Easy close terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
