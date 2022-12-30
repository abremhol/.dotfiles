local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

null_ls.setup {
  debug = true,
  sources = {
    formatting.prettierd.with { extra_args = {"--single-quote", "--jsx-single-quote" } },
    formatting.stylua
  },
}
