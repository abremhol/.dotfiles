local function add_dotnet_mappings()
  local dotnet = require 'easy-dotnet'

  vim.api.nvim_create_user_command('Secrets', function()
    dotnet.secrets()
  end, {})

  vim.keymap.set('n', '<C-p>', function()
    dotnet.run_with_profile(true)
  end, { nowait = true })

  vim.keymap.set('n', '<C-b>', function()
    dotnet.build_default_quickfix()
  end, { nowait = true })
end

return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local dotnet = require 'easy-dotnet'
    dotnet.setup {
      lsp = {
        enabled = true,
        config = {
          settings = {
            ['csharp|background_analysis'] = {
              dotnet_compiler_diagnostics_scope = 'fullSolution',
            },
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      },
      debugger = {
        -- or full path to netcoredbg executable. (can be installed with mason)
        bin_path = 'netcoredbg',
      },
      auto_bootstrap_namespace = {
        type = 'file_scoped',
        enabled = true,
      },
      server = {
        use_visual_studio = false,
        ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
        log_level = 'Off',
      },
      test_runner = {
        enable_buffer_test_execution = true,
        -- -@type "split" | "float" | "buf"
        viewmode = 'float',
        -- enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
        noBuild = true,
        icons = {
          passed = '',
          skipped = '',
          failed = '',
          success = '',
          reload = '',
          test = '',
          sln = '󰘐',
          project = '󰘐',
          dir = '',
          package = '',
        },
        mappings = {
          run_test_from_buffer = { lhs = '<leader>r', desc = 'run test from buffer' },
          filter_failed_tests = { lhs = '<leader>fe', desc = 'filter failed tests' },
          debug_test = { lhs = '<leader>d', desc = 'debug test' },
          go_to_file = { lhs = '<leader>gtf', desc = 'go to file' },
          run_all = { lhs = '<leader>R', desc = 'run all tests' },
          run = { lhs = '<leader>r', desc = 'run test' },
          peek_stacktrace = { lhs = '<leader>p', desc = 'peek stacktrace of failed test' },
          expand = { lhs = 'o', desc = 'expand' },
          expand_node = { lhs = 'E', desc = 'expand node' },
          expand_all = { lhs = '-', desc = 'expand all' },
          collapse_all = { lhs = 'W', desc = 'collapse all' },
          close = { lhs = 'q', desc = 'close testrunner' },
          refresh_testrunner = { lhs = '<C-r>', desc = 'refresh testrunner' },
        },
        --- Optional table of extra args e.g "--blame crash"
        additional_args = {},
      },
    }
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if dotnet.is_dotnet_project() then
          add_dotnet_mappings()
        end
      end,
    })
  end,
}
