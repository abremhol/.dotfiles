local api = vim.api
-- toggle relative in insert

local toggleRelativeGroup = api.nvim_create_augroup("ToggleRelativeInInsert", {clear = true})
api.nvim_create_autocmd({"BufEnter","FocusGained", "InsertLeave"}, {
  command = "lua vim.opt.relativenumber = true",
  group = toggleRelativeGroup
})
api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
  command = "lua vim.opt.relativenumber = false",
  group = toggleRelativeGroup
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

