local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }

return config
