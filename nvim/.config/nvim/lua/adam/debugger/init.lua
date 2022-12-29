local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

daptext.setup()
dapui.setup({
    layouts = {
        {
            elements = {
                "console",
            },
            size = 7,
            position = "bottom",
        },
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40,
            position = "left",
        }
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("adam.debugger.node");
require("adam.debugger.dotnet");

--Extra keymaps for arrow keys
vim.keymap.set("n","<leader>ö", function()
    dapui.toggle(1)
end)
vim.keymap.set("n","<leader>Ö", function()
    dapui.toggle(2)
end)

vim.keymap.set("n","<leader><leader>", function()
    dap.close()
end)

vim.keymap.set("n","<Up>", function()
    dap.continue()
end)
vim.keymap.set("n","<Down>", function()
    dap.step_over()
end)
vim.keymap.set("n","<Right>", function()
    dap.step_into()
end)
vim.keymap.set("n","<Left>", function()
    dap.step_out()
end)

vim.keymap.set("n","<Leader>b", function()
    dap.toggle_breakpoint()
end)
vim.keymap.set("n","<Leader>B", function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)

-- Hover with K
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap(
    'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end
