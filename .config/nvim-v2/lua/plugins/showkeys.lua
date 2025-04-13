-- url: https://github.com/nvzone/showkeys
-- desc: Eye-candy keys screencaster for Neovim
return { 
    "nvzone/showkeys", 
    lazy = false,    -- Load on startup instead of waiting for a command
    config = function()
      -- Automatically toggle Showkeys on startup
      vim.cmd("ShowkeysToggle")
    end
}
