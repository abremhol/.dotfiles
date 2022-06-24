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
keymap("n", "<leader>r", ":NvimTreeRefresh <cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)


keymap("n", "<leader>m", ":MaximizerToggle!<CR>", opts)

-- Comment
keymap("n", "<leader>c", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", opts)
keymap("v", "<leader>c", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
keymap("x", "<leader>c", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

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

--LSP
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts) -- Code action
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", opts) -- Document Diagnostics
keymap("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>", opts) -- Workspace Diagnostics
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- next error
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts) -- prev error
keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts) -- Quickfix
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts) -- Document Symbols
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts) -- Workspace Symbols

-- Telescope
keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>fz", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<CR>", opts)
keymap("n", "<leader>fB", "<cmd>lua Telescope git_branches<cr>", opts) -- checkout branch
keymap("n", "<leader>fM", "<cmd>lua Telescope man_pages<cr>", opts)
keymap("n", "<leader>fr", "<cmd>lua Telescope oldfiles<cr>", opts) -- recent files
keymap("n", "<leader>fR", "<cmd>lua Telescope registers<cr>", opts)
keymap("n", "<leader>fk", "<cmd>lua Telescope Keymaps<cr>", opts)
keymap("n", "<leader>fC", "<cmd>lua Telescope commands<cr>", opts)

--Dotnet
keymap("n", "<leader>nb", "<cmd>:!dotnet build . <CR>", opts)

-- DAP
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)
keymap("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<CR>", opts)

-- Git
keymap("n", "<leader>gb", "<cmd>:GBranches<CR>", opts)

-- Other
keymap("n", "gf", ":Format<cr>", opts)
-- reload adam module
keymap("n", "<leader><CR>", "<cmd>lua require('plenary.reload').reload_module('adam')<CR>", opts)
-- Easy close terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
