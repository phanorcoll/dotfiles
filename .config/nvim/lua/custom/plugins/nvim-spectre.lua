-- https://github.com/nvim-pack/nvim-spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle [S]pectre"
})
vim.keymap.set('n', '<leader>Sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "[S]earch current [w]ord"
})
vim.keymap.set('v', '<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "[S]earch current [w]ord"
})
vim.keymap.set('n', '<leader>Sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "[S]earch on current file. [p]"
})
return {
  "nvim-pack/nvim-spectre",
  config = function()
    require('spectre').setup({
      color_devicons    = true,
      lnum_for_results  = true, -- show line number for search/replace results
      is_block_ui_break = true,
      line_sep_start    = '-------------------------------------------------------------------',
      result_padding    = '   ',
      line_sep          = '-------------------------------------------------------------------',
      highlight         = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete"
      },
    })
  end,
}
