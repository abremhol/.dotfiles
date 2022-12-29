local M = {}


M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "large",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

end

M.config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client, bufnr)
            if client.name == "tsserver" then
                client.server_capabilities.document_formatting = false
            end
			vim.keymap.set("n","gd", function() vim.lsp.buf.definition() end)
			vim.keymap.set("n","K", function() vim.lsp.buf.hover() end)
			vim.keymap.set("n","<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			vim.keymap.set("n","<leader>lj", function() vim.diagnostic.goto_next() end)
			vim.keymap.set("n","<leader>lk", function() vim.diagnostic.goto_prev() end)
			vim.keymap.set("n","<leader>la", function() vim.lsp.buf.code_action() end)
			vim.keymap.set("n","<leader>lco", function() vim.lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
			vim.keymap.set("n","<leader>gr", function() vim.lsp.buf.references() end)
			vim.keymap.set("n","<leader>lr", function() vim.lsp.buf.rename() end)
			vim.keymap.set("i","<C-h>", function() vim.lsp.buf.signature_help() end)
            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]]
		end,
	}, _config or {})
end


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


return M
