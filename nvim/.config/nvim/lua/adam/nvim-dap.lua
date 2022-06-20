require("dapui").setup({
    icons = {
      expanded = "⯆",
      collapsed = "⯈",
      circular = "↺"
    },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = {"<CR>", "<2-LeftMouse>"},
      open = "o",
      remove = "d",
      edit = "e",
    },
    layout = {
      elements = {
        -- You can change the order of elements in the sidebar
        "scopes",
        --"watches"
      },
      size = 40,
      position = "left" -- Can be "left" or "right"
    },
    -- tray = {
    --   elements = {
    --     "repl"
    --   },
    --   size = 10,
    --   position = "bottom" -- Can be "bottom" or "top"
    -- },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil   -- Floats will be treated as percentage of your screen.
    }
  })

  require("nvim-dap-virtual-text").setup()
  local dap = require('dap')
  dap.adapters.netcoredbg = {
    type = 'executable',
    command = '/home/adam/.local/share/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
  }

  dap.configurations.cs = {
    {
      type = "netcoredbg",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        local fullbufdir = vim.fn.expand('%:p:h')
        local lastbufdir = vim.fn.expand('%:p:h:t')
        return vim.fn.input('Path to dll: ', fullbufdir .. '/bin/Debug/net6.0/' .. lastbufdir .. '.dll', 'file')
      end,
    },
    {
      type = "netcoredbg",
      name = "attach - netcoredbg",
      request = "attach",
      processId = function()
        local pid = require('dap.utils').pick_process()
        vim.fn.setenv('NETCOREDBG_ATTACH_PID', pid)
        return pid
      end,
    },
}
