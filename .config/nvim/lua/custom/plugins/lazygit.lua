vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", {
  desc = "Toggle [L]azy[G]it",
})
return {
  "kdheepak/lazygit.nvim",
  config = function()
    require("lazy").setup({
      {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        cmd = {
          "LazyGit",
          "LazyGitConfig",
          "LazyGitCurrentFile",
          "LazyGitFilter",
          "LazyGitFilterCurrentFile",
        },
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim",
        },
      },
    })
  end,
}
