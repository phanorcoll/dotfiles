-- https://github.com/folke/trouble.nvim
return{
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    {"<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list"},
    {"<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open workspace trouble"},
    {"<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open document trouble list"},
    {"<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list"},
    {"<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list"},
    {"<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open TODOs in trouble"},
  },
}
