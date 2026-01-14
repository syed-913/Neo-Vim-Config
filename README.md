# Neovim Configuration

A modular, high-performance Neovim configuration built as a hobby project for daily development and text editing.  This setup prioritizes productivity, customizability, and keymap-driven workflows. 

<div align="center">

![Static Badge](https://img.shields.io/badge/v0.11.0-neovim?style=plastic&logo=neovim&label=Neovim&color=%234e9940&link=https%3A%2F%2Fneovim.io%2F)
![Static Badge](https://img.shields.io/badge/5.1%2B-Lua?style=plastic&logo=lua&logoColor=%23800080&label=Lua&color=%23800080&link=https%3A%2F%2Fwww.lua.org%2F)
![Static Badge](https://img.shields.io/badge/Latest-LazyVim?style=plastic&logo=lazyvim&logoColor=%232e7de9&logoSize=auto&label=LazyVim&color=%232e7de9&link=https%3A%2F%2Fgithub.com%2Ffolke%2Flazy.nvim)
![Static Badge](https://img.shields.io/badge/Active-Status?style=plastic&logoColor=%232b9500&logoSize=auto&label=Status&color=%232b9500&link=https%3A%2F%2Fgithub.com%2Fsyed-913%2FNeo-Vim-Config)

</div>

## About

This is a personal Neovim configuration built for daily development work. Previously used [Packer](https://github.com/wbthomason/packer.nvim) as a plugin manager, now optimized with **[Lazy.nvim](https://github.com/folke/lazy.nvim)** for better performance and lazy-loading capabilities.

> [!NOTE]
> 
> This is a feature-rich configuration. It may require **more resources on older machines**. Configuration is actively maintained and updated based on personal development needs.

---

## Advantages

### Performance & Workflow
- Fast startup time with lazy-loaded plugins
- Modular structure for easy customization
- Comprehensive keymap bindings for complete editor control
- Smooth, responsive UI with enhanced visuals

### Development Features
- Full LSP support with multiple language servers
- Smart autocompletion with snippet engine
- Integrated terminal with multiple layout options
- Git integration with branch/log/diff visualization
- Diagnostic viewer with error/warning management
- Fast file and buffer navigation

### User Experience
- Custom command-line with syntax highlighting
- Smart notification and message routing
- Beautiful diagnostic displays
- Intuitive symbol and reference navigation
- Code formatting and refactoring tools

---

## Prerequisites

### Required
- **Neovim** v0.10.0 or higher
  - [Installation Guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **Git** - For plugin management
- **npm** - For language server installation
- **Nerd Font** - For icons (e.g., FiraCode Nerd Font)

### Optional but Recommended
- **ripgrep** - Fast file searching
  ```bash
  brew install ripgrep        # macOS
  sudo apt-get install ripgrep # Ubuntu/Debian
  sudo dnf install ripgrep     # Fedora
  ```

- **Delta** - Beautiful git diff viewer
  ```bash
  brew install git-delta      # macOS
  sudo apt-get install git-delta # Ubuntu/Debian
  ```

### Language-specific Tools
- **Python** - `pip install black flake8 mypy pylint`
- **Rust** - `cargo install rust-analyzer`
- **Node.js** - Included TypeScript/JavaScript support

---

## Installation

### 1. Backup Existing Configuration
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### 2. Clone Repository
```bash
git clone https://github.com/syed-913/Neo-Vim-Config ~/.config/nvim
```

### 3. Install Language Servers
Open Neovim and run:
```vim
:Mason
```

Install recommended servers:
- pyright (Python)
- lua_ls (Lua)
- bashls (Bash)
- html (HTML)
- cssls (CSS)
- ts_ls (TypeScript/JavaScript)

Or auto-install with `:MasonInstallAll`

### 4. Verify Installation
```vim
:checkhealth nvim.lsp
:checkhealth snacks
:checkhealth noice
```

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                # Main entry point, gloabl keymap maintainer and configuration loader
└── lua
    └── plugins
        ├── completion.lua  # Autocompletion and snippet engine settings
        ├── core.lua        # Essential Neovim options and core plugin setup
        ├── formatting.lua  # Code formatting and linting configuration
        ├── misc.lua        # Small, standalone utility plugins
        ├── noice.lua       # Highly customized UI for messages, cmdline, and popupmenu
        ├── snacks.lua      # Main configuration for the Snacks.nvim utility suite
        ├── snacks_picker.lua # Fuzzy finder and picker settings for Snacks
        ├── snacks_ui.lua   # UI-specific enhancements powered by Snacks
        ├── snacks_utils.lua # Custom helper functions and utilities for Snacks
        ├── trouble.lua     # Diagnostics, LSP references, and quickfix management
        └── visuals.lua     # Aesthetic plugins (statusline, bufferline, themes)t
```

---

## List of Plugins

### Plugin Manager
| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Fast plugin manager with lazy-loading |

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| nvim-lspconfig | LSP client configuration |
| mason.nvim | LSP/formatter/linter installer |
| mason-lspconfig.nvim | Mason and lspconfig integration |
| nvim-cmp | Autocompletion engine |
| cmp-nvim-lsp | LSP source for nvim-cmp |
| cmp-buffer | Buffer words completion |
| cmp-path | Path completion |
| cmp-cmdline | Command-line completion |
| LuaSnip | Snippet engine |
| cmp_luasnip | Snippet source for nvim-cmp |

### UI & Visual Enhancements
| Plugin | Purpose |
|--------|---------|
| noice.nvim | Beautiful UI for command-line, messages, popupmenu |
| trouble.nvim | Diagnostics and references viewer |
| snacks.nvim | Utilities including picker, terminal, explorer |
| nvim-notify | Notification system |
| nvim-web-devicons | File icons |

### File & Buffer Management
| Plugin | Purpose |
|--------|---------|
| snacks.nvim picker | Fast file search and navigation |
| snacks.nvim explorer | File tree explorer |
| snacks.nvim terminal | Integrated terminal with multiple layouts |

### Optional Enhancements
| Plugin | Purpose |
|--------|---------|
| nvim-treesitter | Syntax highlighting and tree-sitter integration |
| vim-sneak | Fast motion with 2-character search |

---

## Keymap Overview

### Navigation & LSP
```
gd      - Go to definition
gD      - Go to declaration
K       - Hover documentation
gr      - Find references
gi      - Go to implementation
gy      - Go to type definition
<C-k>   - Signature help
```

### File & Buffer Management
```
<leader>ff   - Find files
<leader>fg   - Find git files
<leader>fr   - Find recent files
<leader>,    - Open buffer picker
<leader>bn   - Next buffer
<leader>bp   - Previous buffer
<leader>bd   - Delete buffer
```

### Search & Grep
```
<leader>/    - Grep search
<leader>sg   - Grep in project
<leader>sw   - Grep word under cursor
<leader>sk   - Search keymaps
<leader>sC   - Search commands
```

### Terminal
```
<C-t>        - Toggle terminal (bottom)
<leader>tf   - Floating terminal
<leader>ts   - Split terminal
<leader>tv   - Vertical split terminal
<Esc>        - Exit terminal mode
```

### Diagnostics & Trouble
```
<leader>xx   - Toggle all diagnostics
<leader>xX   - Toggle buffer diagnostics
<leader>xL   - Toggle location list
<leader>xQ   - Toggle quickfix list
<leader>cs   - Toggle symbols
]d           - Next diagnostic
[d           - Previous diagnostic
```

### Code Actions
```
<leader>rn   - Rename symbol
<leader>ca   - Code actions
<leader>fm   - Format code
```

### Noice & Messages
```
<leader>nh   - Noice history
<leader>nl   - Last message
<leader>ne   - Show errors
<leader>nw   - Show warnings
<leader>nd   - Dismiss notifications
```

### Git Integration
```
<leader>gb   - Git branches
<leader>gl   - Git log
<leader>gs   - Git status
<leader>gd   - Git diff
```

---

## Quick Start Guide

### Opening Files
1. Press `<leader>ff` to open file finder
2. Type to search for files
3. Press `<Enter>` to open or `<C-v>` for vertical split

### Using LSP Features
1. Hover over a symbol and press `K` for documentation
2. Press `gd` to jump to definition
3. Press `gr` to find all references
4. Press `<leader>ca` for code actions

### Terminal Usage
1. Press `<C-t>` to open terminal at bottom
2. Run commands as normal
3. Press `q` to hide (terminal keeps running)
4. Press `<C-t>` again to show

### Searching Project
1. Press `<leader>/` for grep search
2. Type search pattern
3. Navigate results with arrow keys
4. Press `<Enter>` to jump to match

### Managing Diagnostics
1. Press `<leader>xx` to open diagnostics
2. Press `gb` to filter current buffer only
3. Press `s` to toggle by severity level
4. Press `<Enter>` to jump to error location

---

## Customization

### Adding New Language Server
Edit `lua/plugins/lsp.lua` and add to `ensure_installed`:
```lua
ensure_installed = {
  "pyright",
  "rust_analyzer",  -- Add new server
},
```

Then run `:Mason` to install.

### Creating Custom Keymaps
Add to `init.lua`:
```lua
vim.keymap.set("n", "<leader>custom", function()
  -- Your custom function
end, { desc = "Custom action" })
```

### Changing Theme
Edit `visuals.lua`:
```lua
vim.cmd.colorscheme("tokyonight-night")
```

Popular themes:  catppuccin, gruvbox, nord, dracula, onedark

### Extending Configuration
Create new plugin file in `lua/plugins/` and Lazy.nvim will auto-load it: 
```lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    opts = { },
  },
}
```

---

## Troubleshooting

### LSP Not Attaching
```vim
:LspInfo
: checkhealth nvim.lsp
```
Solution: Run `:Mason` and install language servers.

### Completions Not Showing
Press `<C-Space>` in insert mode. Verify LSP is attached with `:LspInfo`.

### Slow Startup
Run `:Snacks profile` to identify slow plugins. Consider lazy-loading heavy plugins.

### Icons Not Displaying
Install a Nerd Font and set it in your terminal. Restart Neovim.

### Keymaps Not Working
Check if registered:  `:map <your-keymap>`
Verify the configuration file is loaded properly.

---

## Performance Notes

This is a comprehensive configuration with many features. On older machines, you may experience: 
- Longer startup time (typically 100-300ms)
- Memory usage increase with all plugins loaded
- Slight lag with large files or heavy operations

To optimize:
1. Disable unused plugins in `lua/plugins/`
2. Use `:Snacks profile` to find bottlenecks
3. Enable selective language servers

---

## Tips & Tricks

### Quick Command Search
Press `<leader>sC` to search and execute any command. 

### Keymap Discovery
Press `<leader>sk` to search keymaps by name and execute them.

### Project-wide Grep
Press `<leader>/` and start typing to search entire project instantly.

### Terminal Multitasking
Keep terminal running in background with `q`, work in editor, then toggle back with `<C-t>`.

### LSP References in Trouble
Press `gr` then `<leader>cl` to view all references in a nice organized list.

---

## Credits

Built with inspiration from the Neovim community and these excellent plugins:
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- [folke/trouble.nvim](https://github.com/folke/trouble.nvim)
- [folke/noice.nvim](https://github.com/folke/noice.nvim)
- [folke/snacks.nvim](https://github.com/folke/snacks.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

## Stay Updated

This configuration is actively maintained and updated.  Watch the repository for new features and improvements. 

Made with dedication by [@syed-913](https://github.com/syed-913)
