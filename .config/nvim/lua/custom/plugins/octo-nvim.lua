-- https://github.com/pwntester/octo.nvim
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
