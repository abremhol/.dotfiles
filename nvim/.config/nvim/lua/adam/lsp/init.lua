local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("adam.lsp.lsp-installer")
require("adam.lsp.handlers").setup()
