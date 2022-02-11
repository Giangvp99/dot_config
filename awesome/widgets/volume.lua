--
-- volume.lua
-- volume widget
--

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local helpers = require("helpers")
local keys = require("config.keys.map")

-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- define buttons
local buttons = function(screen)
	return gears.table.join(
		awful.button({}, keys.leftclick, function()
			awful.spawn(Apps.volume_manager)
		end),
		awful.button({}, keys.rightclick, function()
			helpers.toggle_volume_mute()
		end),
		awful.button({}, keys.scrolldown, function()
			helpers.change_volume(5)
		end),
		awful.button({}, keys.scrollup, function()
			helpers.change_volume(-5)
		end)
	)
end

-- update widget percentage
local update_widget_percentage = function(widget, percentage)
	local icon = ""
	if percentage <= 15 then
		icon = "奄 "
	elseif percentage > 15 and percentage <= 50 then
		icon = "奔 "
	elseif percentage > 50 and percentage <= 80 then
		icon = "墳 "
	elseif percentage > 80 then
		icon = " "
	end
	widget.markup = helpers.set_foreground(beautiful.color.lightblue, icon .. percentage)
end

-- update widget mute
local update_widget_mute = function(widget)
	widget.markup = "婢 "
	-- widget.tooltip.text = "Volume is muted"
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		markup = "勒",
		widget = wibox.widget.textbox,
	})
	awesome.connect_signal("daemon::volume::percentage", function(...)
		update_widget_percentage(widget, ...)
	end)
	awesome.connect_signal("daemon::volume::muted", function()
		update_widget_mute(widget)
	end)

	local container = require("widgets.clickable_container")(widget)
	container:buttons(buttons(screen))

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Volume status unknown"

	return container
end

return create_widget