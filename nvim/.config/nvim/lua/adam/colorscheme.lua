vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		neogit = true,
		notify = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		ts_rainbow = true,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
		dap = {
			enabled = true,
			enable_ui = true,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		}
	}
})
local colorscheme = "catppuccin"
--[[ vim.g.tokyonight_style = "night" ]]
--[[ local colorscheme = "tokyonight" ]]

function ColorMyPencils()
	--[[ vim.g.gruvbox_contrast_dark = "hard" ]]
	--[[ vim.g.tokyonight_transparent_sidebar = true ]]
	--[[ vim.g.tokyonight_transparent = true ]]
	--[[ vim.g.gruvbox_invert_selection = "0" ]]
	--[[ vim.opt.background = "dark" ]]

	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
		return
	end

	local hl = function(thing, opts)
		vim.api.nvim_set_hl(0, thing, opts)
	end

	hl("SignColumn", {
		bg = "none",
	})

	hl("ColorColumn", {
		ctermbg = 0,
		bg = "#555555",
	})

	hl("CursorLineNR", {
		bg = "None",
	})

	hl("Normal", {
		bg = "none",
	})

	hl("LineNr", {
		fg = "#5eacd3",
	})

	hl("netrwDir", {
		fg = "#5eacd3",
	})
end
ColorMyPencils()
