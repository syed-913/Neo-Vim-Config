-- ________________________________________
-- || Core Configuration using Lazy.nvim ||
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 1. Bootstrap Lazy.nvim
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

-- 2. Set up Lazy.nvim
-- This will automatically import everything from lua/plugins/*.lua
require("lazy").setup({
  { import = "plugins" }, 
}, {
  checker = { enabled = true }, -- Automatically check for plugin updates
})

-- ________________________________
-- || Core Settings and Mappings ||
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

-- Trigger Copilot manually in Insert
vim.keymap.set('n', '<leader>!', function()
require("copilot.suggestion").next()
end, { desc = "Manual Copilot Suggest" })

-- Buffer Navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next Buffer" })
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = "Previous Buffer" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete Buffer" })
vim.keymap.set('n', '<leader>ba', ':%bdelete<CR>', { desc = "Close All Buffers" })

-- NOICE KEYMAPS
vim.keymap.set("n", "<leader>nh", function() require("noice").cmd("history") end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>nl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>ne", function() require("noice").cmd("errors") end, { desc = "Noice Errors" })
vim.keymap.set("n", "<leader>nw", function() require("noice").cmd("warnings") end, { desc = "Noice Warnings" })
vim.keymap.set("n", "<leader>nd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All Messages" })
vim.keymap.set("n", "<leader>na", function() require("noice").cmd("all") end, { desc = "Noice All Messages" })

-- Scroll in LSP docs
vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<C-f>"
  end
end, { silent = true, expr = true, desc = "Scroll down in LSP docs" })

vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<C-b>"
  end
end, { silent = true, expr = true, desc = "Scroll up in LSP docs" })

-- ====================================
-- TERMINAL KEYMAPS
-- ====================================
vim.keymap.set("n", "<C-t>", function()
  Snacks.terminal(nil, { pos = "bottom", size = { height = 0.4 } })
end, { desc = "Toggle Terminal (Bottom)" })

vim.keymap.set("n", "<leader>tt", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<leader>tf", function()
  Snacks.terminal(nil, { pos = "float" })
end, { desc = "Floating Terminal" })

vim.keymap.set("n", "<leader>ts", function()
  Snacks.terminal(nil, { pos = "split" })
end, { desc = "Terminal Split" })

vim.keymap.set("n", "<leader>tv", function()
  Snacks.terminal(nil, { pos = "vsplit" })
end, { desc = "Terminal Vertical Split" })

-- Exit terminal and return to normal mode
vim.keymap.set("t", "<C-\\><C-n>", "<C-\\><C-n>", { desc = "Exit Terminal to Normal Mode" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal (Escape)" })
