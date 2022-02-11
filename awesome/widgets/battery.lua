--
-- battery.lua
-- battery status widget
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
		awful.spawn(Apps.power_manager)
	end))
end

-- get battery
local get_battery = function(percentage, status, time)
	local icon = ""
	if percentage == nil then
		return set_foreground(beautiful.color.darkred, "")
	end
	local rounded = math.ceil(percentage / 10) * 10
	if status == "Unknown" then
		icon = " "
		return set_foreground(beautiful.color.lightgreen, icon)
	elseif status == "Charging" then
		if rounded >= 90 then
			icon = " "
		elseif rounded >= 80 then
			icon = " "
		elseif rounded >= 60 then
			icon = " "
		elseif rounded >= 40 then
			icon = " "
		elseif rounded >= 30 then
			icon = " "
		else
			icon = " "
		end
		return set_foreground(beautiful.color.darkgreen, icon .. string.format("%.0f ", percentage) .. time)
	elseif status == "Full" then
		return set_foreground(beautiful.color.darkaqua, "")
	else
		if rounded >= 80 then
			icon = " "
		elseif rounded >= 60 then
			icon = " "
		elseif rounded >= 40 then
			icon = " "
		elseif rounded >= 20 then
			icon = " "
		else
			icon = " "
		end
		return set_foreground(beautiful.color.darkyellow, icon .. string.format("%.0f ", percentage) .. time)
	end
end

-- update widget
local update_widget = function(widget, _, stat, _)
	widget.widget.markup = get_battery(stat.percentage, stat.status, stat.time)
	-- widget.tooltip.text = stat.time
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		{
			markup = "勒",
			widget = wibox.widget.textbox,
		},
	})
	awesome.connect_signal("daemon::battery::status", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)
	-- container:buttons(buttons(screen))

	return widget
end

return create_widget
