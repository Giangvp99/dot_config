local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("config.keys.map")

-- define buttons
local buttons = function(screen)
	return gears.table.join(awful.button({}, keys.leftclick, function()
		awful.spawn(Apps.network_manager)
	end))
end

-- update wireless status
local update_wireless_status = function(widget, interface, healthy, essid, bitrate, strength)
	local status = healthy and "Connected to internet" or "Connected but no internet!"

	helpers.update_widget(widget).markup = helpers.set_foreground(beautiful.network_fg, beautiful.network_icon .. essid)
	helpers.update_widget(widget).tooltip.markup = string.format(
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

	-- widget.image = icons_path .. icon_name .. ".svg"
	helpers.update_widget(widget).tooltip.markup = string.format("<b>%s</b>" .. "\nInterface: <b>%s</b>", status, interface)
end

-- update disconnected status
local update_disconnected = function(widget, mode)
	if mode == "wireless" then
		return "睊 "
	elseif mode == "wired" then
		return "unknown"
	end

	helpers.update_widget(widget).tooltip.text = "Network is currently disconnected"
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

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

	helpers.update_widget(widget).tooltip = require("widgets.tooltip")({ container })
	helpers.update_widget(widget).tooltip.text = "Network status unknown"

	return container
end

return create_widget
