local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"omnisharp",
	"angularls",
	"jsonls",
})

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

--[[ for our angular project, should not use in other projects ]]
lsp.configure("tsserver", {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "relative",
		},
	},
})

require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

local omnisharp_bin = vim.fn.stdpath("data") .. "/lsp_servers/omnisharp/omnisharp/OmniSharp"
lsp.configure("omnisharp", {
	-- root_dir = lspconfig.util.root_pattern('.git'),
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	-- for gettigng lsp on libraries
	enable_editorconfig_support = true,
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.local/share/nvim/site/pack/packer/start/"
	local my_snippets_path = vim.env.HOME .. "/.config/nvim/snippets"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	table.insert(paths, my_snippets_path)
    P(paths)
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop("eslint")
		return
	end

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	--[[ gd, gr, gl etc are all set by default by lsp zero  ]]

	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end)
	vim.keymap.set("n", "<leader>lj", function()
		vim.diagnostic.goto_next()
	end)
	vim.keymap.set("n", "<leader>lk", function()
		vim.diagnostic.goto_prev()
	end)
	vim.keymap.set("n", "<leader>la", function()
		vim.lsp.buf.code_action()
	end)
	vim.keymap.set("n", "<leader>lco", function()
		vim.lsp.buf.code_action({
			filter = function(code_action)
				if not code_action or not code_action.data then
					return false
				end

				local data = code_action.data.id
				return string.sub(data, #data - 1, #data) == ":0"
			end,
			apply = true,
		})
	end)
	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.buf.rename()
	end)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
end)

lsp.setup()

-- Toogle diagnostics
local diagnostics_active = true
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.disable()
  end
end, {})

vim.diagnostic.config({
	virtual_text = true,
})
