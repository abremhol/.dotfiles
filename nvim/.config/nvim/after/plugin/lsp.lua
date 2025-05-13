local lsp = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local telescope_builtin = require("telescope.builtin")

mason.setup({})

mason_lspconfig.setup({
    ensure_installed = { 'ts_ls', 'eslint', 'lua_ls', 'omnisharp', 'angularls', 'jsonls' },
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

--[[ for our angular project, should not use in other projects ]]
lsp.configure("ts_ls", {
    init_options = {
        preferences = {
            importModuleSpecifierPreference = "relative",
        },
    },
})

require("lspconfig").jsonls.setup({
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

local mason_registry = require("mason-registry")
--[[ local omnisharp = mason_registry.get_package("omnisharp") -- note that this will error if you provide a non-existent package name ]]
--[[ local mason_omnisharp_path = omnisharp.get_install_path() .. "/omnisharp" ]]

--[[ local omnisharp_bin = vim.fn.stdpath("data") .. "/lsp_servers/omnisharp/omnisharp/OmniSharp" ]]
--[[ lsp.configure("omnisharp", { ]]
--[[ 	-- root_dir = lspconfig.util.root_pattern('.git'), ]]
--[[ 	cmd = { mason_omnisharp_path, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) }, ]]
--[[ 	-- for gettigng lsp on libraries ]]
--[[ 	enable_editorconfig_support = true, ]]
--[[ 	handlers = { ]]
--[[ 		["textDocument/definition"] = require("omnisharp_extended").handler, ]]
--[[ 	}, ]]
--[[ }) ]]

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- Setup nvim-cmp with default mappings
local cmp_mappings = {
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
}

-- Disable completion with Tab to allow Copilot to work
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

-- Setup lsp-zero with the correct mappings
lsp.setup({
    mapping = cmp_mappings,
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer",   keyword_length = 3 },
        { name = "luasnip",  keyword_length = 2 },
    },
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
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop("eslint")
        return
    end

    --[[ temporary fix for error lsp/semantic_tokens.lua:344: Vim(redraw):E5248: until omnisharp fixes their tokentypes ]]
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider.legend = {
            tokenModifiers = { "static" },
            tokenTypes = {
                "comment",
                "excluded",
                "identifier",
                "keyword",
                "keyword",
                "number",
                "operator",
                "operator",
                "preprocessor",
                "string",
                "whitespace",
                "text",
                "static",
                "preprocessor",
                "punctuation",
                "string",
                "string",
                "class",
                "delegate",
                "enum",
                "interface",
                "module",
                "struct",
                "typeParameter",
                "field",
                "enumMember",
                "constant",
                "local",
                "parameter",
                "method",
                "method",
                "property",
                "event",
                "namespace",
                "label",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "xml",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
                "regexp",
            },
        }
    end

    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end)
    vim.keymap.set("n", "<leader>lj", function()
        vim.diagnostic.goto_next()
    end)
    vim.keymap.set("n", "gn", function()
        vim.diagnostic.goto_next({ border = "rounded" })
    end)
    vim.keymap.set("n", "<leader>lk", function()
        vim.diagnostic.goto_prev()
    end)
    vim.keymap.set("n", "gp", function()
        vim.diagnostic.goto_prev({ border = "rounded" })
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
    vim.keymap.set("n", "<leader>lR", vim.cmd.LspRestart)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end)
    vim.keymap.set("n", "<leader>sh", function()
        vim.lsp.buf.signature_help()
    end)
    vim.keymap.set("n", "<leader>gf", vim.cmd.LspZeroFormat)
    vim.keymap.set("n", "<leader>lf", vim.cmd.LspZeroFormat)
    -- Document Diagnostics
    vim.keymap.set("n", "<leader>ld", function()
        telescope_builtin.diagnostics({ bufnr = opts.buffer })
    end)
    --[[ Workspace Diagnostics ]]
    vim.keymap.set("n", "<leader>lw", function()
        telescope_builtin.diagnostics()
    end)
    vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo)
    --[[ Quickfix ]]
    vim.keymap.set("n", "<leader>lq", function()
        vim.lsp.diagnostic.set_loclist()
    end)
    --[[ Document Symbols ]]
    vim.keymap.set("n", "<leader>ls", function()
        telescope_builtin.lsp_document_symbols()
    end)
    --[[ Workspace Symbols ]]
    vim.keymap.set("n", "<leader>lS", function()
        telescope_builtin.lsp_dynamic_workspace_symbols()
    end)
    vim.keymap.set("n", "<leader>td", vim.cmd.ToggleDiagnostics)
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
