[gopher time](https://github.com/phanorcoll/dotfiles/assets/195602/22e1be57-7c04-4be2-a710-ad2fc14c7180)
# Configuration files


## Install
Clone the repo in any location and inside the root of the dotfiles folder run:

`stow --target ~/ .`

**note:** Make sure you dont have the same file structure as the dotfiles folder, if you do, backup everything.

Remember, <u>**never delete**</u> something unless you're 100% sure you'll never need it again.

**Stow** will create a symlink for each folder and file in your **$HOME**.

## Set the Global Configuration for Git
Set the global Git configuration to use your template file.

`git config --global commit.template ~/.git_commit_template.txt `

## Setup enviroment variables.
create a file called `.zshenv` in `$HOME` to export all variables needed.
ex:
```bash
export OPENAI_API_KEY=key
export ANOTHER=key
```

---

## Neovim plugin List


[windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)

- **Description:** autopairs for neovim

---


[cmp.saghen.dev/](https://cmp.saghen.dev/)

- **Description:** blink.cmp is a completion plugin with support for LSPs and external sources that updates on every keystroke with minimal overhead.

---


[akinsho/bufferline.nvim](https://githob.com/akinsho/bufferline.nvim)

- **Description:** Bufferline is a snazzy buffer line for Neovim

---


[stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)

- **Description:** Lightweight yet powerful formatter plugin for Neovim.

---


[zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)

- **Description:** A Lua wrapper for Copilot, the AI pair programmer.

---


[CopilotC-Nvim/CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)

- **Description:** CopilotChat.nvim is a Neovim plugin that brings GitHub Copilot Chat capabilities directly into your editor

---


[kristijanhusak/vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)

- **Description:** A UI for vim-dadbod, a database client for Vim and Neovim. It provides a simple interface to interact with databases, run queries, and view results.

---


[ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)

- **Description:** Wrapper around fzf for neovim. Replaces Telescope for searching

---


[lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)

- **Description:** Git signs written in pure lua

---


[ray-x/go.nvim](https://github.com/ray-x/go.nvim)

- **Description:** Go development plugin for neovim

---


[mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)

- **Description:** An asynchronous linter plugin for Neovim (&gt;= 0.9.5) complementary to the built-in Language Server Protocol support.

---


[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

- **Description:** nvim-lspconfig is a &#34;data only&#34; repo, providing basic, default Nvim LSP client configurations for various LSP servers.

---


[readmes/mini-icons.md](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md)

- **Description:** Icon provider for the mini.nvim plugins

---


[NeogitOrg/neogit](https://github.com/NeogitOrg/neogit)

- **Description:** Neogit is a magit like git client for neovim

---


[EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)

- **Description:** A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.

---


[folke/noice.nvim](https://github.com/folke/noice.nvim)

- **Description:** A noice message system for Neovim

---


[stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)

- **Description:** File explorer like a text buffer

---


[MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

- **Description:** Plugin to improve viewing Markdown files in Neovim

---


[nvzone/showkeys](https://github.com/nvzone/showkeys)

- **Description:** Eye-candy keys screencaster for Neovim

---


[michaelrommel/nvim-silicon](https://github.com/michaelrommel/nvim-silicon)

- **Description:** nvim-silicon is a plugin for Neovim that allows you to generate images of your code using silicon.

---


[tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)

- **Description:** automatically adjusts &#39;shiftwidth&#39; and &#39;expandtab&#39; heuristically based on the current file.

---


[echasnovski/mini.statusline](https://github.com/echasnovski/mini.statusline)

- **Description:** Minimal, fast statusline plugin

---


[folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

- **Description:** A todo comment plugin for neovim written in lua

---


[nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

- **Description:** Syntax aware text-objects, select, move, swap, and peek support.

---


[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

- **Description:** Treesitter configurations

---


[folke/trouble.nvim](https://github.com/folke/trouble.nvim)

- **Description:** A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing..

---


[folke/which-key.nvim](https://github.com/folke/which-key.nvim)

- **Description:** WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

---


generated by [doc bot](https://github.com/phanorcoll/doc_bot)

