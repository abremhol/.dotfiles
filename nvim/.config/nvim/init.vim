" Themes
colorscheme ayu
let ayucolor="dark"

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


let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" vim TODO
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
nmap <Leader>tc <Plug>BujoChecknormal
nmap <Leader>ta <Plug>BujoAddnormal

"terminal easy close"
:tnoremap <Esc> <C-\><C-n>


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
