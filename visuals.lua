
-- It is loaded by lazy.nvim from the main config file.

return {
  -- =========================================================================
  -- 1. Kanagawa Theme: 'rebelot/kanagawa.nvim'
  -- A beautifully crafted theme inspired by Japanese art and nature.
  -- =========================================================================
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      -- This command sets the Kanagawa theme as your default colorscheme.
      vim.cmd.colorscheme("kanagawa")
    end,
  },

  -- =========================================================================
  -- 2. Statusline: 'nvim-lualine/lualine.nvim'
  -- The configuration for your existing statusline plugin.
  -- =========================================================================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          -- Separators to create a clean, modern look.
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        -- You can add more sections here to display information like
        -- your Git branch, LSP diagnostics, and file information.
        -- For example:
        -- sections = {
        --   lualine_a = {'mode'},
        --   lualine_b = {'branch', 'diff', 'diagnostics'},
        --   lualine_c = {'filename'},
        --   lualine_x = {'filetype'},
        --   lualine_y = {'progress'},
        --   lualine_z = {'location'}
        --}
      })
    end,
  },

  -- =========================================================================
  -- 3. Indentation Guides: 'indent-blankline.nvim'
  -- (The corrected configuration)
  -- =========================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = {
        char = "•",
        tab_char = "•",
      },
      scope = {
        enabled = true,
      },
    },
    init = function()
      vim.g.indent_blankline_enabled = true
    end,
  },

  -- =========================================================================
  -- 4. Bufferline: 'akinsho/bufferline.nvim'
  -- =========================================================================
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = "slant",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        modified_icon = "●",
        custom_filter = function(buf_number)
          local buftype = vim.api.nvim_get_option_value('buftype', {
            buf = buf_number
          })
          return buftype ~= 'terminal'
        end,
      },
    },
  },

  -- =========================================================================
  -- 5. Matchup: 'andymass/vim-matchup'
  -- =========================================================================
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
  },

  -- =========================================================================
  -- 6. Dimming & Zen Mode: 'folke/twilight.nvim' and 'folke/zen-mode.nvim'
  -- =========================================================================
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      dimming = {
        alpha = 0.5,
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        options = {
          number = false,
          relativenumber = false,
        },
      },
    },
  },
}

