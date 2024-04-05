-- https://github.com/nvim-tree/nvim-tree.lua
-- TODO: Improve configuration
-- TODO: Make bg transparent
-- :h nvim-tree
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPugin = 1
    require("nvim-tree").setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = " ",
              arrow_open = " "
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {},
      git = {
        ignore = true,
      },
    })

    -- keymapping
    local keymap = vim.keymap
    keymap.set("n","<leader>ee","<cmd>NvimTreeToggle<CR>",{ desc = "Toggle file explorer"})
    keymap.set("n","<leader>ef","<cmd>NvimTreeFindFileToggle<CR>",{ desc = "Open file explorer on current file"})
    keymap.set("n","<leader>ec","<cmd>NvimTreeCollapse<CR>",{ desc = "Collapse folders"})
    keymap.set("n","<leader>er","<cmd>NvimTreeRefresh<CR>",{ desc = "Refresh file explorer"})
  end,
}
