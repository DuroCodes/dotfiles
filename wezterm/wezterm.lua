local wezterm = require("wezterm")
local colors = require("colors.horizon")

local config = wezterm.config_builder()
local action = wezterm.action

config.color_schemes = { Horizon = colors }
config.color_scheme = "Horizon"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 14.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.default_cursor_style = "SteadyBar"

config.window_close_confirmation = 'NeverPrompt'
config.quit_when_all_windows_are_closed = true


config.window_decorations = "RESIZE"
-- config.window_padding = { top = 72 }
-- config.tab_bar_at_bottom = true

config.window_frame = {
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  font_size = 14.0,
  inactive_titlebar_bg = colors.background,
  active_titlebar_bg = colors.background,
  -- inactive_titlebar_bg = "none",
  -- active_titlebar_bg = "none",
}

config.keys = {
  -- Word left/right
  { mods = "OPT",       key = "LeftArrow",  action = action.SendKey({ mods = "ALT", key = "b" }) },
  { mods = "OPT",       key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },

  -- Line start/end
  { mods = "CMD",       key = "LeftArrow",  action = action.SendKey({ mods = "CTRL", key = "a" }) },
  { mods = "CMD",       key = "RightArrow", action = action.SendKey({ mods = "CTRL", key = "e" }) },

  -- Kill to start of line
  { mods = "CMD",       key = "Backspace",  action = action.SendKey({ mods = "CTRL", key = "u" }) },

  -- Kill to end of line
  { mods = "CMD",       key = "Delete",     action = action.SendKey({ mods = "CTRL", key = "k" }) },

  -- Delete previous/next word
  { mods = "OPT",       key = "Backspace",  action = action.SendKey({ mods = "CTRL", key = "w" }) },
  { mods = "OPT",       key = "Delete",     action = action.SendKey({ mods = "ALT", key = "d" }) },

  -- Override default close-tab shortcuts to never prompt
  { mods = "CMD",       key = "w",          action = action.CloseCurrentTab({ confirm = false }) },

  -- Optional: close window without prompt
  { mods = "CMD|SHIFT", key = "w",          action = action.CloseCurrentPane({ confirm = false }) },

  -- Open new window instead of new tab
  { mods = "CMD",       key = "t",          action = action.SpawnWindow },

  -- Close current window instead of all instances
  { mods = "CMD",       key = "q",          action = action.CloseCurrentPane({ confirm = false }) },
}

-- local tabs_settings = require("modules.tabs")
-- tabs_settings.apply_to_config(config)
config.enable_tab_bar = false

return config
