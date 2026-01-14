-- This file handles the "background" features of Snacks.nvim.
-- These are features that usually don't need complex keybindings or UI interaction.

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- 1. Bigfile: Detects large files and disables slow features
      bigfile = {
        enabled = true,
        notify = true,
        size = 5 * 1024 * 1024, -- 5Mb
        line_length = 5000,

      },

      -- 2. Scroll: Smooth scrolling experience
      scroll = {
        enabled = true,
        duration = { step = 10, total = 200 },
        easing = function(n) return n < 0.5 and 2 * n * n or -1 + (4 - 2 * n) * n end,
        animate_repeat = {
          delay = 100, -- delay in ms before using the repeat animation
          duration = { step = 5, total = 50 },
          easing = function(n) return n < 0.5 and 2 * n * n or -1 + (4 - 2 * n) * n end,
        },
      },

      -- 3. Animate: Smooth window animations/transitions
      animate = {
        enabled = true,
        easing = function(n) return n < 0.5 and 2 * n * n or -1 + (4 - 2 * n) * n end,
        fps = 60,
        duration = 300,
      },

      -- 4. Indent: Visual indent guides (Replaces indent-blankline)
      indent = { 
        priority = 1,
        enabled = true,
        char = "◦",
        only_scopes = false,
        only_current = false,
        hl = "SnacksIndent",
        animate = {
          enabled = false,
          easing = function(n) return n < 0.5 and 2 * n * n or -1 + (4 - 2 * n) * n end,
          duration = { step = 20, total = 500 },
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "•",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope",
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = true,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },

      -- 5. Dim: Highlights the current code block and dims others
      dim = {
        enabled = true,
        alpha = 0.50,
        exclude = { "Comment", "NormalFloat", "TelescopePrompt" },
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          easing = function(n) return n < 0.5 and 2 * n * n or -1 + (4 - 2 * n) * n end,
          duration = { step = 20, total = 300 },
        },
      },

      -- 6. Words: Highlights the word under cursor (LSP integration)
      words = { enabled = true },

      -- 7. Scope: Shows the current scope in the statusline or top
      scope = {
        enabled = true,
        -- absolute minimum size of the scope.
        -- can be less if the scope is a top-level single line scope
        min_size = 2,
        -- try to expand the scope to this size
        max_size = nil,
        cursor = true, -- when true, the column of the cursor is used to determine the scope
        edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
        siblings = false, -- expand single line scopes with single line siblings
        -- what buffers to attach to
        filter = function(buf)
          return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
        end,
        -- debounce scope detection in ms
        debounce = 30,
        treesitter = {
          -- detect scope based on treesitter.
          -- falls back to indent based detection if not available
          enabled = true,
          injections = true, -- include language injections when detecting scope (useful for languages like `vue`)
          ---@type string[]|{enabled?:boolean}
          blocks = {
            enabled = false, -- enable to use the following blocks
            "function_declaration",
            "function_definition",
            "method_declaration",
            "method_definition",
            "class_declaration",
            "class_definition",
            "do_statement",
            "while_statement",
            "repeat_statement",
            "if_statement",
            "for_statement",
          },
          -- these treesitter fields will be considered as blocks
          field_blocks = {
            "local_declaration",
          },
        },
        -- These keymaps will only be set if the `scope` plugin is enabled.
        -- Alternatively, you can set them manually in your config,
        -- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
        keys = {
          ---@type table<string, snacks.scope.TextObject|{desc?:string}|false>
          textobject = {
            ii = {
              min_size = 2, -- minimum size of the scope
              edge = false, -- inner scope
              cursor = false,
              treesitter = { blocks = { enabled = false } },
              desc = "inner scope",
            },
            ai = {
              cursor = false,
              min_size = 2, -- minimum size of the scope
              treesitter = { blocks = { enabled = false } },
              desc = "full scope",
            },
          },
          ---@type table<string, snacks.scope.Jump|{desc?:string}|false>
          jump = {
            ["[i"] = {
              min_size = 1, -- allow single line scopes
              bottom = false,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = "jump to top edge of scope",
            },
            ["]i"] = {
              min_size = 1, -- allow single line scopes
              bottom = true,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = "jump to bottom edge of scope",
            },
          },
        },
      },

      -- 8. Styles: Core styling engine for other snacks
      styles = {
        notification = {
          border = "rounded",
        }
      },
      
      -- 9. Quickfile: Super fast file opening
      quickfile = { enabled = true },
      image = {
        enabled = true,
        formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
          "icns",
        },
        force = false,
        doc = {
          enabled = true,
          inline = true,
          float = true,
          max_width = 80,
          max_height = 40,
        },
        wo = {
          wrap = false,
          number = false,
          relativenumber = false,
          cursorcolumn = false,
          signcolumn = "no",
          foldcolumn = "0",
          list = false,
          spell = false,
          statuscolumn = "",
        },
        cache = vim.fn.stdpath("cache") .. "/snacks/image",
        debug = {
          request = false,
          convert = false,
          placement = false,
        },
        env = {},
        -- icons used to show where an inline image is located that is
        -- rendered below the text.
        icons = {
          math = "󰪚 ",
          chart = "󰄧 ",
          image = " ",
        },
      },
    },
  },
}
