local neogit = require("neogit")

neogit.setup({})

vim.keymap.set("n","<leader>å", function()
	neogit.open({})
end)

vim.keymap.set("n","<leader>fa", "<cmd>!git fetch --all<CR>")
