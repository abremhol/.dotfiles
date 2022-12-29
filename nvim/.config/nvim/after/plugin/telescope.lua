vim.keymap.set("n","<C-p>", ":Telescope")
vim.keymap.set("n","<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
vim.keymap.set("n","<C-p>", function()
    require('telescope.builtin').git_files()
end)
vim.keymap.set("n","<Leader>ff", function()
    require('telescope.builtin').find_files()
end)

vim.keymap.set("n","<leader>fw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
vim.keymap.set("n","<leader>fg", function()
    require('telescope.builtin').live_grep()
end)
vim.keymap.set("n","<leader>fb", function()
    require('telescope.builtin').buffers()
end)
vim.keymap.set("n","<leader>fh", function()
    require('telescope.builtin').help_tags()
end)

vim.keymap.set("n","<leader>fz", function()
    require('telescope.builtin').current_buffer_fuzzy_find()
end)

vim.keymap.set("n","<leader>fM", function()
    require('telescope.builtin').man_pages()
end)

vim.keymap.set("n","<leader>fo", function()
    require('telescope.builtin').oldfiles()
end)

vim.keymap.set("n","<leader>fk", function()
    require('telescope.builtin').keymaps()
end)

vim.keymap.set("n","<leader>fB", function()
    require('adam.telescope').git_branches()
end)

vim.keymap.set("n","<leader>fd", function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end)

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		file_sorter = require("telescope.sorters").get_fzy_sorter,
	},
	pickers = {
		find_files = {
			hidden = true,
			file_ignore_patterns = { ".git", "node_modules", "bin", "obj" },
			no_ignore = true,
		},
		live_grep = {
			hidden = true,
			file_ignore_patterns = { ".git", "node_modules", "bin", "obj" },
			no_ignore = true,
		},
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})
