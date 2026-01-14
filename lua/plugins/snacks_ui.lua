-- This file configures the visual components: Dashboard and Styles.

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- 1. Styles (To customize the look and feel)
      styles = {
        enabled = true,
        dashboard = {
          zindex = 10,
          height = 0,
          width = 0,
          bo = {
            bufhidden = "wipe",
            buftype = "nofile",
            buflisted = false,
            filetype = "snacks_dashboard",
            swapfile = false,
            undofile = false,
          },
          wo = {
            colorcolumn = "",
            cursorcolumn = false,
            cursorline = false,
            foldmethod = "manual",
            list = false,
            number = false,
            relativenumber = false,
            sidescrolloff = 0,
            signcolumn = "no",
            spell = false,
            statuscolumn = "",
            statusline = "",
            winbar = "",
            winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
            wrap = false,
          },
        },
        float = {
          position = "float",
          backdrop = 60,
          height = 0.9,
          width = 0.9,
          zindex = 50,
        },
        help = {
          position = "float",
          backdrop = false,
          border = "top",
          row = -1,
          width = 0,
          height = 0.3,
        },
        input = {
          backdrop = false,
          position = "float",
          border = true,
          title_pos = "center",
          height = 1,
          width = 60,
          relative = "editor",
          noautocmd = true,
          row = 2,
          -- relative = "cursor",
          -- row = -3,
          -- col = 0,
          wo = {
            winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
            cursorline = false,
          },
          bo = {
            filetype = "snacks_input",
            buftype = "prompt",
          },
          --- buffer local variables
          b = {
            completion = false, -- disable blink completions in input
          },
          keys = {
            n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
            i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
            i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
            i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
            i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
            i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
            q = "cancel",
          },
        },
        image = {
          relative = "cursor",
          border = true,
          focusable = false,
          backdrop = false,
          row = 1,
          col = 1,
          -- width/height are automatically set by the image size unless specified below
        },
        terminal = {
          bo = {
            filetype = "snacks_terminal",
          },
          wo = {},
          stack = true, -- when enabled, multiple split windows with the same position will be stacked together (useful for terminals)
          keys = {
            q = "hide",
            gf = function(self)
              local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
              if f == "" then
                Snacks.notify.warn("No file under cursor")
              else
                self:hide()
                vim.schedule(function()
                  vim.cmd("e " .. f)
                end)
              end
            end,
            term_normal = {
              "<esc>",
              function(self)
                self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                if self.esc_timer:is_active() then
                  self.esc_timer:stop()
                  vim.cmd("stopinsert")
                else
                  self.esc_timer:start(200, 0, function() end)
                  return "<esc>"
                end
              end,
              mode = "t",
              expr = true,
              desc = "Double escape to normal mode",
            },
          },
        },
      },

      -- 2. Dashboard (Styled with ASCII art)
      dashboard = {
        ---@class snacks.dashboard.Config
        ---@field enabled? boolean
        ---@field sections snacks.dashboard.Section
        ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
        width = 60,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
          header = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        -- item field formatters
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return Snacks.dashboard.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
  },
}
