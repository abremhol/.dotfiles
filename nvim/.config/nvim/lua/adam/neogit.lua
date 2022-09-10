local neogit = require('neogit')
local nnoremap = require('adam.remap').nnoremap

neogit.setup {}

nnoremap("<leader>mo", function()
    neogit.open({ })
end);

nnoremap("<leader>gfa", "<cmd>!git fetch --all<CR>");
