local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local config = require("adam.lsp.handlers").config
    --[[ P(config) ]]
    local settings = config()


	 if server.name == "jsonls" then
	 	local jsonls_opts = require("adam.lsp.settings.jsonls")
	 	settings = config(jsonls_opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("adam.lsp.settings.sumneko_lua")
	 	settings = config(sumneko_opts)
	 end

	 if server.name == "omnisharp" then
	 	local omnisharp_opts = require("adam.lsp.settings.omnisharp")
	 	settings = config(omnisharp_opts)
	 end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(config(settings))
end)
