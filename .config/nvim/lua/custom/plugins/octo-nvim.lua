-- https://github.com/pwntester/octo.nvim
-- NOTE: workaround for current bug
-- https://github.com/pwntester/octo.nvim/issues/466
vim.g.octo_viewer = "phanorcoll"
return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- OR 'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require "octo".setup({
      enable_builtin = true,
      mappings = {
        review_diff = {
          select_next_entry = { lhs = "<Tab>", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "<S-Tab>", desc = "move to next changed file" },
        }
      }
    })
    vim.treesitter.language.register("markdown", "octo")
    -- vim.cmd([[hi OctoEditable guibg=none]])
  end,
  keys = {
    { "<leader>O", "<cmd>Octo<cr>", desc = "Octo" }
  }
}
