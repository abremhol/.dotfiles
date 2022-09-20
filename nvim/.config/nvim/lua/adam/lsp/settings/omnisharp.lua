local omnisharp_bin = vim.fn.stdpath("data") .. "/lsp_servers/omnisharp/omnisharp/OmniSharp"
return {
    -- root_dir = lspconfig.util.root_pattern('.git'),
    cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid())},
    -- for gettigng lsp on libraries
    enable_editorconfig_support = true,
    handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler
    }
}
