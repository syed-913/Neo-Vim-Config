-- This file handles Terminal, Profiler, and Bufdelete. 

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- ====================================
      -- 1. TERMINAL
      -- ====================================
      terminal = {
        enabled = true,
        win = {
          style = "terminal",
          backdrop = 60,
          height = 0.4,
          width = 1.0,
          zindex = 50,
          border = "rounded",
          title = " Terminal ",
          title_pos = "center",
        },
        keys = {
          q = "hide",
          gf = function(self)
            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
            if f == "" then
              Snacks.notify.warn("No file under cursor")
            else
              self: hide()
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

      -- ====================================
      -- 2. PROFILER
      -- ====================================
      profiler = { enabled = true },

      -- ====================================
      -- 3. BUFDELETE
      -- ====================================
      bufdelete = { enabled = true },
    },
  },
}