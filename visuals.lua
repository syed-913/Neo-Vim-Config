
-- It is loaded by lazy.nvim from the main config file.

return {
  -- =========================================================================
  -- 1. Vesper Theme: 'datsfilipe/vesper.nvim'
  -- =========================================================================
  { 
    "datsfilipe/vesper.nvim",
    lazy = false,    -- Themes should load immediately
    priority = 1000, -- Load this before all other plugins
    opts = {
      transparent = false,
      italics = {
        comments = true,
        -- keywords = true,
        -- functions = true,
        strings = true,
        -- variables = true,
      },
      overrides = {},
      palette_overrides = {}
    },
    config = function(_, opts)
      require("vesper").setup(opts) -- Pass the opts table above to setup
      vim.cmd.colorscheme("vesper") -- Actually activate the theme
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
          theme = "vesper",
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
  -- =========================================================================
  -- 7. LuxMotion: Smooth animations for all motions
  -- =========================================================================
  {
    "LuxVim/nvim-luxmotion",
    event = "VeryLazy",
    config = function()
      require("luxmotion").setup({
        cursor = {
          duration = 200, -- speed of cursor movement in ms
          enabled = true,
        },
        scroll = {
          duration = 500, -- speed of screen scrolling in ms
          enabled = true,
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true } },
      presets = {
        bottom_search = true, -- classic bottom search
        command_palette = true, -- center floating command line
        long_message_to_split = true, 
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      notifier = { enabled = true }, -- Slick notification popups
      scroll = { enabled = true },   -- Smooth physics-based scrolling
      statuscolumn = { enabled = true }, -- Better line numbers/signs
    },
  },
}
