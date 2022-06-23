local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- define buttons
-- get battery
local get_battery = function(percentage, status, time)
	local icon = ""
	if percentage == nil then
		return helpers.set_foreground(beautiful.battery_fg_error, beautiful.battery_error)
	end
	local rounded = math.ceil(percentage / 10) * 10
	if status == "Unknown" then
		icon = beautiful.battery_plugged
		return helpers.set_foreground(beautiful.battery_fg_unknown, icon)
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
		return helpers.set_foreground(beautiful.battery_fg_charging, icon .. string.format("%.0f ", percentage) .. time)
	elseif status == "Full" then
		return helpers.set_foreground(beautiful.battery_fg_full, beautiful.battery_full)
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
		return helpers.set_foreground(beautiful.battery_fg_discharging, icon .. string.format("%.0f ", percentage) .. time)
	end
end

-- update widget
local update_widget = function(widget, _, stat, _)
	helpers.update_widget(widget).markup = get_battery(stat.percentage, stat.status, stat.time)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::battery::status", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
