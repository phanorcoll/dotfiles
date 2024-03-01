-- https://github.com/sindrets/diffview.nvim
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", {
  desc = "Open diff view [g][d]"
})
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", {
  desc = "Close diff view close [g][D]"
})
vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>", {
  desc = "Close diff view refresh  [g][d][r]"
})
vim.keymap.set("n", "<leader>gvh", "<cmd>DiffviewFileHistort<CR>", {
  desc = "Close diff view file history [g][v][h] "
})
return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      opts = {
        file_panel = {
          position = "bottom",
          height = 20,
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- Change local options in diff buffers
          vim.opt_local.wrap = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
        view_opened = function(view)
          local stdout = vim.loop.new_tty(1, false)
          if stdout ~= nil then
            stdout:write(
              ("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format("DIFF_VIEW", vim.fn.system({ "base64" }, "+4"))
            )
            vim.cmd([[redraw]])
          end
        end,
        view_closed = function()
          local stdout = vim.loop.new_tty(1, false)
          if stdout ~= nil then
            stdout:write(
              ("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format("DIFF_VIEW", vim.fn.system({ "base64" }, "-1"))
            )
            vim.cmd([[redraw]])
          end
        end,
      }

    })
  end,
}
