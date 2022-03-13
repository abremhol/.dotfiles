syntax on
filetype plugin indent on

set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4

set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set noshowmode
set clipboard+=unnamedplus

set cmdheight=2
set signcolumn=yes
set statusline+=%F

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

"neovim lsp plugins
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"other
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
Plug 'jremmen/vim-ripgrep'
Plug 'ayu-theme/ayu-vim'
Plug 'szw/vim-maximizer'
Plug 'vuciv/vim-bujo'

"visual"

call plug#end()

" Themes
set termguicolors
colorscheme ayu
let ayucolor="dark"

let mapleader = " "

if executable('rg')
    let g:rg_derive_root='true'
endif

"native file explorer
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

lua require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
lua require("adam")

nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"git
nnoremap <leader>gb :GBranches<CR>

" vim TODO
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
nmap <Leader>tc <Plug>BujoChecknormal
nmap <Leader>ta <Plug>BujoAddnormal

"terminal easy close"
:tnoremap <Esc> <C-\><C-n>

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

"other remaps
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>m :MaximizerToggle!<CR>

nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap <leader>p "_dP
vnoremap <leader>d "_d
nnoremap <leader>d "_d
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap Y y$

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup WHITE_SPACE_BE_GONE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

augroup TOGGLE_RELATIVE_IN_INSERT
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
