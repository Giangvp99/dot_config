--
-- key.lua
-- Keybindings and buttons
--

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local keys = require("config.keys.map")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local modkey = keys.modkey
local ctrlkey = keys.ctrlkey --resize, layout
local shiftkey = keys.shiftkey --swap
local leftclick = keys.leftclick

local global = {}

-- Mouse buttons on desktop
global.desktopbuttons = awful.util.table.join(awful.button({}, leftclick, function()
	naughty.destroy_all_notifications()
end))

-- ========================================
-- Global Keybindings
-- ========================================

global.keys = awful.util.table.join(
	-- ========================================
	-- Awesome General
	-- ========================================
	awful.key({ modkey, shiftkey }, "/", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey, shiftkey }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey }, "Escape", function()
		awesome.emit_signal("exit_screen::show")
	end, { description = "show exit screen", group = "awesome" }),

	awful.key({}, "XF86PowerOff", function()
		awesome.emit_signal("exit_screen::show")
	end, { description = "show exit screen", group = "awesome" }),

	awful.key({ modkey }, "Tab", function()
		awful.screen.focused().window_switcher:show()
	end, { description = "activate window switcher", group = "awesome" }),

	awful.key({ modkey }, "s", function()
		awesome.emit_signal("widget::systray::toggle")
	end, { description = "toggle systray", group = "awesome" }),

	-- ========================================
	-- Gap control
	-- ========================================
	awful.key({ modkey, shiftkey }, "minus", function()
		awful.tag.incgap(5, nil)
	end, { description = "increment gaps size for current tag", group = "tag" }),

	awful.key({ modkey }, "minus", function()
		awful.tag.incgap(-5, nil)
	end, { description = "decrement gaps size for current tag", group = "tag" }),

	-- ========================================
	-- Layout selection
	-- ========================================
	awful.key({ modkey, shiftkey }, ".", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, shiftkey }, ",", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, ctrlkey }, "m", function()
		awful.layout.set(awful.layout.suit.max)
	end, { description = "select max layout", group = "layout" }),

	awful.key({ modkey, ctrlkey }, "t", function()
		awful.layout.set(awful.layout.suit.tile)
	end, { description = "select tile layout", group = "layout" }),

	-- awful.key({ modkey, shiftkey }, "s", function()
	-- awful.layout.set(awful.layout.suit.floating)
	-- end, { description = "select floating layout", group = "layout" }),

	-- ========================================
	-- Applications
	-- ========================================
	awful.key({ modkey }, ";", function()
		awesome.emit_signal("floating_terminal::toggle")
	end, { description = "toggle floating terminal", group = "hotkeys" }),

	awful.key({ modkey }, "Return", function()
		awful.spawn(Apps.terminal)
	end, { description = "terminal", group = "hotkeys" }),

	awful.key({ modkey }, "w", function()
		awful.spawn.with_shell([[ notify-send "Current Weather" "$(curl "wttr.in?T0")" ]])
	end, { description = "get current weather", group = "hotkeys" }),

	awful.key({ modkey }, "'", function()
		awful.spawn(Apps.launcher)
	end, { description = "application launcher", group = "hotkeys" }),

	awful.key({ modkey }, "b", function()
		awful.spawn(Apps.web_browser)
	end, { description = "web browser", group = "hotkeys" }),

	-- ========================================
	-- Client
	-- ========================================

	awful.key({ modkey, shiftkey }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- ========================================
	-- Screenshot
	-- ========================================
	awful.key({}, "Print", function()
		awful.spawn.with_shell(Apps.screenshot .. "  | xclip -sel clip -t image/png")
		naughty.notify({
			icon = beautiful.icons_path .. "screenshot.svg",
			title = "Screenshot",
			text = "Screenshot of screen stored in clipboard.",
		})
	end, { description = "take a screenshot", group = "hotkeys" }),

	awful.key({ modkey }, "Print", function()
		os.execute(Apps.screenshot .. " -s  | xclip -sel clip -t image/png")
		naughty.notify({
			icon = beautiful.icons_path .. "screenshot.svg",
			title = "Screenshot",
			text = "Screenshot of selected area stored in clipboard.",
		})
	end, { description = "take a screenshot selection", group = "hotkeys" }),

	awful.key({ modkey, shiftkey }, "Print", function()
		awful.spawn.with_shell(Apps.screenshot .. " -d 5 | xclip -sel clip -t image/png")

		gears.timer({
			timeout = 5,
			autostart = true,
			single_shot = true,
			callback = function()
				naughty.notify({
					icon = beautiful.icons_path .. "screenshot.svg",
					title = "Screenshot",
					text = "Screenshot of screen stored in clipboard.",
				})
			end,
		})
	end, { description = "take a screenshot after 5 secs", group = "hotkeys" }),

	-- ========================================
	-- Language
	-- ========================================
	awful.key({ modkey }, "space", helpers.switch_language, { description = "switch language", group = "hotkeys" }),

	-- ========================================
	-- Function keys
	-- ========================================
	-- Brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		helpers.change_brightness(5)
	end, { description = "brightness up", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		helpers.change_brightness(-5)
	end, { description = "brightness down", group = "hotkeys" }),

	-- Volume/Playback
	awful.key({ shiftkey }, "Control_L", helpers.switch_caplock, { description = "switch caplock", group = "hotkeys" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		helpers.change_volume(5)
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		helpers.change_volume(-5)
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({}, "XF86AudioMute", helpers.toggle_volume_mute, { description = "toggle mute", group = "hotkeys" }),
	awful.key({}, "XF86AudioNext", helpers.media_next, { description = "next track", group = "hotkeys" }),
	awful.key({}, "XF86AudioPrev", helpers.media_prev, { description = "previous track", group = "hotkeys" }),
	awful.key({}, "XF86AudioPlay", helpers.media_play_pause, { description = "play/pause music", group = "hotkeys" })
)

-- Bind all key numbers to tags
for i = 1, #Tags do
	local tag_name = string.format("#%s: %s", i, Tags[i].name)

	global.keys = awful.util.table.join(
		global.keys,
		-- Switch to tags
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]

			if tag then
				tag:view_only()
			end
		end, { description = "view tag " .. tag_name, group = "tag" }),

		-- Toggle tag display
		awful.key({ modkey, ctrlkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag " .. tag_name, group = "tag" }),

		-- Move client to tag.
		awful.key({ modkey, shiftkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag " .. tag_name, group = "tag" }),

		-- Toggle tag on focused client.
		awful.key({ modkey, ctrlkey, shiftkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag " .. tag_name, group = "tag" })
	)
end

return global
