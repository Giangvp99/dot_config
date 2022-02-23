--
-- battery.lua
-- battery status widget
--

local wibox = require("wibox")
local beautiful = require("beautiful")
local set_foreground = require("helpers").set_foreground

-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- define buttons
-- get battery
local get_battery = function(percentage, status, time)
	local icon = ""
	if percentage == nil then
		return set_foreground(beautiful.battery_fg_error, beautiful.battery_error)
	end
	local rounded = math.ceil(percentage / 10) * 10
	if status == "Unknown" then
		icon = beautiful.battery_plugged
		return set_foreground(beautiful.battery_fg_unknown, icon)
	elseif status == "Charging" then
		if rounded >= 90 then
			icon = beautiful.battery_charging_90
		elseif rounded >= 80 then
			icon = beautiful.battery_charging_80
		elseif rounded >= 60 then
			icon = beautiful.battery_charging_60
		elseif rounded >= 40 then
			icon = beautiful.battery_charging_40
		elseif rounded >= 30 then
			icon = beautiful.battery_charging_30
		else
			icon = beautiful.battery_charging_xx
		end
		return set_foreground(beautiful.battery_fg_charging, icon .. string.format("%.0f ", percentage) .. time)
	elseif status == "Full" then
		return set_foreground(beautiful.battery_fg_full, beautiful.battery_full)
	else
		if rounded >= 80 then
			icon = beautiful.battery_discharging_80
		elseif rounded >= 60 then
			icon = beautiful.battery_discharging_60
		elseif rounded >= 40 then
			icon = beautiful.battery_discharging_40
		elseif rounded >= 20 then
			icon = beautiful.battery_discharging_20
		else
			icon = beautiful.battery_discharging_xx
		end
		return set_foreground(beautiful.battery_fg_discharging, icon .. string.format("%.0f ", percentage) .. time)
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
			markup = beautiful.widget_loading,
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
