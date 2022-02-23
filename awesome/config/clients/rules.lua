--
-- rules.lua
-- Client rules
--

local awful = require("awful")
local beautiful = require("beautiful")
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height
local clientkeys = require("config.clients.keys")
local clientbuttons = require("config.clients.buttons")
local rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Pavucontrol & Bluetooth Devices
	{
		rule_any = {
			class = {
				"Pavucontrol",
			},
		},
		properties = {
			width = screen_width * 0.30,
			height = screen_height * 0.50,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin",
				"Sxiv",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"Pavucontrol",
				"plasmashell",
				"Plasma",
				"Nm-connection-editor",
			},
			name = {
				"Bluetooth Devices",
				"Event Tester", -- xev.
				"Steam Guard - Computer Authorization Required",
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
				"GtkFileChooserDialog",
			},
			type = {
				"dialog",
			},
		},
		properties = {
			placement = awful.placement.centered,
			floating = true,
		},
	},

	{
		rule_any = {
			class = {
				"kitty",
				"Alacritty",
			},
		},
		properties = {
			tag = "code",
		},
	},
	{
		rule_any = {
			class = {
				"Thunar",
			},
		},
		properties = {
			tag = "media",
		},
	},
	{
		rule_any = {
			class = { "Brave", "firefox" },
		},
		properties = {
			tag = "web",
			switchtotag = true,
		},
	},
}

awful.rules.rules = rules
