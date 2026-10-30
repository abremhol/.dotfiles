return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    -- The `main` branch is a rewrite: it does not support lazy-loading.
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- `main` has no `ensure_installed`/`auto_install`; parsers are installed
      -- explicitly. `install()` is async and a no-op for installed parsers.
      require('nvim-treesitter').setup {}

      require('nvim-treesitter').install {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'css',
        'c_sharp',
        'bicep',
        'razor',
        'yaml',
      }

      -- Highlighting is not enabled automatically by `main`, so start it for
      -- every filetype that has a parser available.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
