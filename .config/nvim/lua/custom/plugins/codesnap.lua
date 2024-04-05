-- https://github.com/mistricky/codesnap.nvim
return {
  "mistricky/codesnap.nvim",
  build = "make",
  config = function()
    require("codesnap").setup({
      has_breadcrumbs = true,
      bg_theme = "grape",
      watermark = "Mr.Dupin",
      save_path = "/home/developer/h.png",
    })
  end,
}
