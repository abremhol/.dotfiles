local nvim_tree = require("nvim-tree")
nvim_tree.setup({
  view = {
    adaptive_size = true,
    width = 50
    }
})

vim.keymap.set("n","<leader>e", ":NvimTreeFindFileToggle <cr>")
vim.keymap.set("n","<leader>r", ":NvimTreeRefresh <cr>")
