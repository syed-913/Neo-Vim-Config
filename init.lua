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
    use { "nvim-telescope/telescope-file-browser.nvim" }
    -- For adding Opening and Closing Commas, Parentheses etc
    use 'windwp/nvim-autopairs'

    -- Git Integration
    use 'tpope/vim-fugitive'

    -- Formatting and Linting
    use 'dense-analysis/ale'
    use 'prettier/vim-prettier'
    -- Auto-save
    use({
        "okuuva/auto-save.nvim",
        tag = 'v1*',
        config = function()
            require("auto-save").setup({
                enabled = true, -- Enable auto-save when the plugin is loaded
                trigger_events = {
                    immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- Events that trigger an immediate save
                    defer_save = { "InsertLeave", "TextChanged" }, -- Events that trigger a deferred save (after debounce_delay)
                    cancel_deferred_save = { "InsertEnter" }, -- Events that cancel pending deferred save
                },
                condition = nil, -- No specific condition (set to a function if needed)
                write_all_buffers = false, -- Do not write all buffers when the current buffer is saved
                noautocmd = false, -- Don't disable autocmds when saving
                lockmarks = false, -- Don't lock marks when saving
                debounce_delay = 1000, -- Delay after which a pending save is executed
                debug = false, -- Set to true to enable logging to 'auto-save.log'
                callback = function()
                    -- Display a message whenever auto-save runs
                    local time = vim.fn.strftime("%H:%M:%S")
                    vim.notify("File saved automatically!", vim.log.levels.INFO)
                end,
            })
        end
    })
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
    git = {
        enable = true,
        ignore = false,
    },
    view = {
        width = 30, -- Adjust the width of the tree window
        side = "left", -- Place the tree on the left
    },
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
            return { desc = 'NvimTree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Custom key mappings
        vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Go to parent directory'))
        vim.keymap.set('n', 's', api.node.open.vertical, opts('Open in vertical split'))
        vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open in horizontal split'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename file'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete file'))
        vim.keymap.set('n', 'n', api.fs.create, opts('Create file or directory'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open file'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close Nvim-Tree'))
    end,
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
    pickers = {
        find_files = {
            hidden = true, -- Include hidden files
        },
    },
    extensions = {
        file_browser = {
            theme = "ivy", -- Use a compact dropdown theme
            hijack_netrw = true, -- Replace netrw with Telescope file browser
        },
    },
})

-- Load Telescope extensions
require("telescope").load_extension("file_browser")

-- Key bindings for Telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = "List buffers" })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true, desc = "Search help tags" })
vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<CR>', { noremap = true, silent = true, desc = "Open file browser" })

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
