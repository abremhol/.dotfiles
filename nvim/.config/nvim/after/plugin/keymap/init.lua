local Remap = require("adam.remap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap

-- Sessionizer
nnoremap("<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>")

nnoremap("<leader><leader>x", "<cmd>luafile %<CR>")

nnoremap("<leader>e", ":NvimTreeToggle <cr>")
nnoremap("<leader>r", ":NvimTreeRefresh <cr>")

-- Resize with arrows
nnoremap("<C-Up>", ":resize -2<CR>")
nnoremap("<C-Down>", ":resize +2<CR>")
nnoremap("<C-Left>", ":vertical resize -2<CR>")
nnoremap("<C-Right>", ":vertical resize +2<CR>")

nnoremap("<leader>m", ":MaximizerToggle!<CR>")

-- Comment
nnoremap("<leader>c", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>")
vnoremap("<leader>c", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
xnoremap("<leader>c", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- focus when searching
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("Y", "y$")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Visual --
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move text up and down hold on to tabbing mode
vnoremap("<A-j>", ":m .+1<CR>==")
vnoremap("<A-k>", ":m .-2<CR>==")

-- replace what you you pasting
vnoremap("p", '"_dP')

-- TODO: Thinking about using the below,
-- losing access to all leader d for debug which sucks
--
-- replace a word with yanked text
--[[ xnoremap("<leader>p", '"_dP') ]]
--[[]]
--[[ nnoremap("<leader>y", '"+y') ]]
--[[ vnoremap("<leader>y", '"+y') ]]
--[[ nmap("<leader>Y", '"+Y') ]]
--[[]]
--[[ nnoremap("<leader>d", '"_d') ]]
--[[ vnoremap("<leader>d", '"_d') ]]
--[[]]
--[[ vnoremap("<leader>d", '"_d') ]]
--[[]]
-- Visual Block --
-- Move text up and down
xnoremap("J", ":move '>+1<CR>gv-gv")
xnoremap("K", ":move '<-2<CR>gv-gv")
xnoremap("<A-j>", ":move '>+1<CR>gv-gv")
xnoremap("<A-k>", ":move '<-2<CR>gv-gv")

--LSP
nnoremap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>") -- Code action
nnoremap("<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>") -- Document Diagnostics
nnoremap("<leader>lw", "<cmd>Telescope diagnostics<cr>") -- Workspace Diagnostics
nnoremap("<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
nnoremap("<leader>li", "<cmd>LspInfo<cr>")
nnoremap("<leader>lI", "<cmd>LspInstallInfo<cr>")
nnoremap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>") -- next error
nnoremap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- prev error
nnoremap("<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>") -- Quickfix
nnoremap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
nnoremap("<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>") -- Document Symbols
nnoremap("<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>") -- Workspace Symbols

nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
nnoremap("gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nnoremap("<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nnoremap("<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
nnoremap("gr", "<cmd>Telescope lsp_references<CR>")
nnoremap("gp", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
nnoremap("gn", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
nnoremap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
nnoremap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
nnoremap("<leader>td",":ToggleDiagnostics<cr>")

-- Telescope
nnoremap("<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>")
nnoremap("<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>")
nnoremap("<leader>fg", "<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown())<cr>")
nnoremap(
	"<leader>fb",
	"<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
)
nnoremap("<leader>fh", "<cmd>lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown())<cr>")
nnoremap(
	"<leader>fz",
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<CR>"
)
nnoremap("<leader>fB", "<cmd>Telescope git_branches<cr>") -- checkout branch
nnoremap("<leader>fM", "<cmd>Telescope man_pages<cr>")
nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>") -- recent files
nnoremap("<leader>fR", "<cmd>Telescope registers<cr>")
nnoremap("<leader>fk", "<cmd>Telescope keymaps<cr>")
nnoremap("<leader>fC", "<cmd>Telescope commands<cr>")
nnoremap("<leader>fd", "<cmd>lua require('adam.telescope').search_dotfiles({ hidden = true })<cr>")

-- DAP
nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
nnoremap("<leader>du", "<cmd>lua require'dapui'.toggle()<CR>")
nnoremap("<leader>do", "<cmd>lua require'dap'.step_over()<CR>")
nnoremap("<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
nnoremap("<leader>dO", "<cmd>lua require'dap'.step_out()<CR>")
nnoremap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
nnoremap("<leader>dC", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
nnoremap("<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<CR>")
nnoremap("<leader>dx", "<cmd>lua require'dap'.terminate()<CR>")
nnoremap("<leader>ds", ":lua vim.g.set_process_id()<CR>")

-- Git
nnoremap("<leader>å", "<cmd>:Neogit<CR>")

-- Other
nnoremap("<leader>gf", ":Format<cr>")
-- reload adam module
nnoremap("<leader><CR>", "<cmd>lua require('adam.telescope').reload_modules()<CR>")
-- Easy close terminal
tnoremap("<Esc>", "<C-\\><C-n>")

--build dotnet
nnoremap("<C-b>", ":lua vim.g.dotnet_build_project()<CR>")

