" Themes
colorscheme material
let material_style="deep ocean"

lua require("adam")


" vim TODO
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
nmap <Leader>tc <Plug>BujoChecknormal
nmap <Leader>ta <Plug>BujoAddnormal

"terminal easy close"
:tnoremap <Esc> <C-\><C-n>
