-- Initialize Packer and ensure it's installed
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer manages itself

    -- Theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Syntax Highlighting and Language Support
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'othree/html5.vim'
    use 'hail2u/vim-css3-syntax'

    -- Autocompletion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'

    -- Statusline
    use 'nvim-lualine/lualine.nvim'

    -- File Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Fuzzy Finder
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1',
          requires = { {'nvim-lua/plenary.nvim'} }}
    -- For adding Opening and Closing Commas, Parentheses etc
    use 'windwp/nvim-autopairs'

    -- Git Integration
    use 'tpope/vim-fugitive'

    -- Formatting and Linting
    use 'dense-analysis/ale'
    use 'prettier/vim-prettier'
end)

-- Catppuccin Theme Configuration
require("catppuccin").setup({
    flavour = "mocha", -- Choose theme variant
    transparent_background = true,
    show_end_of_buffer = true,
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        lualine = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
    },
})

-- Apply the Catppuccin colorscheme
vim.cmd([[colorscheme catppuccin]])

-- Modify lualine to match the Catppuccin theme
require('lualine').setup({
    options = {
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
})

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
    ensure_installed = { "bash", "python", "lua", "html", "css", "javascript" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

-- Nvim-tree setup
require("nvim-tree").setup({
    renderer = {
        highlight_opened_files = "all",
        highlight_git = true,
    },
    filters = {
        dotfiles = false,
    },
})

-- Telescope setup
require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = { preview_width = 0.6 },
            vertical = { preview_height = 0.6 },
        },
        sorting_strategy = "ascending",
        color_devicons = true,
        winblend = 10,
    },
})

-- LSP configurations
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.cssls.setup{}

-- Autocompletion
local cmp = require'cmp'

cmp.setup({
  -- Snippet support (if you use a snippet engine like luasnip)
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- For luasnip
    end,
  },

  -- Sources for autocompletion (you can add more sources as needed)
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },       -- LSP completions
    { name = 'luasnip' },        -- Snippet completions
    { name = 'buffer' },         -- Buffer-based completions
    { name = 'path' },           -- Path-based completions
  }),

  -- Mapping configuration
  mapping = {
    -- Use Tab for completion
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()  -- If no completions, fallback to default behavior (Insert Tab)
      end
    end, { 'i', 's' }),

    -- Use Shift+Tab for the previous completion
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()  -- If no completions, fallback to default behavior (Insert Shift+Tab)
      end
    end, { 'i', 's' }),

    -- Confirm completion with Enter
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Optional: Add additional key mappings for other completion behaviors
    -- ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually
    -- ['<C-e>'] = cmp.mapping.close(),         -- Close the completion menu
  },

  -- Completion window settings (optional)
  formatting = {
    format = function(entry, vim_item)
      -- Customize completion item formatting (optional)
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip  = '[Snippet]',
        buffer   = '[Buffer]',
        path     = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },

  -- Other setup configurations
  experimental = {
    native_menu = false,  -- Disable native menu (for better usability)
    ghost_text = true,    -- Show ghost text in the editor for the selected item
  },
})

-- Autopair configuration
require('nvim-autopairs').setup({
    check_ts = true, -- Enable Treesitter integration
    ts_config = {
        lua = { 'string', 'source' }, -- Disable autopairs in specific Treesitter nodes
        javascript = { 'template_string' },
        java = false, -- Don't check Treesitter on Java
    },
    disable_filetype = { 'TelescopePrompt', 'vim' }, -- Disable autopairs in these filetypes
    fast_wrap = {
        map = '<M-e>', -- Key mapping to trigger fast wrap
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    },
})

-- Mappings for commenting
vim.api.nvim_set_keymap('n', '<leader>/', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

-- Key mappings for web development
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })  -- Toggle file explorer
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- Find files

-- Terminal shortcut key setup in Neovim

-- Open terminal in a horizontal split with <leader> + t
vim.api.nvim_set_keymap('n', '<leader>t', ':split term://bash<CR>', { noremap = true, silent = true })

-- Open terminal in a vertical split with <leader> + v
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit term://bash<CR>', { noremap = true, silent = true })

-- Optional: Close terminal with <Esc> in terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })

-- Basic settings
vim.o.number = true        -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.expandtab = true     -- Use spaces instead of tabs
vim.o.shiftwidth = 4       -- Indentation width
vim.o.smartindent = true   -- Smart indentation
vim.o.clipboard = 'unnamedplus' -- Use system clipboard
vim.o.hlsearch = true      -- Highlight search results
vim.o.ignorecase = true    -- Case insensitive searching
vim.o.smartcase = true     -- Case-sensitive if uppercase letter is used
