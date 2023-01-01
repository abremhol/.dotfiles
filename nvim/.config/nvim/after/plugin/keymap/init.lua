vim.keymap.set("n","<leader>u", vim.cmd.UndotreeShow)

vim.keymap.set("v","J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v","K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n","Y", "yg$")
vim.keymap.set("n","J", "mzJ`z")

-- Sessionizer
vim.keymap.set("n","<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n","<leader><leader>x", "<cmd>luafile %<CR>")

-- Resize with arrows
vim.keymap.set("n","<C-Up>", ":resize -2<CR>")
vim.keymap.set("n","<C-Down>", ":resize +2<CR>")
vim.keymap.set("n","<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n","<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n","<leader>m", ":MaximizerToggle!<CR>")

-- Comment

-- focus when searching
vim.keymap.set("n","n", "nzzzv")
vim.keymap.set("n","N", "Nzzzv")
vim.keymap.set("n","Y", "y$")

vim.keymap.set("n","<C-d>", "<C-d>zz")
vim.keymap.set("n","<C-u>", "<C-u>zz")

-- Visual --
-- Stay in indent mode
vim.keymap.set("v","<", "<gv")
vim.keymap.set("v",">", ">gv")

-- Move text up and down hold on to tabbing mode
vim.keymap.set("v","<A-j>", ":m .+1<CR>==")
vim.keymap.set("v","<A-k>", ":m .-2<CR>==")

-- replace what you you pasting
vim.keymap.set("v","p", '"_dP')

-- Move text up and down
vim.keymap.set("x","J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x","K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x","<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x","<A-k>", ":move '<-2<CR>gv-gv")

--LSP


-- DAP
vim.keymap.set("n","<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n","<leader>du", "<cmd>lua require'dapui'.toggle()<CR>")
vim.keymap.set("n","<leader>do", "<cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n","<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n","<leader>dO", "<cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n","<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n","<leader>dC", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n","<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n","<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>")
vim.keymap.set("n","<leader>dl", "<cmd>lua require'dap'.run_last()<CR>")
vim.keymap.set("n","<leader>dx", "<cmd>lua require'dap'.terminate()<CR>")
vim.keymap.set("n","<leader>ds", ":lua vim.g.set_process_id()<CR>")

-- Git

-- Other
vim.keymap.set("n","<leader>gf", ":Format<cr>")
-- Easy close terminal
vim.keymap.set("t","<Esc>", "<C-\\><C-n>")
vim.keymap.set("n","<leader>u", "<cmd>:UndotreeShow<CR>")
vim.keymap.set("n","<leader>zz", "<cmd>ZenMode<CR>")
