-- debug.lua

return {
  'mfussenegger/nvim-dap',
  enabled = true,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dap.set_log_level 'TRACE'

    dap.listeners.before.attach.dapui_config = function()
      require('nvim-tree.api').tree.close()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      require('nvim-tree.api').tree.close()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
      require('nvim-tree.api').tree.open()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
      require('nvim-tree.api').tree.open()
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
        require('dapui').setup {
          expand_lines = true,
          controls = { enabled = false }, -- no extra play/step buttons
          floating = { border = 'rounded' },
          -- Set dapui window
          render = {
            max_type_length = 60,
            max_value_lines = 200,
          },
          layouts = {
            {
              elements = {
                {
                  id = 'scopes',
                  size = 0.75,
                },
                {
                  id = 'breakpoints',
                  size = 0.25,
                },
                -- {
                --   id = 'stacks',
                --   size = 0.25,
                -- },
                -- {
                --   id = 'watches',
                --   size = 0.25,
                -- },
              },
              position = 'left',
              size = 40,
            },
            {
              elements = {
                {
                  id = 'repl',
                  size = 1,
                },
                -- {
                --   id = 'console',
                --   size = 0.75,
                -- },
              },
              position = 'bottom',
              size = 10,
            },
          },
        }
      end,
    },
  },
}
