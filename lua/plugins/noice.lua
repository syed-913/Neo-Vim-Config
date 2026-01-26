return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      -- ====================================
      -- CMDLINE CUSTOMIZATION
      -- ====================================
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        format = {
          -- `:` commands with Vim syntax
          cmdline = {
            pattern = "^:",
            icon = "  ",
            lang = "vim",
            title = " CmdLine ",
          },
          -- `/` search with regex highlighting
          search_down = {
            kind = "search",
            pattern = "^/",
            icon = "󰍉 ",
            lang = "regex",
            title = " Search ↓ ",
          },
          -- `?` search backward
          search_up = {
            kind = "search",
            pattern = "^%?",
            icon = "󰍉 ",
            lang = "regex",
            title = " Search ↑ ",
          },
          -- `!` shell commands with bash syntax
          filter = {
            pattern = "^:%s*!",
            icon = "$ ",
            lang = "bash",
            title = " Shell ",
          },
          -- `:lua` commands with Lua syntax
          lua = {
            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
            icon = " ",
            lang = "lua",
            title = " Lua ",
          },
          -- `:help` commands
          help = {
            pattern = "^:%s*he? l? p? %s+",
            icon = "󰋖 ",
            title = " Help ",
          },
          -- `input()` dialog
          input = {
            view = "cmdline_input",
            icon = "󰥻 ",
          },
        },
      },

      -- ====================================
      -- SMART MESSAGE ROUTING
      -- ====================================
      routes = {
        -- Skip annoying search count messages
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },

        -- Long messages go to split (more than 15 lines)
        {
          view = "split",
          filter = { event = "msg_show", min_height = 15 },
          opts = { replace = false, merge = false },
        },

        -- LSP progress in mini view (unobtrusive)
        {
          view = "mini",
          filter = { event = "lsp", kind = "progress" },
        },

        -- Errors get attention
        {
          view = "notify",
          filter = { error = true },
          opts = {
            title = " Error",
            merge = false,
            replace = false,
          },
        },

        -- Warnings with attention
        {
          view = "notify",
          filter = { warning = true },
          opts = {
            title = " Warning",
            merge = false,
            replace = false,
          },
        },

        -- Git messages (stay minimal)
        {
          view = "mini",
          filter = {
            any = {
              { find = "^Git" },
              { find = "^fatal:" },
              { find = "^error:" },
            },
          },
          opts = { title = " Git" },
        },

        -- Python/Linting output
        {
          view = "mini",
          filter = {
            any = {
              { find = "pylint" },
              { find = "flake8" },
              { find = "mypy" },
            },
          },
          opts = { title = " Python" },
        },

        -- LSP messages
        {
          view = "notify",
          filter = { event = "lsp", kind = "message" },
          opts = {
            title = "󰚢 LSP",
            merge = true,
          },
        },

        -- Suppress mode messages
        {
          filter = { event = { "msg_showmode", "msg_showcmd", "msg_ruler" } },
          opts = { skip = true },
        },

        -- Command output to notifications
        {
          view = "notify",
          filter = { event = "msg_show", kind = { "echomsg", "echo", "lua_print" } },
          opts = {
            title = " Output",
            merge = true,
            replace = false,
          },
        },
      },

      -- ====================================
      -- MESSAGE HANDLING
      -- ====================================
      messages = {
        enabled = false,  -- Snacks handles this better
      },

      -- ====================================
      -- POPUPMENU (COMPLETION)
      -- ====================================
      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = true,
      },

      -- ====================================
      -- NOTIFICATIONS
      -- ====================================
      notify = {
        enabled = true,  -- Use nvim-notify or snacks
      },

      -- ====================================
      -- 🔗 LSP CONFIGURATION
      -- ====================================
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },
        message = {
          enabled = true,
          view = "notify",
          opts = {},
        },
        documentation = {
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },

      -- ====================================
      -- CUSTOM COMMANDS
      -- ====================================
      commands = {
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
        },
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        errors = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
        warnings = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = { warning = true },
          filter_opts = { reverse = true },
        },
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },

      -- ====================================
      -- MARKDOWN & FORMATTING
      -- ====================================
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help,
          ["%[.-%]%((%S-)%)"] = function(uri) require("noice.util").open(uri) end
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters: )"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(Returns:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["^%s*(Example:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },

      -- ====================================
      -- ⚙GENERAL OPTIONS
      -- ====================================
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      health = {
        checker = true,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = true,
      },
      throttle = 1000 / 30,
      status = {},
      format = {},
    },
  },

  -- ====================================
  -- 📢 NVIM-NOTIFY INTEGRATION
  -- ====================================
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      background_colour = "#000000",
      fps = 30,
      level = vim.log.levels.INFO,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = true,
    },
  },
}
