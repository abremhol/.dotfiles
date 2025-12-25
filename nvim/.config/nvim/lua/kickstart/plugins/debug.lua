-- debug.lua

return {
  'mfussenegger/nvim-dap',
  enabled = true,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dap.set_log_level 'TRACE'

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dap-float',
      callback = function(args)
        vim.keymap.set('n', 'q', function()
          vim.api.nvim_win_close(0, true)
        end, { buffer = args.buf, silent = true })
      end,
    })

    vim.keymap.set('n', 'q', function()
      dap.close()
      dapui.close()
    end, {})

    vim.keymap.set('n', '<F5>', dap.continue, {})
    vim.keymap.set('n', '<F10>', dap.step_over, {})
    vim.keymap.set('n', '<leader>dO', dap.step_over, {})
    vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, {})
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, {})
    vim.keymap.set('n', '<leader>dj', dap.down, {})
    vim.keymap.set('n', '<leader>dk', dap.up, {})
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})

    local function smart_hover()
      if dap.session() then
        require('dap.ui.widgets').hover()
      else
        vim.lsp.buf.hover()
      end
    end

    vim.keymap.set('n', 'K', smart_hover, { desc = 'Hover (LSP or DAP)' })

    vim.keymap.set('n', '<Right>', dap.step_over, {})
    vim.keymap.set('n', '<Down>', dap.step_into, {})
    vim.keymap.set('n', '<Up>', dap.step_out, {})
    vim.keymap.set('n', '<Left>', dap.continue, {})
  end,
  dependencies = {
    { 'nvim-neotest/nvim-nio' },
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup()
      end,
    },
  },
}
