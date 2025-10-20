local wezterm = require("wezterm")
local scheme = require("colors.horizon")

local function pick(k, default)
  return (scheme and scheme[k]) or default
end

local function first_present(keys, default)
  for _, k in ipairs(keys) do
    if scheme and scheme[k] then
      return scheme[k]
    end
  end
  return default
end

local BASE_BG = pick("background", "#1c1e26")
local BASE_FG = pick("foreground", "#c0c4cc")

local ACTIVE_BG = first_present(
  {
    { "brights" },
  },
  nil
)

if type(ACTIVE_BG) == "table" then
  ACTIVE_BG = ACTIVE_BG[6] or ACTIVE_BG[5] or ACTIVE_BG[7] or BASE_FG
else
  ACTIVE_BG = (scheme and scheme.brights and scheme.brights[6])
      or (scheme and scheme.ansi and scheme.ansi[5])
      or BASE_FG
end

local ACTIVE_FG = first_present(
  { "cursor_fg", "selection_fg" },
  "#111111"
)

local INACTIVE_BG = BASE_BG
local INACTIVE_FG = "#969dc7"

local ICON_ACTIVE = ACTIVE_FG
local ICON_INACTIVE = pick("ansi", {})[5] or "#586074"

local LEFT_END = utf8.char(0xE0B6)
local RIGHT_END = utf8.char(0xE0B4)

local M = {}

function M.apply_to_config(config)
  config.use_fancy_tab_bar = true
  config.show_new_tab_button_in_tab_bar = false
  config.show_close_tab_button_in_tabs = false
  config.tab_and_split_indices_are_zero_based = true

  wezterm.on("format-tab-title", function(tab, _tabs, _panes, _cfg, _hover, max_width)
    local title = tab.tab_title
    if not (title and #title > 0) then
      title = tab.active_pane.title
    end
    title = wezterm.truncate_right(title, math.max(0, max_width - 2))

    local tab_bg = tab.is_active and ACTIVE_BG or INACTIVE_BG
    local tab_fg = tab.is_active and ACTIVE_FG or INACTIVE_FG
    local icon_fg = tab.is_active and ICON_ACTIVE or ICON_INACTIVE
    local icon = tab.is_active and wezterm.nerdfonts.md_ghost or wezterm.nerdfonts.md_ghost_off_outline

    return {
      { Background = { Color = BASE_BG } },
      { Foreground = { Color = tab_bg } },
      { Text = LEFT_END },

      { Background = { Color = tab_bg } },
      { Foreground = { Color = icon_fg } },
      { Text = " " .. icon .. " " },

      { Background = { Color = tab_bg } },
      { Foreground = { Color = tab_fg } },
      { Text = title .. "  " },

      { Background = { Color = BASE_BG } },
      { Foreground = { Color = tab_bg } },
      { Text = RIGHT_END },
    }
  end)
end

return M
