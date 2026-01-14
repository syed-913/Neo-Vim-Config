return {
  -- Theme
  { 
    "datsfilipe/vesper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vesper").setup({
        transparent = false,
        italics = { comments = true, strings = true },
      })
      vim.cmd.colorscheme("vesper")
    end,
  },
  
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "vesper",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        separator_style = "slant",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
      },
    },
  },

  -- Matchup
  { "andymass/vim-matchup", event = "VeryLazy" },
}
