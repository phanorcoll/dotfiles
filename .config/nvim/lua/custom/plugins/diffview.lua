-- https://github.com/sindrets/diffview.nvim
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", {
  desc = "Open [d]iff [v]iew"
})
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", {
  desc = "Close [d]iff view [c]"
})
vim.keymap.set("n", "<leader>dvr", "<cmd>DiffviewRefresh<CR>", {
  desc = "[d]iff [v]iew [r]efresh"
})
vim.keymap.set("n", "<leader>gvh", "<cmd>DiffviewFileHistort<CR>", {
  desc = "[d]iff [v]iew file [h]istory "
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
