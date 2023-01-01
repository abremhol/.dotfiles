local nvim_tree = require("nvim-tree")
nvim_tree.setup({
  view = {
    adaptive_size = true,
    width = 50
    }
})

vim.keymap.set("n","<leader>e", vim.cmd.NvimTreeFindFileToggle)
vim.keymap.set("n","<leader>r", vim.cmd.NvimTreeRefresh)
