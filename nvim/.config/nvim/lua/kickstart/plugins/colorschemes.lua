-- not used now, loads themes in select-theme.lua instead
--
-- Example usage:
--   THEME=gruvbox
--   THEME=rose-pine
--
-- If no theme is specified, catppuccin will be used as default.

return {
  -- Catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = true,
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = false,
    },
  },

  -- Everforest theme
  {
    'sainnhe/everforest',
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'medium' -- soft, medium, hard
      vim.g.everforest_better_performance = 1
    end,
  },

  -- Gruvbox theme
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      contrast = 'medium', -- soft, medium, hard
      transparent_mode = false,
    },
  },

  -- Kanagawa theme
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      compile = true,
      dimInactive = true,
    },
  },

  -- Matte Black theme
  {
    'zootedb0t/citruszest.nvim', -- Contains matte-black theme
    lazy = true,
    priority = 1000,
    config = function()
      -- Matte Black is one of the styles available in citruszest.nvim
      require('citruszest').setup {
        style = 'matte_black',
      }
    end,
  },

  -- Nord theme
  {
    'shaunsingh/nord.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
    end,
  },

  --ristretto theme (Monokai Pro)
  {
    'gthelding/monokai-pro.nvim',
    config = function()
      require('monokai-pro').setup {
        filter = 'ristretto',
        override = function()
          return {
            NonText = { fg = '#948a8b' },
          }
        end,
      }
    end,
  },

  -- Rose Pine theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
    opts = {
      variant = 'main', -- auto, main, moon, or dawn
      dark_variant = 'main', -- main or moon
    },
  },

  -- Tokyo Night theme
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      style = 'storm', -- storm, moon, night, day
      transparent = false,
    },
  },
}
