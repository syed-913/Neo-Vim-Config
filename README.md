# LazyVim Configuration: The Modern Neovim Experience

This repository contains my personal Neovim configuration, built from the ground up to provide a fast, efficient, and user-friendly development environment. It's designed to be a significant upgrade for those transitioning from older plugin managers like Packer or for anyone looking to optimize their workflow.

---

### Why This Configuration? 🚀

#### A Modern Plugin Management System
This setup leverages **Lazy.nvim**, a next-generation plugin manager that's designed for speed and modularity. Unlike older systems, it loads plugins only when they are needed, drastically reducing Neovim's startup time. This means you get a powerful editor without the performance overhead.

#### Key Features for an Enhanced Workflow:
* ⚡️ **Blazing Fast**: With Lazy.nvim at its core, this configuration ensures minimal startup delays. You get a fully functional editor almost instantly.
* 🎨 **Advanced Syntax Highlighting**: Powered by `nvim-treesitter`, this config provides precise and semantic syntax highlighting, indenting, and text objects for a wide range of languages including Python, JavaScript, and HTML. This goes beyond simple regex-based highlighting for a more accurate and visually appealing experience.
* 🔍 **Intuitive Navigation**: `Telescope.nvim` is integrated for a powerful fuzzy-finding experience. Easily search for files, project-wide text, or even Neovim's help documents with simple keybindings.
* 💡 **Intelligent Autocompletion**: The combination of `nvim-cmp`, `mason-lspconfig`, and GitHub Copilot provides a robust autocompletion and Language Server Protocol (LSP) setup. This gives you features like code actions, refactoring, and accurate type definitions right out of the box, with minimal setup for each language.
* ✨ **Seamless Integration**: Includes plugins for essential development tasks, such as `nvim-tree` for file system navigation, `nvim-autopairs` for automatic bracket and quote completion, and `vim-fugitive` for powerful Git integration directly in your editor.
* 🔄 **Automated Formatting & Linting**: Using `conform.nvim` and `nvim-lint`, your code is automatically formatted and checked for errors on save, ensuring a clean and consistent codebase with zero manual effort.

---

### Getting Started 💻

#### Prerequisites
* Neovim v0.9.0 or later
* Git
* A C compiler for some plugins.
* Latest `nodejs` [package](https://nodejs.org/en/download/).

#### Installation Steps:
1.  **Backup Your Current Configuration**: It's highly recommended to back up your existing Neovim configuration directory first.
    ```sh
    mv ~/.config/nvim ~/.config/nvim.bak
    ```
2.  **Clone the Repository**: Clone this configuration into your Neovim directory.
    ```sh
    git clone [https://github.com/syed-913/Neo-Vim-Config.git](https://github.com/syed-913/Neo-Vim-Config.git) ~/.config/nvim
    ```
3.  **Launch Neovim**: Open Neovim for the first time. `Lazy.nvim` will automatically install and set up all the specified plugins. This process may take a few minutes as it downloads and compiles everything.
    ```sh
    nvim
    ```
4.  **Install Language Servers**: After the initial setup, you can install additional language servers via Mason. Simply run the `:Mason` command and select the language servers you need for your projects.

---

### Keybindings ⌨️

This configuration provides a curated set of keybindings to streamline your workflow.

#### General:
| Keybinding | Description |
|---|---|
| `<leader>e` | Toggle Nvim-Tree (file explorer) |
| `<leader>g` | Search for a pattern across all files with Telescope |
| `<leader>b` | List all open buffers |
| `<leader>h` | Search Neovim help tags |
| `<leader>s` | Open the file browser with Telescope |
| `<leader>t` | Open a new terminal in a horizontal split |
| `<leader>v` | Open a new terminal in a vertical split |
| `<leader>tt` | Toggle a floating terminal |

#### LSP (Language Server Protocol):
| Keybinding | Description |
|---|---|
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Display hover documentation for the symbol under the cursor |
| `<leader>ca` | Open code actions menu |
| `<leader>rn` | Rename the symbol under the cursor |
| `<leader>D` | Go to type definition |

#### Autocompletion:
| Keybinding | Description |
|---|---|
| `<C-b>` | Scroll documentation up |
| `<C-f>` | Scroll documentation down |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm the selected completion item |
| `<Tab>` | Select next completion item or expand a snippet |
| `<S-Tab>` | Select previous completion item or jump back in a snippet |

#### Terminal
| Keybinding | Description |
|---|---|
| `<Esc>` | Exit terminal mode |

---

### GitHub Copilot Integration 🤖

This configuration includes optional support for **GitHub Copilot**, an AI pair programmer that provides intelligent code suggestions. The plugin is already included in this configuration, so you only need to perform a simple setup step.

#### Getting Started

To get started with GitHub Copilot, follow these steps:

1.  **Set Up Copilot**: After your Neovim configuration is installed, open Neovim and run the following command in Normal mode:
    ```
    :Copilot setup
    ```
    This command will provide you with a device code and open a browser window for you to sign in to your GitHub account.

2.  **Authentication**: Once you have authenticated in your browser, Copilot will be active and ready to provide code suggestions directly in your editor.

---

I hope to continue updating this configuration as I learn and discover new ways to make my development workflow more productive.
````
