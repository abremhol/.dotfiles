" Themes
colorscheme material
let material_style="deep ocean"

if executable('rg')
    let g:rg_derive_root='true'
endif

lua require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
lua require("adam")


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
