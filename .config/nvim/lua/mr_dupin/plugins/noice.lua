-- https://github.com/folke/noice.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
    presets = { inc_rename = true },
    views = {
      cmdline_popup = {
        position = {
          row = 7,
          col = '55%',
        },
      },
      cmdline_popupmenu = {
        position = {
          row = 7,
          col = '55%',
        },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#2E3440',
        stages = 'static',
        timeout = 2000,
      },
    },
  },
}
