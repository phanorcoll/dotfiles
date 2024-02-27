-- https://github.com/sindrets/diffview.nvim
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", {
  desc = "Open [D]iff[V]iew"
})
vim.keymap.set("n", "<leader>dvc", "<cmd>DiffviewClose<CR>", {
  desc = "Close [D]iff[V]iew[C]lose"
})
vim.keymap.set("n", "<leader>dvr", "<cmd>DiffviewRefresh<CR>", {
  desc = "Close [D]iff[V]iew[R]efresh"
})
vim.keymap.set("n", "<leader>dvr", "<cmd>DiffviewFileHistort<CR>", {
  desc = "Close [D]iff[V]iew[F]ile History"
})
return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      hooks = {
        diff_buf_read = function(bufnr)
          -- Change local options in diff buffers
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
        view_opened = function(view)
          print(
            ("A new %s was opened on tab page %d!")
            :format(view.class:name(), view.tabpage)
          )
        end,
      }

    })
  end,
}
