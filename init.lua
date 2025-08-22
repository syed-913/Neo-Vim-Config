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
  -- Core Plugin Manager
  "folke/lazy.nvim",

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

  -- Lualine: Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- Nvim-Tree: File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle" },
    config = function()
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
          width = 30,
          side = "left",
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

  -- Git Integration
  { "tpope/vim-fugitive" },

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

  -- GitHub Copilot
  {
    "github/copilot.vim",
    ft = { "lua", "python", "javascript", "html", "css" },
  },

  -- TMUX Integration
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({})
    end,
    event = "VeryLazy",
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
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"

-- B. Key Mappings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "List buffers" })
vim.keymap.set("n", "<leader>h", ":Telescope help_tags<CR>", { noremap = true, silent = true, desc = "Search help tags" })
vim.keymap.set("n", "<leader>s", ":Telescope file_browser<CR>", { noremap = true, silent = true, desc = "Open file browser" })
vim.keymap.set("n", "<leader>t", ":split term://bash<CR>", { noremap = true, silent = true, desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>v", ":vsplit term://bash<CR>", { noremap = true, silent = true, desc = "Open terminal in vertical split" })

-- C. TMUX keymaps using `toggleterm`
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal" })
