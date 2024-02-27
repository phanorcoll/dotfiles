vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", {
  desc = "Toggle [L]azy[G]it",
})
return {
  "kdheepak/lazygit.nvim",
  require("lazy").setup({
    {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
  })
}
