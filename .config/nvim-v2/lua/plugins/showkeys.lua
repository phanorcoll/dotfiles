-- url: https://github.com/nvzone/showkeys
-- desc: Eye-candy keys screencaster for Neovim
return { 
    "nvzone/showkeys", 
    lazy = false,    -- Load on startup instead of waiting for a command
    config = function()
      require("showkeys").setup({
        maxkeys=5
      })

      vim.cmd("ShowkeysToggle")
    end
}
