# NeoVim Configuration for Modern Development

Welcome to my NeoVim configuration! This setup is designed to provide a sleek, efficient, and highly customizable development environment tailored for modern web and software development. Whether you're working on Python, JavaScript, HTML, CSS, or Lua, this configuration has you covered with powerful plugins, beautiful themes, and intuitive keybindings.

## Features

- **Beautiful UI**: The `catppuccin` theme provides a modern and visually appealing interface with transparent backgrounds and customizable options.
- **Enhanced Syntax Highlighting**: Powered by `nvim-treesitter`, this setup offers advanced syntax highlighting for multiple languages.
- **Autocompletion**: Integrated with `nvim-cmp` and `LuaSnip`, you get intelligent code completion and snippet support.
- **File Explorer**: `nvim-tree` offers a sleek file explorer with Git integration.
- **Fuzzy Finder**: `Telescope` provides a powerful and fast file search, making navigation a breeze.
- **Git Integration**: `vim-fugitive` brings seamless Git operations directly within NeoVim.
- **Formatting & Linting**: `ALE` and `vim-prettier` ensure your code is always clean and consistent.
- **Custom Keybindings**: Optimized keybindings for terminal, file navigation, and more, making your workflow faster and more efficient.

## Installation

### Dependencies

Before setting up the NeoVim configuration, ensure you have the following dependencies installed:

1. **NeoVim**: Make sure you have NeoVim installed. You can install it via your package manager:
   - **Ubuntu/Debian**:
     ```bash
     sudo apt install neovim
     ```
   - **macOS** (using Homebrew):
     ```bash
     brew install neovim
     ```
   - **Windows** (using Chocolatey):
     ```bash
     choco install neovim
     ```

2. **Git**: Git is required for managing plugins.
   - **Ubuntu/Debian**:
     ```bash
     sudo apt install git
     ```
   - **macOS** (using Homebrew):
     ```bash
     brew install git
     ```
   - **Windows** (using Chocolatey):
     ```bash
     choco install git
     ```

3. **Language Servers**: Install the necessary language servers for autocompletion and linting:
   - **Python** (Pyright):
     ```bash
     npm install -g pyright
     ```
   - **Bash** (bash-language-server):
     ```bash
     npm install -g bash-language-server
     ```
   - **HTML** (vscode-html-languageserver):
     ```bash
     npm install -g vscode-html-languageserver-bin
     ```
   - **CSS** (vscode-css-languageserver):
     ```bash
     npm install -g vscode-css-languageserver-bin
     ```

4. **Node.js**: Some language servers require Node.js. Install it if you don't have it:
   - **Ubuntu/Debian**:
     ```bash
     sudo apt install nodejs npm
     ```
   - **macOS** (using Homebrew):
     ```bash
     brew install node
     ```
   - **Windows** (using Chocolatey):
     ```bash
     choco install nodejs
     ```

5. **Python**: Ensure Python is installed for some plugins and tools:
   - **Ubuntu/Debian**:
     ```bash
     sudo apt install python3 python3-pip
     ```
   - **macOS** (using Homebrew):
     ```bash
     brew install python
     ```
   - **Windows** (using Chocolatey):
     ```bash
     choco install python
     ```

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git ~/.config/nvim
   ```

2. **Install Packer.nvim** (if not already installed):
   ```bash
   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```

3. **Install Plugins**:
   Open NeoVim and run:
   ```vim
   :PackerSync
   ```

4. **Enjoy!** Your NeoVim is now configured with all the plugins and settings.

## FAQ

### How do I customize the theme?
You can modify the `catppuccin` theme settings in the `init.lua` file. The configuration allows you to change the flavor, transparency, and more.

### How do I add more languages for Treesitter?
You can add more languages by updating the `ensure_installed` list in the `nvim-treesitter` setup section in `init.lua`.

### How do I change the keybindings?
Keybindings are defined in the `init.lua` file. You can modify or add new keybindings by editing the `vim.api.nvim_set_keymap` lines.

### How do I update the plugins?
Run `:PackerSync` in NeoVim to update all plugins to their latest versions.

### Can I use this configuration on Windows?
Yes, this configuration works on Windows, Linux, and macOS. Just ensure you have NeoVim and Git installed.

## Contributing

Feel free to fork this repository and submit pull requests with your improvements. If you find any issues, please open an issue on GitHub.

---

Happy coding! 🚀
