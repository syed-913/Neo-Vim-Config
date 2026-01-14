return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        keymap = {
          accept = "<C-j>",
          accept_word = "<C-Right>",
        },
      },
      panel = { enabled = false },
    },
  },

  -- Auto-save
  {
    "okuuva/auto-save.nvim",
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
        defer_save = { "InsertLeave", "TextChanged" },
      },
      callback = function()
        vim.notify("File saved automatically!", vim.log.levels.INFO)
      end,
    },
  },
}
