-- url: https://github.com/iamcco/markdown-preview.nvim
-- desc: Markdown Preview for (Neo)vim
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  keys = {
    { '<leader>mp', "<cmd>MarkdownPreviewToggle<cr>", desc = 'Toggles Markdown Preview' },
  },
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
