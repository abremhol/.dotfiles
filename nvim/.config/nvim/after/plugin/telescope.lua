vim.keymap.set("n","<C-p>", ":Telescope")
vim.keymap.set("n","<leader>ps", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
vim.keymap.set("n","<C-p>", function()
    require('telescope.builtin').git_files()
end)
vim.keymap.set("n","<Leader>pf", function()
    require('telescope.builtin').find_files()
end)

vim.keymap.set("n","<leader>pw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
vim.keymap.set("n","<leader>pb", function()
    require('telescope.builtin').buffers()
end)
vim.keymap.set("n","<leader>vh", function()
    require('telescope.builtin').help_tags()
end)

-- TODO: Fix this immediately
vim.keymap.set("n","<leader>vwh", function()
    require('telescope.builtin').help_tags()
end)

vim.keymap.set("n","<leader>vrc", function()
    require('adam.telescope').search_dotfiles({ hidden = true })
end)
vim.keymap.set("n","<leader>va", function()
    require('adam.telescope').anime_selector()
end)
vim.keymap.set("n","<leader>vc", function()
    require('adam.telescope').chat_selector()
end)
vim.keymap.set("n","<leader>gc", function()
    require('adam.telescope').git_branches()
end)
vim.keymap.set("n","<leader>gw", function()
    require('telescope').extensions.git_worktree.git_worktrees()
end)
vim.keymap.set("n","<leader>gm", function()
    require('telescope').extensions.git_worktree.create_git_worktree()
end)
vim.keymap.set("n","<leader>td", function()
    require('adam.telescope').dev()
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

local M = {}

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end
return M



