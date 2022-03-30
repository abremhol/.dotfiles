local sumneko_root_path = "/home/adam/personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
			Nnoremap("gi", ":lua vim.lsp.buf.implementation()<CR>")
			Nnoremap("gr", ":lua vim.lsp.buf.references()<CR>")
			Nnoremap("gh", ":lua vim.lsp.buf.hover()<CR>")
			Nnoremap("gca", ":lua vim.lsp.buf.code_action()<CR>")
			Nnoremap("gda", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
			Nnoremap("gf", ":lua vim.lsp.buf.formatting()<CR>")
			Nnoremap("<F2>", ":lua vim.lsp.buf.rename()<CR>")
			Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
			Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
			Nnoremap("<F8>", ":lua vim.lsp.diagnostic.goto_next()<CR>")
			Nnoremap("<F7>", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
			Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		end,
	}, _config or {})
end

require'lspconfig'.angularls.setup(config())

-- local lspconfig = require'lspconfig'
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/adam/personal/omnisharp-roslyn/release/run"
require'lspconfig'.omnisharp.setup(config({
    -- root_dir = lspconfig.util.root_pattern('.git'),
    cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
    handlers = { ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      severity_limit = "Warning",
      },
    signs = {
      severity_limit = "Warning",
      },
    })
    ,["textDocument/definition"] = require('omnisharp_extended').handler
    }
}))

require("lspconfig").tsserver.setup(config())

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

require("lspconfig").sumneko_lua.setup(config({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

