# LazyVim Configuration: The Modern Neovim Experience

This repository contains my personal Neovim configuration, built from the ground up to provide a fast, efficient, and user-friendly development environment. It's designed to be a significant upgrade for those transitioning from older plugin managers like **Packer** or for anyone looking to **optimize** their workflow.

## Why This Configuration? 🚀

A Modern Plugin Management System

This setup leverages Lazy.nvim, a next-generation plugin manager that's designed for speed and modularity. Unlike older systems, it loads plugins only when they are needed, drastically reducing Neovim's startup time. This means you get a powerful editor without the performance overhead.

## Key Features for an Enhanced Workflow:

-    ⚡️ Blazing Fast: With Lazy.nvim at its core, this configuration ensures minimal startup delays. You get a fully functional editor almost instantly.

-    🎨 Advanced Syntax Highlighting: Powered by nvim-treesitter, this config provides precise and semantic syntax highlighting, indenting, and text objects for a wide range of languages including Python, JavaScript, and HTML. This goes beyond simple regex-based highlighting for a more accurate and visually appealing experience.

-    🔍 Intuitive Navigation: Telescope.nvim is integrated for a powerful fuzzy-finding experience. Easily search for files, project-wide text, or even Neovim's help documents with simple keybindings.

-    💡 Intelligent Autocompletion: The combination of nvim-cmp and mason-lspconfig provides a robust autocompletion and Language Server Protocol (LSP) setup. This gives you features like code actions, refactoring, and accurate type definitions right out of the box, with minimal setup for each language.

-    ✨ Seamless Integration: Includes plugins for essential development tasks, such as nvim-tree for file system navigation, nvim-autopairs for automatic bracket and quote completion, and vim-fugitive for powerful Git integration directly in your editor.

-    🔄 Automated Formatting & Linting: Using conform.nvim and nvim-lint, your code is automatically formatted and checked for errors on save, ensuring a clean and consistent codebase with zero manual effort.

## Getting Started 💻:

### Prerequisites

-    Neovim v0.9.0 or later

-    Git

-    A C compiler for some plugins.

### Installation Steps:

1. Backup Your Current Configuration: It's highly recommended to back up your existing Neovim configuration directory first.

```shell
mv ~/.config/nvim ~/.config/nvim.bak
```
2. Clone the Repository: Clone this configuration into your Neovim directory.

```shell
git clone https://github.com/syed-913/Neo-Vim-Config.git ~/.config/nvim
```

3. Launch Neovim: Open Neovim for the first time. Lazy.nvim will automatically install and set up all the specified plugins. This process may take a few minutes as it downloads and compiles everything.

```shell
nvim
```
4. Install Language Servers: After the initial setup, you can install additional language servers via Mason. Simply run the `:Mason` command and select the language servers you need for your projects.

## Keybindings ⌨️:

This configuration provides a curated set of keybindings to streamline your workflow.

### General:
```shell
Keybinding	Description
<leader>e	Toggle Nvim-Tree (file explorer)
<leader>g	Search for a pattern across all files with Telescope
<leader>b	List all open buffers
<leader>h	Search Neovim help tags
<leader>s	Open the file browser with Telescope
<leader>t	Open a new terminal in a horizontal split
<leader>v	Open a new terminal in a vertical split
<leader>tt	Toggle a floating terminal
```

### LSP (Language Server Protocol):
```shell
Keybinding	Description
gD	Go to declaration
gd	Go to definition
gr	Find references
K	Display hover documentation for the symbol under the cursor
<leader>ca	Open code actions menu
<leader>rn	Rename the symbol under the cursor
<leader>D	Go to type definition
```
### Autocompletion:
```shell
Keybinding	Description
<C-b>	Scroll documentation up
<C-f>	Scroll documentation down
<C-Space>	Trigger completion
<CR>	Confirm the selected completion item
<Tab>	Select next completion item or expand a snippet
<S-Tab>	Select previous completion item or jump back in a snippet
```
Terminal
```shell
Keybinding	Description
<Esc>	Exit terminal mode
```

I'll update this config gradually, if you csutomize it then please share with me so that I can make config more productive
