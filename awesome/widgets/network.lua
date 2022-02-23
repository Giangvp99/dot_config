--
-- network.lua
-- simple network widget
-- dependencies: iproute2, iw
--

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local set_foreground = require("helpers").set_foreground
local keys = require("config.keys.map")

-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- define buttons
local buttons = function(screen)
	return gears.table.join(awful.button({}, keys.leftclick, function()
		awful.spawn(Apps.network_manager)
	end))
end

-- update wireless status
local update_wireless_status = function(widget, interface, healthy, essid, bitrate, strength)
	local status = healthy and "Connected to internet" or "Connected but no internet!"

	widget.markup = set_foreground(beautiful.network_fg, beautiful.network_icon .. essid)
	widget.tooltip.markup = string.format(
		"<b>%s</b>"
			.. "\nESSID: <b>%s</b>"
			.. "\nInterface: <b>%s</b>"
			.. "\nStrength: <b>%s%%</b>"
			.. "\nBitrate: <b>%s</b>",
		status,
		essid,
		interface,
		strength,
		bitrate
	)
end

-- update wired status
local update_wired_status = function(widget, interface, healthy)
	local status = healthy and "Connected to internet" or "Connected but no internet!"

	local icon_name = healthy and "wired" or "wired-alert"

	widget.image = icons_path .. icon_name .. ".svg"
	widget.tooltip.markup = string.format("<b>%s</b>" .. "\nInterface: <b>%s</b>", status, interface)
end

-- update disconnected status
local update_disconnected = function(widget, mode)
	if mode == "wireless" then
		return "睊 "
	elseif mode == "wired" then
		return "unknown"
	end

	widget.tooltip.text = "Network is currently disconnected"
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		markup = beautiful.widget_loading,
		widget = wibox.widget.textbox,
	})

	awesome.connect_signal("daemon::network::status::wireless", function(...)
		update_wireless_status(widget, ...)
	end)
	awesome.connect_signal("daemon::network::status::wired", function(...)
		update_wired_status(widget, ...)
	end)
	awesome.connect_signal("daemon::network::disconnected::wireless", function()
		update_disconnected(widget, "wireless")
	end)
	awesome.connect_signal("daemon::network::disconnected::wired", function()
		update_disconnected(widget, "wired")
	end)

	local container = require("widgets.clickable_container")(widget)
	container:buttons(buttons(screen))

	widget.tooltip = require("widgets.tooltip")({ container })
	widget.tooltip.text = "Network status unknown"

	return container
end

return create_widget
