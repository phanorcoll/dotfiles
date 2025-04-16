-- url: https://github.com/rmagatti/auto-session
-- desc: Auto save and restore the last session
return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    log_level = 'error',
  }
}
