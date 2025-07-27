-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.initial_cols = 190
config.initial_rows = 40

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 15
config.color_scheme = "Afterglow"

config.enable_tab_bar = true
config.window_decorations = "NONE"
config.window_background_opacity = 0.96

-- Finally, return the configuration to wezterm:
return config
