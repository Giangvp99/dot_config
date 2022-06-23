local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, percentage)
	local icon = nil
	if percentage <= 30 then
		icon = beautiful.brightness_xx
	elseif percentage > 30 and percentage <= 60 then
		icon = beautiful.brightness_30
	elseif percentage > 60 then
		icon = beautiful.brightness_60
	end

	helpers.update_widget(widget).markup = helpers.set_foreground(beautiful.brightness_fg, icon .. percentage)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::brightness::percentage", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
