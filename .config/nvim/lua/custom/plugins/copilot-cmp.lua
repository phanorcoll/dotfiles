return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", "nvim-cmp" },
  config = function()
    require("copilot_cmp").setup({})
  end
}
