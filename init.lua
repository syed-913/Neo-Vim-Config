-- ============================================================================
-- || Core Configuration using Lazy.nvim                                    ||
-- ============================================================================
-- A. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- B. Set up Lazy.nvim with all plugins
require("lazy").setup({
  -- This line loads the new plugin file
  { import = "plugins.visuals" },
  -- Core Plugin Manager
  "folke/lazy.nvim",
  -- File Icons
  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  -- Utility Plugins
  { "folke/which-key.nvim", opts = {} },
  "nvim-lua/plenary.nvim",
  "akinsho/toggleterm.nvim",

  -- ==========================================================================
  -- || Core Editor Plugins                                                  ||
  -- ==========================================================================

  -- Treesitter: Syntax Highlighting
  -- This plugin provides advanced syntax highlighting and text objects.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- This list ensures the parsers are installed.
        -- "lua" is crucial to fix the file-opening error.
        ensure_installed = { "bash", "python", "lua", "html", "css", "javascript" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        auto_install = true,
      })
    end,
    event = "BufReadPost",
  },

-- Nvim-Tree: File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
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
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Go to parent directory"))
          vim.keymap.set("n", "s", api.node.open.vertical, opts("Open in vertical split"))
          vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open in horizontal split"))
          vim.keymap.set("n", "r", api.fs.rename, opts("Rename file"))
          vim.keymap.set("n", "d", api.fs.remove, opts("Delete file"))
          vim.keymap.set("n", "n", api.fs.create, opts("Create file or directory"))
          vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file"))
          vim.keymap.set("n", "q", api.tree.close, opts("Close Nvim-Tree"))
        end,
      })
    end,
  },

  -- Telescope: Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-file-browser.nvim" } },
    cmd = { "Telescope" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_config = {
            horizontal = { preview_width = 0.6 },
            vertical = { preview_height = 0.6 },
          },
          sorting_strategy = "ascending",
          color_devicons = true,
          winblend = 10,
          -- This is the key change to make Escape work as expected.
          -- It maps the '<ESC>' key in insert and normal mode to close the picker.
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
            n = {
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
        },
      })
      -- This line is crucial for the extension to load correctly
      telescope.load_extension("file_browser")
    end,
  },

  -- Nvim-Autopairs: Adds closing pairs for brackets, quotes etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "nvim-cmp" },
    config = function()
      local npairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "vim" },
      })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

    -- NEW: This plugin uses treesitter to add, remove, and update HTML closing tags.
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },

    -- VGit: Git Integration with signs and hunk actions
  {
  'tanvirtin/vgit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  -- Lazy loading on 'VimEnter' event is necessary.
  event = 'VimEnter',
  config = function() require("vgit").setup() end,
  },
  -- Autocompletion and LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local on_attach = function(client, bufnr)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
      end
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "bashls", "html", "cssls" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
        },
      })
    end,
  },
-- Autocompletion with nvim-cmp
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      -- This is the updated mapping section
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- The new mapping for <Tab>
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- The new mapping for <S-Tab>
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
},
  -- Snippets Engine
    "L3MON4D3/LuaSnip",
  -- Git Integration
  { "tpope/vim-fugitive" },
{
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = false, -- This is the key: it stops auto-suggestions
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<C-Space>", -- Accept suggestion with Ctrl + Space
          accept_word = "<C-Right", -- Accept word with Ctrl + Right
          next = "<M-]>",   -- Cycle to next suggestion (Alt + ])
          prev = "<M-[>",   -- Cycle to previous (Alt + [)
          dismiss = "<C-]>",-- Dismiss suggestion (Ctrl + ])
        },
      },
      panel = { enabled = false }, -- Suggestion is the "ghost text", panel is a separate window
    })
  end,
},

  -- Formatting and Linting
  {
    "mfussenegger/nvim-lint",
    event = "BufEnter",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "pylint" },
        javascript = { "eslint" },
        html = { "htmlhint" },
        css = { "stylelint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePost",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          python = { "black" },
          javascript = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          lua = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = false,
        },
      })
    end,
  },

  -- Auto-save
  {
    "okuuva/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
          defer_save = { "InsertLeave", "TextChanged" },
          cancel_deferred_save = { "InsertEnter" },
        },
        condition = nil,
        write_all_buffers = false,
        noautocmd = false,
        lockmarks = false,
        debounce_delay = 1000,
        debug = false,
        callback = function()
          vim.notify("File saved automatically!", vim.log.levels.INFO)
        end,
      })
    end,
  },

  -- Markdown Live Preview
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
})

-- ============================================================================
-- || Core Settings and Mappings                                             ||
-- ============================================================================

-- A. Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.syntax = "on"
vim.opt.indentkeys:remove({ "0{", "0}", "0)", "0]" })

-- B. Key Mappings
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>l", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "List buffers" })
vim.keymap.set("n", "<leader>h", ":Telescope help_tags<CR>", { noremap = true, silent = true, desc = "Search help tags" })
vim.keymap.set("n", "<leader>f", ":Telescope file_browser<CR>", { noremap = true, silent = true, desc = "Open file browser" })
vim.keymap.set("n", "<leader>th", ":split term://bash<CR>", { noremap = true, silent = true, desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>tv", ":vsplit term://bash<CR>", { noremap = true, silent = true, desc = "Open terminal in vertical split" })
vim.keymap.set('n', '<leader>q', ':bprevious<CR>', { noremap = true, silent = true, desc = "Prev Buffer" })
vim.keymap.set('n', '<leader>e', ':bnext<CR>', { noremap = true, silent = true, desc = "Next Buffer" })

-- Trigger Copilot manually in Insert 
vim.keymap.set('n', '<leader>!', function()
  require("copilot.suggestion").next()
end, { desc = "Manual Copilot Suggest" })
