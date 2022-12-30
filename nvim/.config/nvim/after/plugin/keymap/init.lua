vim.keymap.set("n","<leader>pv", ":Ex<CR>")
vim.keymap.set("n","<leader>u", ":UndotreeShow<CR>")

vim.keymap.set("v","J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v","K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n","Y", "yg$")
vim.keymap.set("n","J", "mzJ`z")

-- Sessionizer
vim.keymap.set("n","<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n","<leader><leader>x", "<cmd>luafile %<CR>")

vim.keymap.set("n","<leader>e", ":NvimTreeToggle <cr>")
vim.keymap.set("n","<leader>r", ":NvimTreeRefresh <cr>")

-- Resize with arrows
vim.keymap.set("n","<C-Up>", ":resize -2<CR>")
vim.keymap.set("n","<C-Down>", ":resize +2<CR>")
vim.keymap.set("n","<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n","<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n","<leader>m", ":MaximizerToggle!<CR>")

-- Comment
vim.keymap.set("n","<leader>c", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>")
vim.keymap.set("v","<leader>c", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
vim.keymap.set("x","<leader>c", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

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
vim.keymap.set("n","<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>") -- Code action
vim.keymap.set("n","<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>") -- Document Diagnostics
vim.keymap.set("n","<leader>lw", "<cmd>Telescope diagnostics<cr>") -- Workspace Diagnostics
vim.keymap.set("n","<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
vim.keymap.set("n","<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n","<leader>lI", "<cmd>LspInstallInfo<cr>")
vim.keymap.set("n","<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- next error
vim.keymap.set("n","<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- prev error
vim.keymap.set("n","<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>") -- Quickfix
vim.keymap.set("n","<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n","<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>") -- Document Symbols
vim.keymap.set("n","<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>") -- Workspace Symbols

vim.keymap.set("n","gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n","gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
vim.keymap.set("n","K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n","gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n","<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n","gr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n","gp", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
vim.keymap.set("n","gn", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
vim.keymap.set("n","gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n","<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
vim.keymap.set("n","<leader>td",":ToggleDiagnostics<cr>")


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
vim.keymap.set("n","<leader>å", "<cmd>:Neogit<CR>")

-- Other
vim.keymap.set("n","<leader>gf", ":Format<cr>")
-- Easy close terminal
vim.keymap.set("t","<Esc>", "<C-\\><C-n>")
vim.keymap.set("n","<leader>u", "<cmd>:UndotreeShow<CR>")
vim.keymap.set("n","<leader>zz", "<cmd>ZenMode<CR>")
