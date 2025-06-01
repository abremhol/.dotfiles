-- Copilot.
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      -- I don't find the panel useful.
      panel = { enabled = true },
      suggestion = {
        auto_trigger = true,
        -- Use alt to interact with Copilot.
        keymap = {
          -- Disable the built-in mapping, we'll configure it in nvim-cmp.
          accept = false,
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '/',
        },
      },
      filetypes = {
        markdown = true,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
      config = function(_, opts)
        local copilot = require 'copilot.suggestion'
        local luasnip = require 'luasnip'

        require('copilot').setup(opts)

        local function set_trigger(trigger)
          vim.b.copilot_suggestion_auto_trigger = trigger
          vim.b.copilot_suggestion_hidden = not trigger
        end

        -- Hide suggestions when the completion menu is open.
        --
        vim.api.nvim_create_autocmd('User', {
          pattern = 'BlinkCmpMenuOpen',
          callback = function()
            vim.b.copilot_suggestion_hidden = true
          end,
        })

        vim.api.nvim_create_autocmd('User', {
          pattern = 'BlinkCmpMenuClose',
          callback = function()
            vim.b.copilot_suggestion_hidden = false
            set_trigger(not luasnip.expand_or_locally_jumpable())
          end,
        })

        -- Disable suggestions when inside a snippet.
        vim.api.nvim_create_autocmd('User', {
          pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
          callback = function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
          end,
        })
      end,
    },
  },
}
