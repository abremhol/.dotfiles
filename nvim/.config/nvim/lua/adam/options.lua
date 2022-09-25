-- :help otions

local options = {
    --prime
    number = true,
	relativenumber = true, -- set relative numbered lines
	errorbells = false, -- no error bells
	tabstop = 4, -- insert 2 spaces for a tab
    softtabstop = 4,
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	expandtab = true, -- convert tabs to spaces
	smartindent = true, -- make indenting smarter again
	wrap = false, -- display lines as one long line
	swapfile = false, -- creates a swapfile
	backup = false, -- creates a backup file
    undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true, -- enable persistent undo
	hlsearch = false, -- highlight all matches on previous search pattern
	incsearch = true,
	termguicolors = true, -- set term gui colors (most terminals support this)
	scrolloff = 8, -- is one of my fav
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	updatetime = 50, -- faster completion (4000ms default)
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	colorcolumn = "131", -- vertical line to show recommended line length

 -- custom
	mouse = "a", -- allow the mouse to be used in neovim
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	showmode = false, -- we don't need to see things like -- INSERT -- anymore already in statusbar
	splitbelow = true, -- force all horizontal splits to go below current window for nvim tree to go to left
	splitright = true, -- force all vertical splits to go to the right of current window for nvim tree to go left
    laststatus = 3, -- show only one statusline for all windows
	pumheight = 10, -- pop up menu height

	--[[ buftype = "", ]]
	--[[ completeopt = { "menuone", "noselect" }, -- mostly just for cmp ]]
	--[[ conceallevel = 0, -- so that `` is visible in markdown files ]]
	--[[ fileencoding = "utf-8", -- the encoding written to a file ]]
	--[[ ignorecase = true, -- ignore case in search patterns ]]
	--[[ secure = false, -- set exrc, allow vim to run commands ]]
    --[[ showtabline = 2, -- always show tabs (shows filename in top left, disabling for now) ]]
	--[[ smartcase = true, -- smart case ]]
	--[[ timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds) ]]
	--[[ writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited ]]
	--[[ cursorline = true, -- highlight the current line ]]
	--[[ numberwidth = 4, -- set number column width to 2 {default 4} ]]
	--[[ sidescrolloff = 8, ]]
	--[[ guifont = "monospace:h17", -- the font used in graphical neovim applications ]]
}

vim.opt.shortmess:append("c")
vim.opt.isfname:append("@-@")

vim.g.mapleader = " "

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")

vim.cmd([[
if executable('rg')
    let g:rg_derive_root='true'
endif
  ]])
