---@module "lazy"
---@return LazyPluginSpec[]
return {
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    -- build = "<cmd>Copilot setup<cr>",
    event = 'BufWinEnter',
    init = function()
      vim.g.copilot_no_maps = true
      vim.g.copilot_filetypes = {
        ['*'] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
        DressingInput = false,
        TelescopePrompt = false,
        ['nvim-tree'] = false, -- for nvim-tree
        ['NvimTree'] = false, -- alternative name sometimes used
        ['lazygit'] = false, -- for lazygit
        ['neo-tree-popup'] = false,
        ['dap-repl'] = false,
      }
    end,
    config = function()
      -- Block the normal Copilot suggestions
      -- This setup and the callback is required for
      -- https://github.com/fang2hou/blink-copilot
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      for _, event in pairs { 'FileType', 'BufUnload', 'BufEnter' } do
        vim.api.nvim_create_autocmd({ event }, {
          group = 'github_copilot',
          callback = function()
            vim.fn['copilot#On' .. event]()
          end,
        })
      end
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Copilot authorization
      'github/copilot.lua',
      -- Progress options optional
      'j-hui/fidget.nvim',
      'ravitemer/codecompanion-history.nvim',
    },
    config = true,
    lazy = true,
    cmd = {
      'CodeCompanion',
      'CodeCompanionChat',
      'CodeCompanionCmd',
      'CodeCompanionActions',
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat', mode = { 'n', 'v' } },
      { '<leader>ap', '<cmd>CodeCompanionActions<cr>', desc = 'Prompt Actions', mode = { 'n', 'v' } },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'copilot',
        },
        inline = {
          adapter = 'copilot',
        },
      },
      show_defaults = false,
      adapters = {
        http = {
          copilot = function()
            local adapters = require 'codecompanion.adapters'
            return adapters.extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
              },
            })
          end,
        },
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = 'gh',
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = 'sc',
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = true,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 0,
          -- Picker interface (auto resolved to a valid picker)
          picker = 'telescope', --- ("telescope", "snacks", "fzf-lua", or "default")
          ---Optional filter function to control which chats are shown when browsing
          chat_filter = nil, -- function(chat_data) return boolean end
          -- Customize picker keymaps (optional)
          picker_keymaps = {
            rename = { n = 'r', i = '<M-r>' },
            delete = { n = 'd', i = '<M-d>' },
            duplicate = { n = '<C-y>', i = '<C-y>' },
          },
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to current chat adapter)
            adapter = nil, -- "copilot"
            ---Model for generating titles (defaults to current chat model)
            model = nil, -- "gpt-4o"
            ---Number of user prompts after which to refresh the title (0 to disable)
            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
            ---Maximum number of times to refresh the title (default: 3)
            max_refreshes = 3,
            format_title = function(original_title)
              -- this can be a custom function that applies some custom
              -- formatting to the title.
              return original_title
            end,
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = true,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion-history',
          ---Enable detailed logging for history extension
          enable_logging = false,

          -- Summary system
          summary = {
            -- Keymap to generate summary for current chat (default: "gcs")
            create_summary_keymap = 'gcs',
            -- Keymap to browse summaries (default: "gbs")
            browse_summaries_keymap = 'gbs',

            generation_opts = {
              adapter = nil, -- defaults to current chat adapter
              model = nil, -- defaults to current chat model
              context_size = 90000, -- max tokens that the model supports
              include_references = true, -- include slash command content
              include_tool_outputs = true, -- include tool execution results
              system_prompt = nil, -- custom system prompt (string or function)
              format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
            },
          },

          -- Memory system (requires VectorCode CLI)
          memory = {
            -- Automatically index summaries when they are generated
            auto_create_memories_on_summary_generation = true,
            -- Path to the VectorCode executable
            vectorcode_exe = 'vectorcode',
            -- Tool configuration
            tool_opts = {
              -- Default number of memories to retrieve
              default_num = 10,
            },
            -- Enable notifications for indexing progress
            notify = true,
            -- Index all existing memories on startup
            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
            index_on_startup = false,
          },
        },
      },
    },
  },
}
