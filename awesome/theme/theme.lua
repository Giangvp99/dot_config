--
-- theme.lua
-- Theme config
--

local gears = require("gears")
local helpers = require("helpers")
local dpi = require("beautiful").xresources.apply_dpi

local theme = {}

-- ========================================
-- Variables
-- ========================================
local color = require("theme.color")
theme.color = color
-- Theme font
local font = "FiraCode Nerd Font"

-- ========================================
-- Icons
-- ========================================

-- Icons path
theme.icons_path = gears.filesystem.get_configuration_dir() .. "theme/icons/"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "zafiro-icon-theme"

-- ========================================
-- Common
-- ========================================

-- Font
theme.basic_font = font
theme.font = font .. " 11"

-- Background
theme.bg_normal = color.black
theme.bg_dark = color.black
theme.bg_focus = color.black
theme.bg_urgent = color.black
theme.bg_minimize = color.black
theme.bg_systray = color.black

-- Foreground
theme.fg_normal = color.lightwhite
theme.fg_focus = color.lightblue
theme.fg_urgent = color.lightred
theme.fg_minimize = color.darkblue

-- Borders/Gaps
theme.useless_gap = dpi(4)
theme.screen_margin = theme.useless_gap
theme.border_width = dpi(2)
theme.border_radius = dpi(1)
theme.border_focus = color.lightblue
theme.border_marked = color.lightred
theme.border_normal = color.black

-- Tooltips
theme.tooltip_font = theme.font
theme.tooltip_padding_x = dpi(10)
theme.tooltip_padding_y = dpi(10)

-- Notification
theme.notification_width = dpi(350)
theme.notification_margin = dpi(15)
theme.notification_border_width = dpi(0)
theme.notification_icon_size = dpi(48)
theme.notification_fg = color.lightwhite
theme.notification_bg = color.darkblue .. "aa"
theme.notification_bg_critical = color.lightred .. "aa"
theme.notification_font = theme.font

-- ========================================
-- Components
-- ========================================

-- Topbar
theme.topbar_position = "top"
theme.topbar_height = dpi(28)
theme.topbar_margin = dpi(0)
theme.topbar_padding_x = dpi(8)

-- Leftbar
theme.leftbar_position = "bot"
theme.leftbar_width = dpi(38)
theme.leftbar_margin = dpi(0)
theme.leftbar_padding_x = dpi(5)

-- Exit screen
theme.exit_screen_bg = theme.bg_normal .. "aa"
theme.exit_screen_button_spacing = dpi(48)
theme.exit_screen_caption_spacing = dpi(8)
theme.exit_screen_icon_size = dpi(48)

-- Lock screen
theme.lock_screen_icons_path = theme.icons_path .. "lock_screen/"

theme.lock_screen_bg = theme.bg_normal .. "aa"
theme.lock_screen_width = dpi(800)
theme.lock_screen_spacing_x = dpi(10)
theme.lock_screen_spacing_y = dpi(30)

theme.lock_screen_title_icon = theme.lock_screen_icons_path .. "lock_screen_padlock.svg"
theme.lock_screen_title_icon_size = dpi(40)
theme.lock_screen_title_font = font .. " 24"

theme.lock_screen_dot_icon = theme.lock_screen_icons_path .. "lock_screen_dot.svg"
theme.lock_screen_dot_spacing = dpi(5)
theme.lock_screen_dot_color = theme.fg_normal
theme.lock_screen_dot_size = dpi(20)

theme.lock_screen_warning_icon = theme.lock_screen_icons_path .. "lock_screen_warning.svg"

-- Window switcher
theme.window_switcher_bg = theme.bg_normal .. "aa"
theme.window_switcher_margin_x = dpi(20)
theme.window_switcher_margin_y = dpi(25)
theme.window_switcher_width = dpi(500)

theme.window_switcher_spacing_x = dpi(7)
theme.window_switcher_spacing_y = dpi(15)

theme.window_switcher_icon_height = dpi(15)
theme.window_switcher_icon_width = dpi(15)

-- ========================================
-- Widgets
-- ========================================

theme.widget_loading = "勒"

-- Clickable container
theme.clickable_container_padding_x = dpi(10)
theme.clickable_container_padding_y = dpi(7)

-- Systray
theme.systray_icon_spacing = dpi(10)

-- Taglist
theme.taglist_spacing = dpi(5)
theme.taglist_font = font .. " 10"
theme.taglist_fg_empty = color.black2
theme.taglist_fg_occupied = color.white2
theme.taglist_fg_urgent = color.lightred
theme.taglist_fg_focus = color.lightaqua

theme.taglist_focus = " "
theme.taglist_empty = " "
theme.taglist_hidden = " "
-- Tasklist
theme.tasklist_font = theme.font .. " 11"

theme.tasklist_icon_visible = " "
theme.tasklist_icon_hidden = " "

theme.tasklist_fg_normal = color.black2
theme.tasklist_fg_focus = color.lightorange
theme.tasklist_fg_minimized = color.black1
theme.tasklist_fg_floating = color.lightorange

theme.tasklist_normal = " "
theme.tasklist_ontop = " "
theme.tasklist_floating = "柳 "
theme.tasklist_maximized = " "
-- Calendar
theme.calendar_padding = dpi(20)
theme.calendar_spacing = dpi(10)

-- System tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(5)

-- Battery
theme.battery_error = ""
theme.battery_plugged = " "
theme.battery_full = ""
theme.battery_charging_90 = " "
theme.battery_charging_80 = " "
theme.battery_charging_60 = " "
theme.battery_charging_40 = " "
theme.battery_charging_30 = " "
theme.battery_discharging_80 = " "
theme.battery_discharging_60 = " "
theme.battery_discharging_40 = " "
theme.battery_discharging_20 = " "
theme.battery_discharging_xx = " "
theme.battery_fg_error = color.darkred
theme.battery_fg_unknown = color.lightgreen
theme.battery_fg_charging = color.darkgreen
theme.battery_fg_full = color.darkaqua
theme.battery_fg_discharging = color.darkyellow

-- Layout
theme.layout_fg = color.white1
theme.layout_max = " "
theme.layout_tile = " "

-- Memory
theme.memory_fg = color.lightred
theme.memory_icon = " "

-- Network
theme.network_fg = color.lightaqua
theme.network_icon = " "

-- Capslock
theme.capslock_font = font .. " 14"
theme.capslock_icon = ""
theme.capslock_off_fg = color.black2
theme.capslock_on_fg = color.white1
-- Speednet
theme.speednet_fg = color.darkyellow
theme.speednet_icon = "龍 "

-- Brightness
theme.brightness_xx = " "
theme.brightness_30 = " "
theme.brightness_60 = " "
theme.brightness_fg = color.lightorange

-- Cpu
theme.cpu_fg = color.darkred
theme.cpu_icon = " "

-- Filesystem
theme.fs_home = " "
theme.fs_home_fg = color.lightgreen
theme.fs_root = " "
theme.fs_root_fg = color.darkgreen

-- Language
theme.language_icon = " "
theme.language_fg = color.lightpurple

-- Updates
theme.updates_normal = " "
theme.updates_none = " "
theme.updates_normal_fg = color.lightyellow
theme.updates_none_fg = color.lightaqua

-- Volume
theme.volume_fg = color.lightblue
theme.volume_xx = "奄 "
theme.volume_15 = "奔 "
theme.volume_50 = "墳 "
theme.volume_80 = " "
theme.volume_mute = "婢 "

-- Hotkeys
theme.hotkeys_font = font .. " Bold 10"
theme.hotkeys_description_font = font .. " 10"
theme.hotkeys_bg = color.black .. "aa"
theme.hotkeys_border_width = dpi(0)
theme.hotkeys_shape = helpers.rrect
theme.hotkeys_modifiers_fg = color.lightyellow
theme.hotkeys_label_fg = color.lightwhite
theme.hotkeys_label_bg = color.darkblue
theme.hotkeys_group_margin = dpi(40)

return theme
